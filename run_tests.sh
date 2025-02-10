#!/usr/bin/env bash

#
# Test setup
#

if [[ -n $GT_VERBOSE ]]; then
  set -x # Echo command execution
fi

TEST_FILTER=${1}
FAIL_COUNT=0
IMAGE_WIDTH=640

TMP_DIR=$(mktemp -d)
mkdir -p tests/output
cd tests

if [ ${GT_DISABLE_CONVERSION:-0} -ne 0 ]; then
    rm -rf output/*.png
else
    rm -rf output/*
fi

exec >  >(tee -ia output/log.txt)
exec 2> >(tee -ia output/log.txt >&2)

#
# Helper functions
#

print_error()
{
    FAIL_COUNT=$((FAIL_COUNT+1))
    printf "\e[31m >>>>> Command execution failed! <<<<< \e[39m\n" >&2
}

# $1: test name
skip_or_print_test()
{
    # Check if the test name matches the provided filter string.
    #
    # We use a pattern similar to GTest: "<ALLOWED>-<DISALLOWED>". This is because grep on macOS
    # does not have negative regex lookahead and thus requires two regular expressions for exclusion.
    IFS='-' read -ra FILTER_PARTS <<< "$TEST_FILTER"

    if [ -z "$TEST_FILTER" ] || { { echo \"$1\" | grep -Eq "${FILTER_PARTS[0]}"; } && { [ -z "${FILTER_PARTS[1]}" ] || ! { echo \"$1\" | grep -Eq "${FILTER_PARTS[1]}"; } } }; then
        echo ========= Test $1 =========
        return 1
    else
        return 0
    fi
}

# $1: test base name
# $2: output image base name
# $3: (opt.) ref image base name
# $4: (opt.) camera name
render_and_compare()
{
    # Call usdrecord with workaround that avoids MSYS2 Unix -> Windows path substitution of USD camera path.
    if [ "$OSTYPE" == "msys" ]; then
        USDRECORD_EXECUTABLE=usdrecord.cmd
    else
        USDRECORD_EXECUTABLE=usdrecord
    fi
    MSYS2_ARG_CONV_EXCL='*' $USDRECORD_EXECUTABLE --enableDomeLightVisibility --disableCameraLight --imageWidth $IMAGE_WIDTH --camera ${4:-"T_Camera"} $1.usda output/$2.png

    if [ $? -ne 0 ]; then
        print_error
        return
    fi

    if [ ${GT_DISABLE_IMGDIFF:-0} -eq 0 ]; then
        # Check render against ref image. Afterwards, we drop the alpha channel to make the failing pixels visible.
        # We use oiiotool for that, but writing to the same file leads to an access denial on Windows. By writing a
        # temporary file to a temporary directory outside of the repository, we avoid pollution in case the script
        # execution is prematurely stopped.
        DIFF_FILE_NAME=$2_diff.png
        TMP_DIFF_FILE="$TMP_DIR/$DIFF_FILE_NAME"

        idiff -o $TMP_DIFF_FILE -od -abs -scale 100 -fail 0.05 -failpercent 0.004 -hardfail 0.2 -warn 0.01 -warnpercent 0.001 output/$2.png ${3:-$2}.png

        IDIFF_RESULT=$?

        if [ $IDIFF_RESULT -ne 0 ]; then

            # Copy ref image to output dir
            cp "${3:-$2}.png" "output/${3:-$2}_ref.png"

            if [[ $IDIFF_RESULT -ne 4 ]]; then
                # Drop the alpha channel
                oiiotool $TMP_DIFF_FILE --no-autopremult -ch R,G,B -o output/$DIFF_FILE_NAME
                # Delete temp file now in case the script is interrupted before the temp dir is deleted
                rm $TMP_DIFF_FILE
            fi

            if [[ $IDIFF_RESULT -ne 1 ]]; then
                print_error
                return
            fi
        fi
    fi
}

# $1: glTF input file path
# $2: usd output file path
# $3+: (opt.) conversion flags
convert_glTF_to_USD()
{
    if [ ${GT_DISABLE_CONVERSION:-0} -eq 0 ]; then
        guc ${@:3} $1 $2

        if [ $? -ne 0 ]; then
            return 1
        fi

        if [ ${GT_DISABLE_USDCHECKER:-0} -eq 0 ]; then
            usdchecker $2
            return $?
        fi
    fi

    return 0
}

# $1: glTF input file path
# $2: usd output file path
# $3+: (opt.) additional conversion flags
convert_glTF_to_hdSt_USD()
{
    convert_glTF_to_USD $1 $2 --emit-mtlx ${@:3}
}

# $1: test base name
# $2: glTF input file path
# $3: usd output file path
# $4: (opt.) diff img base path
# $5+: (opt.) additional conversion flags
test_graphical()
{
    # Unfortunately, there is no way to make HdStorm prefer a MaterialX material binding over a preview material
    # binding. As a workaround, we use a backdoor environment variable to not emit preview material bindings in
    # the conversion process.
    GUC_DISABLE_PREVIEW_MATERIAL_BINDINGS=1 convert_glTF_to_hdSt_USD $2 $3 ${@:5}

    if [ $? -ne 0 ]; then
        print_error
        return
    elif [ ${GT_DISABLE_GRAPHICAL:-0} -eq 0 ] && [ ${GT_DISABLE_GRAPHICAL_MTLX:-0} -eq 0 ]; then
        render_and_compare $1 "$1_mtlx" "${4:-$1}_mtlx"
    fi

    convert_glTF_to_hdSt_USD $2 $3 ${@:5}

    if [ $? -ne 0 ]; then
        print_error
        return
    elif [ ${GT_DISABLE_GRAPHICAL:-0} -eq 0 ] && [ ${GT_DISABLE_GRAPHICAL_PREVIEW:-0} -eq 0 ]; then
        render_and_compare $1 "$1_preview" "${4:-$1}_preview"
    fi
}

# Use bitflags to handle additional asset encodings
GT_SAMPLE_MODEL_FLAG_BINARY=1
GT_SAMPLE_MODEL_FLAG_EMBEDDED=2
GT_SAMPLE_MODEL_FLAG_MESHOPT=4
GT_SAMPLE_MODEL_FLAG_BINARY_AND_EMBEDDED=$(( GT_SAMPLE_MODEL_FLAG_BINARY | GT_SAMPLE_MODEL_FLAG_EMBEDDED ))

# $1: model base name (e.g. 'ToyCar')
# $2: encoding bitflag (e.g. binary | embedded)
test_sampleModel()
{
    if skip_or_print_test $1; then return; fi

    USD_OUTPUT_DIR=output/$1
    USD_OUTPUT_FILE=$USD_OUTPUT_DIR/$1.usd

    # glTF-Binary
    if (( (${2:-0} & GT_SAMPLE_MODEL_FLAG_BINARY) != 0 )); then
        GLTF_INPUT_FILE=input/glTF-Sample-Models/2.0/$1/glTF-Binary/$1.glb

        GUC_DISABLE_PREVIEW_MATERIAL_BINDINGS=1 \
            convert_glTF_to_hdSt_USD $GLTF_INPUT_FILE $USD_OUTPUT_FILE
        if [ $? -ne 0 ]; then print_error; fi

        convert_glTF_to_hdSt_USD $GLTF_INPUT_FILE $USD_OUTPUT_FILE
        if [ $? -ne 0 ]; then print_error; fi

        rm -rf $USD_OUTPUT_DIR
    fi

    # glTF-Embedded
    if (( (${2:-0} & GT_SAMPLE_MODEL_FLAG_EMBEDDED) != 0 )); then
        GLTF_INPUT_FILE=input/glTF-Sample-Models/2.0/$1/glTF-Embedded/$1.gltf

        GUC_DISABLE_PREVIEW_MATERIAL_BINDINGS=1 \
            convert_glTF_to_hdSt_USD $GLTF_INPUT_FILE $USD_OUTPUT_FILE
        if [ $? -ne 0 ]; then print_error; fi

        convert_glTF_to_hdSt_USD $GLTF_INPUT_FILE $USD_OUTPUT_FILE
        if [ $? -ne 0 ]; then print_error; fi

        rm -rf $USD_OUTPUT_DIR
    fi

    # glTF-Meshopt
    if (( (${2:-0} & GT_SAMPLE_MODEL_FLAG_MESHOPT) != 0 )); then
        GLTF_INPUT_FILE=input/glTF-Sample-Models/2.0/$1/glTF-Meshopt/$1.gltf

        GUC_DISABLE_PREVIEW_MATERIAL_BINDINGS=1 \
            convert_glTF_to_hdSt_USD $GLTF_INPUT_FILE $USD_OUTPUT_FILE
        if [ $? -ne 0 ]; then print_error; fi

        convert_glTF_to_hdSt_USD $GLTF_INPUT_FILE $USD_OUTPUT_FILE
        if [ $? -ne 0 ]; then print_error; fi

        rm -rf $USD_OUTPUT_DIR
    fi

    # glTF
    GLTF_INPUT_FILE=input/glTF-Sample-Models/2.0/$1/glTF/$1.gltf
    test_graphical $1 $GLTF_INPUT_FILE $USD_OUTPUT_FILE
}

# $1: model base name (e.g. 'ToyCar')
test_sampleModelDraco()
{
    TEST_NAME=Draco_$1

    if skip_or_print_test $TEST_NAME; then return; fi

    USD_OUTPUT_DIR=output/$TEST_NAME
    USD_OUTPUT_FILE=$USD_OUTPUT_DIR/$TEST_NAME.usd
    GLTF_INPUT_FILE=input/glTF-Sample-Models/2.0/$1/glTF-Draco/$1.gltf

    convert_glTF_to_USD $GLTF_INPUT_FILE $USD_OUTPUT_FILE

    if [ $? -ne 0 ]; then
        print_error
        return
    elif [ ${GT_DISABLE_GRAPHICAL:-0} -eq 0 ] && [ ${GT_DISABLE_GRAPHICAL_PREVIEW:-0} -eq 0 ]; then
        # can't use non-Draco ref because of numerical differences
        render_and_compare $TEST_NAME "${TEST_NAME}_preview"
    fi
}

# $1: category
# $2: test index (string, two digits)
test_generatorAsset()
{
    TEST_NAME=$1_$2

    if skip_or_print_test $TEST_NAME; then return; fi

    GLTF_INPUT_FILE=input/glTF-Asset-Generator/Output/Positive/$1/$TEST_NAME.gltf
    USD_OUTPUT_FILE=output/$TEST_NAME/$TEST_NAME.usd

    test_graphical $TEST_NAME $GLTF_INPUT_FILE $USD_OUTPUT_FILE
}

# $1: test name
# $2: glTF file base path
test_thirdparty()
{
    if skip_or_print_test $1; then return; fi

    test_graphical $1 "input/thirdparty/$2" "output/$1/$1.usd"
}

#
# Test cases
#

##
## Graphical: generator assets
##
IMAGE_WIDTH=400 # match glTF-Asset-Generator render size

# Disabled: animations not supported
#test_generatorAsset "Accessor_Sparse" "00"
#test_generatorAsset "Accessor_Sparse" "01"
test_generatorAsset "Accessor_Sparse" "02"
test_generatorAsset "Accessor_Sparse" "03"
# Disabled: animations not supported
#test_generatorAsset "Accessor_SparseType" "00"
#test_generatorAsset "Accessor_SparseType" "01"
#test_generatorAsset "Accessor_SparseType" "02"
#test_generatorAsset "Accessor_SparseType" "03"
#test_generatorAsset "Accessor_SparseType" "04"
test_generatorAsset "Accessor_SparseType" "05"
#test_generatorAsset "Accessor_SparseType" "06"
# Disabled: animations not supported
#test_generatorAsset "Animation_Node" "00"
#test_generatorAsset "Animation_Node" "01"
#test_generatorAsset "Animation_Node" "02"
#test_generatorAsset "Animation_Node" "03"
#test_generatorAsset "Animation_Node" "04"
#test_generatorAsset "Animation_Node" "05"
# Disabled: animations not supported
#test_generatorAsset "Animation_NodeMisc" "00"
#test_generatorAsset "Animation_NodeMisc" "01"
#test_generatorAsset "Animation_NodeMisc" "02"
#test_generatorAsset "Animation_NodeMisc" "03"
#test_generatorAsset "Animation_NodeMisc" "04"
#test_generatorAsset "Animation_NodeMisc" "05"
#test_generatorAsset "Animation_NodeMisc" "06"
#test_generatorAsset "Animation_NodeMisc" "07"
#test_generatorAsset "Animation_NodeMisc" "08"
# Disabled: animations not supported
#test_generatorAsset "Animation_SamplerType" "00"
#test_generatorAsset "Animation_SamplerType" "01"
#test_generatorAsset "Animation_SamplerType" "02"
# Disabled: animations not supported
#test_generatorAsset "Animation_Skin" "00"
#test_generatorAsset "Animation_Skin" "01"
#test_generatorAsset "Animation_Skin" "02"
#test_generatorAsset "Animation_Skin" "03"
#test_generatorAsset "Animation_Skin" "04"
#test_generatorAsset "Animation_Skin" "05"
#test_generatorAsset "Animation_Skin" "06"
#test_generatorAsset "Animation_Skin" "07"
#test_generatorAsset "Animation_Skin" "08"
#test_generatorAsset "Animation_Skin" "09"
#test_generatorAsset "Animation_Skin" "10"
#test_generatorAsset "Animation_Skin" "11"
# Disabled: animations not supported
#test_generatorAsset "Animation_SkinType" "00"
#test_generatorAsset "Animation_SkinType" "01"
#test_generatorAsset "Animation_SkinType" "02"
#test_generatorAsset "Animation_SkinType" "03"
# Note: vertex colors not supported in preview surface
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Buffer_Interleaved" "00"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Buffer_Interleaved" "01"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Buffer_Interleaved" "02"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Buffer_Interleaved" "03"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Buffer_Interleaved" "04"
# Disabled: animations not supported
#test_generatorAsset "Buffer_Misc" "00"
# Disabled/FIXME: investigate conformance and introduce under custom tests
#test_generatorAsset "Compatibility" "00"
#test_generatorAsset "Compatibility" "01"
#test_generatorAsset "Compatibility" "02"
#test_generatorAsset "Compatibility" "03"
#test_generatorAsset "Compatibility" "04"
#test_generatorAsset "Compatibility" "05"
#test_generatorAsset "Compatibility" "06"
test_generatorAsset "Instancing" "00"
test_generatorAsset "Instancing" "01"
test_generatorAsset "Instancing" "02"
test_generatorAsset "Instancing" "03"
test_generatorAsset "Instancing" "04"
test_generatorAsset "Instancing" "05"
test_generatorAsset "Instancing" "06"
test_generatorAsset "Instancing" "07"
# Disabled: skinning not supported
#test_generatorAsset "Instancing" "08"
#test_generatorAsset "Instancing" "09"
#test_generatorAsset "Instancing" "10"
# Disabled: animations not supported
#test_generatorAsset "Instancing" "11"
#test_generatorAsset "Instancing" "12"
#test_generatorAsset "Instancing" "13"
test_generatorAsset "Material" "00"
test_generatorAsset "Material" "01"
# Note: occlusion texture is missing in MaterialX render (limitation)
test_generatorAsset "Material" "02"
test_generatorAsset "Material" "03"
test_generatorAsset "Material" "04"
# Note: occlusion texture is missing in MaterialX render (limitation)
test_generatorAsset "Material" "05"
test_generatorAsset "Material" "06"
# Note: occlusion texture is missing in MaterialX render (limitation)
test_generatorAsset "Material" "07"
# Note: some tests require vertex colors; disable preview surfaces for those
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Material_AlphaBlend" "00"
test_generatorAsset "Material_AlphaBlend" "01"
test_generatorAsset "Material_AlphaBlend" "02"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Material_AlphaBlend" "03"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Material_AlphaBlend" "04"
test_generatorAsset "Material_AlphaBlend" "05"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Material_AlphaBlend" "06"
test_generatorAsset "Material_AlphaMask" "00"
test_generatorAsset "Material_AlphaMask" "01"
test_generatorAsset "Material_AlphaMask" "02"
test_generatorAsset "Material_AlphaMask" "03"
test_generatorAsset "Material_AlphaMask" "04"
test_generatorAsset "Material_AlphaMask" "05"
test_generatorAsset "Material_AlphaMask" "06"
test_generatorAsset "Material_DoubleSided" "00"
test_generatorAsset "Material_DoubleSided" "01"
test_generatorAsset "Material_DoubleSided" "02"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Material_DoubleSided" "03"
test_generatorAsset "Material_DoubleSided" "04"
test_generatorAsset "Material_MetallicRoughness" "00"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Material_MetallicRoughness" "01"
test_generatorAsset "Material_MetallicRoughness" "02"
test_generatorAsset "Material_MetallicRoughness" "03"
test_generatorAsset "Material_MetallicRoughness" "04"
test_generatorAsset "Material_MetallicRoughness" "05"
test_generatorAsset "Material_MetallicRoughness" "06"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Material_MetallicRoughness" "07"
test_generatorAsset "Material_MetallicRoughness" "08"
test_generatorAsset "Material_MetallicRoughness" "09"
test_generatorAsset "Material_MetallicRoughness" "10"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Material_MetallicRoughness" "11"
# Disabled: KHR_materials_pbrSpecularGlossiness is 'archived'
#test_generatorAsset "Material_Mixed" "00"
#test_generatorAsset "Material_Mixed" "01"
#test_generatorAsset "Material_Mixed" "02"
# Disabled: KHR_materials_pbrSpecularGlossiness is 'archived'
#test_generatorAsset "Material_SpecularGlossiness" "00"
#test_generatorAsset "Material_SpecularGlossiness" "01"
#test_generatorAsset "Material_SpecularGlossiness" "02"
#test_generatorAsset "Material_SpecularGlossiness" "03"
#test_generatorAsset "Material_SpecularGlossiness" "04"
#test_generatorAsset "Material_SpecularGlossiness" "05"
#test_generatorAsset "Material_SpecularGlossiness" "06"
#test_generatorAsset "Material_SpecularGlossiness" "07"
#test_generatorAsset "Material_SpecularGlossiness" "08"
#test_generatorAsset "Material_SpecularGlossiness" "09"
#test_generatorAsset "Material_SpecularGlossiness" "10"
#test_generatorAsset "Material_SpecularGlossiness" "11"
#test_generatorAsset "Material_SpecularGlossiness" "12"
#test_generatorAsset "Material_SpecularGlossiness" "13"
test_generatorAsset "Mesh_PrimitiveAttribute" "00"
test_generatorAsset "Mesh_PrimitiveAttribute" "01"
test_generatorAsset "Mesh_PrimitiveAttribute" "02"
test_generatorAsset "Mesh_PrimitiveAttribute" "03"
test_generatorAsset "Mesh_PrimitiveAttribute" "04"
test_generatorAsset "Mesh_PrimitiveAttribute" "05"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Mesh_PrimitiveAttribute" "06"
# Note: HdStorm can't render lines and points
GT_DISABLE_GRAPHICAL=1 \
test_generatorAsset "Mesh_PrimitiveMode" "00"
GT_DISABLE_GRAPHICAL=1 \
test_generatorAsset "Mesh_PrimitiveMode" "01"
GT_DISABLE_GRAPHICAL=1 \
test_generatorAsset "Mesh_PrimitiveMode" "02"
GT_DISABLE_GRAPHICAL=1 \
test_generatorAsset "Mesh_PrimitiveMode" "03"
test_generatorAsset "Mesh_PrimitiveMode" "04"
test_generatorAsset "Mesh_PrimitiveMode" "05"
test_generatorAsset "Mesh_PrimitiveMode" "06"
GT_DISABLE_GRAPHICAL=1 \
test_generatorAsset "Mesh_PrimitiveMode" "07"
GT_DISABLE_GRAPHICAL=1 \
test_generatorAsset "Mesh_PrimitiveMode" "08"
GT_DISABLE_GRAPHICAL=1 \
test_generatorAsset "Mesh_PrimitiveMode" "09"
GT_DISABLE_GRAPHICAL=1 \
test_generatorAsset "Mesh_PrimitiveMode" "10"
test_generatorAsset "Mesh_PrimitiveMode" "11"
test_generatorAsset "Mesh_PrimitiveMode" "12"
test_generatorAsset "Mesh_PrimitiveMode" "13"
test_generatorAsset "Mesh_PrimitiveMode" "14"
test_generatorAsset "Mesh_PrimitiveMode" "15"
# Note: these tests require vertex colors; disable preview surfaces
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Mesh_PrimitiveVertexColor" "00"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Mesh_PrimitiveVertexColor" "01"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Mesh_PrimitiveVertexColor" "02"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Mesh_PrimitiveVertexColor" "03"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Mesh_PrimitiveVertexColor" "04"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Mesh_PrimitiveVertexColor" "05"
test_generatorAsset "Mesh_Primitives" "00"
test_generatorAsset "Mesh_PrimitivesUV" "00"
test_generatorAsset "Mesh_PrimitivesUV" "01"
test_generatorAsset "Mesh_PrimitivesUV" "02"
test_generatorAsset "Mesh_PrimitivesUV" "03"
test_generatorAsset "Mesh_PrimitivesUV" "04"
test_generatorAsset "Mesh_PrimitivesUV" "05"
test_generatorAsset "Mesh_PrimitivesUV" "06"
test_generatorAsset "Mesh_PrimitivesUV" "07"
test_generatorAsset "Mesh_PrimitivesUV" "08"
test_generatorAsset "Node_Attribute" "00"
test_generatorAsset "Node_Attribute" "01"
test_generatorAsset "Node_Attribute" "02"
test_generatorAsset "Node_Attribute" "03"
test_generatorAsset "Node_Attribute" "04"
test_generatorAsset "Node_Attribute" "05"
test_generatorAsset "Node_Attribute" "06"
test_generatorAsset "Node_Attribute" "07"
test_generatorAsset "Node_Attribute" "08"
test_generatorAsset "Node_NegativeScale" "00"
test_generatorAsset "Node_NegativeScale" "01"
test_generatorAsset "Node_NegativeScale" "02"
test_generatorAsset "Node_NegativeScale" "03"
test_generatorAsset "Node_NegativeScale" "04"
test_generatorAsset "Node_NegativeScale" "05"
test_generatorAsset "Node_NegativeScale" "06"
test_generatorAsset "Node_NegativeScale" "07"
test_generatorAsset "Node_NegativeScale" "08"
test_generatorAsset "Node_NegativeScale" "09"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Node_NegativeScale" "10"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Node_NegativeScale" "11"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Node_NegativeScale" "12"
# Note: preview surfaces do not expose sampler properties
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Texture_Sampler" "00"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Texture_Sampler" "01"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Texture_Sampler" "02"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Texture_Sampler" "03"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Texture_Sampler" "04"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Texture_Sampler" "05"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Texture_Sampler" "06"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Texture_Sampler" "07"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Texture_Sampler" "08"
# Note: MaterialX has no support for Mipmap samplers; fall back to non-Mipmap variants
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Texture_Sampler" "09"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Texture_Sampler" "10"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Texture_Sampler" "11"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Texture_Sampler" "12"
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_generatorAsset "Texture_Sampler" "13"

##
## Graphical: sample models
##
IMAGE_WIDTH=800

###
### Complex Models
###
test_sampleModel "2CylinderEngine"                GT_SAMPLE_MODEL_FLAG_BINARY_AND_EMBEDDED
test_sampleModel "ABeautifulGame"                 0
GT_DISABLE_GRAPHICAL=1 \
test_sampleModel "AntiqueCamera"                  GT_SAMPLE_MODEL_FLAG_BINARY
GT_DISABLE_GRAPHICAL=1 \
test_sampleModel "Avocado"                        GT_SAMPLE_MODEL_FLAG_BINARY
GT_DISABLE_GRAPHICAL=1 \
test_sampleModel "BarramundiFish"                 GT_SAMPLE_MODEL_FLAG_BINARY
GT_DISABLE_GRAPHICAL=1 \
test_sampleModel "BoomBox"                        GT_SAMPLE_MODEL_FLAG_BINARY
GT_DISABLE_GRAPHICAL=1 \
test_sampleModel "BoomBoxWithAxes"                0
# Note: animations, skinning ignored
GT_DISABLE_GRAPHICAL=1 \
test_sampleModel "BrainStem"                      $(( GT_SAMPLE_MODEL_FLAG_BINARY_AND_EMBEDDED | GT_SAMPLE_MODEL_FLAG_MESHOPT ))
GT_DISABLE_GRAPHICAL=1 \
test_sampleModel "Buggy"                          GT_SAMPLE_MODEL_FLAG_BINARY_AND_EMBEDDED
# Disabled: animations, skinning not supported
#test_sampleModel "CesiumMan"                     GT_SAMPLE_MODEL_FLAG_BINARY_AND_EMBEDDED
GT_DISABLE_GRAPHICAL=1 \
test_sampleModel "CesiumMilkTruck"                GT_SAMPLE_MODEL_FLAG_BINARY_AND_EMBEDDED
GT_DISABLE_GRAPHICAL=1 \
test_sampleModel "Corset"                         GT_SAMPLE_MODEL_FLAG_BINARY
GT_DISABLE_GRAPHICAL=1 \
test_sampleModel "Cube"                           0
test_sampleModel "DamagedHelmet"                  GT_SAMPLE_MODEL_FLAG_BINARY_AND_EMBEDDED
test_sampleModel "DragonAttenuation"              $(( GT_SAMPLE_MODEL_FLAG_BINARY | GT_SAMPLE_MODEL_FLAG_MESHOPT ))
GT_DISABLE_GRAPHICAL=1 \
test_sampleModel "Duck"                           GT_SAMPLE_MODEL_FLAG_BINARY_AND_EMBEDDED
GT_DISABLE_GRAPHICAL=1 \
test_sampleModel "FlightHelmet"                   0
GT_DISABLE_GRAPHICAL=1 \
test_sampleModel "Fox"                            GT_SAMPLE_MODEL_FLAG_BINARY
GT_DISABLE_GRAPHICAL=1 \
test_sampleModel "GearboxAssy"                    GT_SAMPLE_MODEL_FLAG_BINARY_AND_EMBEDDED
test_sampleModel "IridescenceLamp"                GT_SAMPLE_MODEL_FLAG_BINARY
# Note: does not actually use KHR_materials_iridescence extension (yet)
test_sampleModel "IridescentDishWithOlives"       GT_SAMPLE_MODEL_FLAG_BINARY
GT_DISABLE_GRAPHICAL=1 \
test_sampleModel "Lantern"                        GT_SAMPLE_MODEL_FLAG_BINARY
test_sampleModel "MosquitoInAmber"                GT_SAMPLE_MODEL_FLAG_BINARY
GT_DISABLE_GRAPHICAL=1 \
test_sampleModel "ReciprocatingSaw"               GT_SAMPLE_MODEL_FLAG_BINARY_AND_EMBEDDED
GT_DISABLE_GRAPHICAL=1 \
test_sampleModel "SciFiHelmet"                    0
test_sampleModel "SheenChair"                     GT_SAMPLE_MODEL_FLAG_BINARY
test_sampleModel "SheenCloth"                     0
GT_DISABLE_GRAPHICAL=1 \
test_sampleModel "Sponza"                         0
# Disabled: Storm transparency flakyness
GT_DISABLE_IMGDIFF=1 \
test_sampleModel "StainedGlassLamp"               0
GT_DISABLE_GRAPHICAL=1 \
test_sampleModel "Suzanne"                        0
test_sampleModel "ToyCar"                         GT_SAMPLE_MODEL_FLAG_BINARY
GT_DISABLE_GRAPHICAL=1 \
test_sampleModel "VC"                             GT_SAMPLE_MODEL_FLAG_BINARY_AND_EMBEDDED
GT_DISABLE_GRAPHICAL=1 \
test_sampleModel "WaterBottle"                    GT_SAMPLE_MODEL_FLAG_BINARY

###
### Feature Tests
###
test_sampleModel "AlphaBlendModeTest"             GT_SAMPLE_MODEL_FLAG_BINARY_AND_EMBEDDED
# Disabled: animations not supported
#test_sampleModel "AnimatedCube"                  0
# Disabled: animations not supported
#test_sampleModel "AnimatedMorphCube"             GT_SAMPLE_MODEL_FLAG_BINARY
# Disabled: animations not supported
#test_sampleModel "AnimatedMorphSphere"           GT_SAMPLE_MODEL_FLAG_BINARY
# Disabled: animations not supported
#test_sampleModel "AnimatedTriangle"              GT_SAMPLE_MODEL_FLAG_EMBEDDED
test_sampleModel "AttenuationTest"                GT_SAMPLE_MODEL_FLAG_BINARY
GT_DISABLE_GRAPHICAL=1 \
test_sampleModel "Box"                            GT_SAMPLE_MODEL_FLAG_BINARY_AND_EMBEDDED
# FIXME: investigate whether this is a USD limitation or converter issue
#GT_DISABLE_GRAPHICAL=1 \
#test_sampleModel "Box With Spaces"               0
# Disabled: animations not supported
#test_sampleModel "BoxAnimated"                   GT_SAMPLE_MODEL_FLAG_BINARY_AND_EMBEDDED
GT_DISABLE_GRAPHICAL=1 \
test_sampleModel "BoxInterleaved"                 GT_SAMPLE_MODEL_FLAG_BINARY_AND_EMBEDDED
GT_DISABLE_GRAPHICAL=1 \
test_sampleModel "BoxTextured"                    GT_SAMPLE_MODEL_FLAG_BINARY_AND_EMBEDDED
GT_DISABLE_GRAPHICAL=1 \
test_sampleModel "BoxTexturedNonPowerOfTwo"       GT_SAMPLE_MODEL_FLAG_BINARY_AND_EMBEDDED
GT_DISABLE_GRAPHICAL=1 \
test_sampleModel "BoxVertexColors"                GT_SAMPLE_MODEL_FLAG_BINARY_AND_EMBEDDED
test_sampleModel "ClearCoatTest"                  GT_SAMPLE_MODEL_FLAG_BINARY
test_sampleModel "EmissiveStrengthTest"           GT_SAMPLE_MODEL_FLAG_BINARY
test_sampleModel "EnvironmentTest"                0
# Disabled: animations not supported
#test_sampleModel "InterpolationTest"             GT_SAMPLE_MODEL_FLAG_BINARY
test_sampleModel "IridescenceDielectricSpheres"   0
test_sampleModel "IridescenceMetallicSpheres"     0
GT_DISABLE_GRAPHICAL_PREVIEW=1 \
test_sampleModel "IridescenceSuzanne"             GT_SAMPLE_MODEL_FLAG_BINARY
test_sampleModel "LightsPunctualLamp"             GT_SAMPLE_MODEL_FLAG_BINARY
test_sampleModel "MetalRoughSpheres"              GT_SAMPLE_MODEL_FLAG_BINARY_AND_EMBEDDED
test_sampleModel "MetalRoughSpheresNoTextures"    GT_SAMPLE_MODEL_FLAG_BINARY
# Disabled: skinning not supported
#test_sampleModel "MorphPrimitivesTest"           GT_SAMPLE_MODEL_FLAG_BINARY
# Disabled: skinning not supported
#test_sampleModel "MorphStressTest"               GT_SAMPLE_MODEL_FLAG_BINARY
test_sampleModel "MultiUVTest"                    GT_SAMPLE_MODEL_FLAG_BINARY_AND_EMBEDDED
test_sampleModel "NormalTangentMirrorTest"        GT_SAMPLE_MODEL_FLAG_BINARY_AND_EMBEDDED
test_sampleModel "NormalTangentTest"              GT_SAMPLE_MODEL_FLAG_BINARY_AND_EMBEDDED
test_sampleModel "OrientationTest"                GT_SAMPLE_MODEL_FLAG_BINARY_AND_EMBEDDED
# Disabled: animations, skinning not supported
#test_sampleModel "RecursiveSkeletons"            GT_SAMPLE_MODEL_FLAG_BINARY
#test_sampleModel "RiggedFigure"                  GT_SAMPLE_MODEL_FLAG_BINARY_AND_EMBEDDED
#test_sampleModel "RiggedSimple"                  GT_SAMPLE_MODEL_FLAG_BINARY_AND_EMBEDDED
test_sampleModel "SimpleMeshes"                   GT_SAMPLE_MODEL_FLAG_EMBEDDED
# Disabled: skinning not supported
#test_sampleModel "SimpleMorph"                   GT_SAMPLE_MODEL_FLAG_EMBEDDED
#test_sampleModel "SimpleSkin"                    GT_SAMPLE_MODEL_FLAG_EMBEDDED
test_sampleModel "SimpleSparseAccessor"           GT_SAMPLE_MODEL_FLAG_EMBEDDED
test_sampleModel "SpecularTest"                   GT_SAMPLE_MODEL_FLAG_BINARY
test_sampleModel "TextureCoordinateTest"          GT_SAMPLE_MODEL_FLAG_BINARY_AND_EMBEDDED
# Note: HdStorm does not support one- and two-channel sRGB textures
test_sampleModel "TextureLinearInterpolationTest" GT_SAMPLE_MODEL_FLAG_BINARY
test_sampleModel "TextureSettingsTest"            GT_SAMPLE_MODEL_FLAG_BINARY_AND_EMBEDDED
test_sampleModel "TextureTransformMultiTest"      GT_SAMPLE_MODEL_FLAG_BINARY
test_sampleModel "TextureTransformTest"           0
test_sampleModel "TransmissionRoughnessTest"      GT_SAMPLE_MODEL_FLAG_BINARY
test_sampleModel "TransmissionTest"               GT_SAMPLE_MODEL_FLAG_BINARY
GT_DISABLE_GRAPHICAL=1 \
test_sampleModel "Triangle"                       GT_SAMPLE_MODEL_FLAG_EMBEDDED
test_sampleModel "TriangleWithoutIndices"         GT_SAMPLE_MODEL_FLAG_EMBEDDED
GT_DISABLE_GRAPHICAL=1 \
test_sampleModel "TwoSidedPlane"                  0
# Disabled: not supported by cgltf
#GT_DISABLE_GRAPHICAL=1 \
#test_sampleModel "Unicode❤♻Test"                 GT_SAMPLE_MODEL_FLAG_BINARY
test_sampleModel "UnlitTest"                      GT_SAMPLE_MODEL_FLAG_BINARY
test_sampleModel "VertexColorTest"                GT_SAMPLE_MODEL_FLAG_BINARY_AND_EMBEDDED

###
### Draco Models
###
test_sampleModelDraco "2CylinderEngine"
# Disabled: single test is enough for now
#test_sampleModelDraco "Avocado"
#test_sampleModelDraco "BarramundiFish"
#test_sampleModelDraco "BoomBox"
#test_sampleModelDraco "BrainStem"
#test_sampleModelDraco "CesiumMan"
#test_sampleModelDraco "CesiumMilkTruck"
#test_sampleModelDraco "Corset"
#test_sampleModelDraco "GearboxAssy"
#test_sampleModelDraco "Lantern"
#test_sampleModelDraco "ReciprocatingSaw"
#test_sampleModelDraco "VC"
#test_sampleModelDraco "WaterBottle"

##
## Graphical: third party
##

IMAGE_WIDTH=800
# Disabled: Storm transparency flakyness
GT_DISABLE_GRAPHICAL_PREVIEW=1 test_thirdparty "Camera_01" "Camera_01/Camera_01.gltf"
test_thirdparty "CoffeeCart_01" "CoffeeCart_01/CoffeeCart_01.gltf"
test_thirdparty "Fangyi" "fangyi.glb"
test_thirdparty "Loewe_von_Asparn" "loewe_von_asparn.glb"
test_thirdparty "Perseverance" "Perseverance.glb"
test_thirdparty "Space_Shuttle" "Space_Shuttle.glb"

#
# Custom Tests
#

# TextureEncoding
# $1: image file path
textureEncodingResizeImage()
{
    TMP_IMG_NAME="tmp.png"
    oiiotool $1 --resize 2x2 -o $TMP_IMG_NAME
    mv $TMP_IMG_NAME $1
}
if ! skip_or_print_test "TextureEncodingTest"; then
    TEST_NAME="TextureEncodingTest"
    GLTF_INPUT_FILE="input/glTF-Sample-Models/2.0/TextureEncodingTest/glTF/TextureEncodingTest.gltf"
    USD_OUTPUT_DIR="output/TextureEncodingTest"
    USD_OUTPUT_FILE="$USD_OUTPUT_DIR/TextureEncodingTest.usd"

    IMAGE_WIDTH=400 GT_DISABLE_GRAPHICAL_MTLX=1 test_graphical $TEST_NAME $GLTF_INPUT_FILE $USD_OUTPUT_FILE

    GUC_DISABLE_PREVIEW_MATERIAL_BINDINGS=1 convert_glTF_to_USD $GLTF_INPUT_FILE $USD_OUTPUT_FILE --emit-mtlx

    # HdStorm renders the 1x1 green textures as white. Resizing them yields correct results.
    textureEncodingResizeImage "$USD_OUTPUT_DIR/0_136_0.png"
    textureEncodingResizeImage "$USD_OUTPUT_DIR/0_136_0_gamma.png"
    textureEncodingResizeImage "$USD_OUTPUT_DIR/0_136_0_icc.png"
    textureEncodingResizeImage "$USD_OUTPUT_DIR/0_136_255.png"
    textureEncodingResizeImage "$USD_OUTPUT_DIR/0_136_255_gamma.png"
    textureEncodingResizeImage "$USD_OUTPUT_DIR/0_136_255_icc.png"

    if [ $? -ne 0 ]; then
        print_error
        return
    elif [ ${GT_DISABLE_GRAPHICAL:-0} -eq 0 ] && [ ${GT_DISABLE_GRAPHICAL_MTLX:-0} -eq 0 ]; then
        IMAGE_WIDTH=400 render_and_compare $TEST_NAME "${TEST_NAME}_mtlx"
    fi
fi

# UsdGlTF
if ! skip_or_print_test "UsdGlTF_DamagedHelmet"; then
    if [ ${GT_DISABLE_GRAPHICAL:-0} -eq 0 ] && [ ${GT_DISABLE_GRAPHICAL_PREVIEW:-0} -eq 0 ]; then
        IMAGE_WIDTH=800 render_and_compare "UsdGlTF_DamagedHelmet" "UsdGlTF_DamagedHelmet" "DamagedHelmet_preview"
    fi
fi
if ! skip_or_print_test "UsdGlTF_Material_MetallicRoughness_10"; then
    if [ ${GT_DISABLE_GRAPHICAL:-0} -eq 0 ] && [ ${GT_DISABLE_GRAPHICAL_PREVIEW:-0} -eq 0 ]; then
        IMAGE_WIDTH=400 render_and_compare "UsdGlTF_Material_MetallicRoughness_10" \
                                           "UsdGlTF_Material_MetallicRoughness_10" \
                                           "Material_MetallicRoughness_10_preview"
    fi
fi

# USDZ
if ! skip_or_print_test "Usdz_DamagedHelmet"; then
    IMAGE_WIDTH=800 test_graphical "Usdz_DamagedHelmet" \
                                   "input/glTF-Sample-Models/2.0/DamagedHelmet/glTF/DamagedHelmet.gltf" \
                                   "output/Usdz_DamagedHelmet.usdz" \
                                   "DamagedHelmet"
fi
if ! skip_or_print_test "Usdz_Material_MetallicRoughness_10_rel"; then
    IMAGE_WIDTH=400 test_graphical "Usdz_Material_MetallicRoughness_10_rel" \
                                   "input/glTF-Asset-Generator/Output/Positive/Material_MetallicRoughness/Material_MetallicRoughness_10.gltf" \
                                   "output/Usdz_Material_MetallicRoughness_10_rel.usdz" \
                                   "Material_MetallicRoughness_10"
fi
if ! skip_or_print_test "Usdz_Material_MetallicRoughness_10_abs"; then
    IMAGE_WIDTH=400 test_graphical "Usdz_Material_MetallicRoughness_10_abs" \
                                   "$PWD/input/glTF-Asset-Generator/Output/Positive/Material_MetallicRoughness/Material_MetallicRoughness_10.gltf" \
                                   "$PWD/output/Usdz_Material_MetallicRoughness_10_abs.usdz" \
                                   "Material_MetallicRoughness_10"
fi

# Cmdline
# $1: test name suffix
# $2+: additional command flags
function test_cmdLine()
{
    if ! skip_or_print_test "Cmdline_$1"; then
        guc $2 2> /dev/null
        if [ $? -eq 0 ]; then
            print_error
        fi
    fi
}
test_cmdLine "Cmdline_empty" ""
test_cmdLine "Cmdline_single_file"  "input.gltf"
test_cmdLine "Cmdline_missing_file" "__missing_file.gltf output.usd"
test_cmdLine "Cmdline_empty_flag"   "- input.gltf output.usd"
test_cmdLine "Cmdline_illegal_flag" "--illegal input.gltf output.usd"

# Mtlx-as-UsdShade
if ! skip_or_print_test "MtlxAsUsdShade"; then
    GT_DISABLE_GRAPHICAL_PREVIEW=1 \
    IMAGE_WIDTH=800 test_graphical "MtlxAsUsdShade" \
                                   "input/glTF-Sample-Models/2.0/DamagedHelmet/glTF/DamagedHelmet.gltf" \
                                   "output/MtlxAsUsdShade/DamagedHelmet.usd" \
                                   "DamagedHelmet" \
                                   "--mtlx-as-usdshade"
fi

# UsdaDiff
if ! skip_or_print_test "UsdaDiff_Below2411"; then
    USD_OUTPUT_FILE="output/UsdaDiff_Below2411.usda"
    convert_glTF_to_USD "input/glTF-Asset-Generator/Output/Positive/Material_MetallicRoughness/Material_MetallicRoughness_11.gltf" $USD_OUTPUT_FILE -m -u

    if [ $? -ne 0 ] || ! diff --text -w "$USD_OUTPUT_FILE" "UsdaDiff_Below2411.usda"; then
        print_error
    fi
fi
if ! skip_or_print_test "UsdaDiff_Equal2411"; then
    USD_OUTPUT_FILE="output/UsdaDiff_Equal2411.usda"
    convert_glTF_to_USD "input/glTF-Asset-Generator/Output/Positive/Material_MetallicRoughness/Material_MetallicRoughness_11.gltf" $USD_OUTPUT_FILE -m -u

    if [ $? -ne 0 ] || ! diff --text -w "$USD_OUTPUT_FILE" "UsdaDiff_Equal2411.usda"; then
        print_error
    fi
fi
if ! skip_or_print_test "UsdaDiff_Above2411"; then
    USD_OUTPUT_FILE="output/UsdaDiff_Above2411.usda"
    convert_glTF_to_USD "input/glTF-Asset-Generator/Output/Positive/Material_MetallicRoughness/Material_MetallicRoughness_11.gltf" $USD_OUTPUT_FILE -m -u

    if [ $? -ne 0 ] || ! diff --text -w "$USD_OUTPUT_FILE" "UsdaDiff_Above2411.usda"; then
        print_error
    fi
fi

# Material Variants
# TODO: could also test GlamVelvetSofa
if ! skip_or_print_test "MaterialVariants"; then
    IMAGE_WIDTH=400 test_graphical "MaterialVariants_Variant0" \
                                   "input/glTF-Sample-Models/2.0/MaterialsVariantsShoe/glTF/MaterialsVariantsShoe.gltf" \
                                   "output/MaterialVariants/MaterialVariants_Variant0.usd" \
                                   "MaterialVariants_Variant0"

    IMAGE_WIDTH=400 test_graphical "MaterialVariants_Variant1" \
                                   "input/glTF-Sample-Models/2.0/MaterialsVariantsShoe/glTF/MaterialsVariantsShoe.gltf" \
                                   "output/MaterialVariants/MaterialVariants_Variant1.usd" \
                                   "MaterialVariants_Variant1" \
                                   "--default-material-variant 1"
fi

# Scenes
# $1: test name
function test_scene()
{
  if ! skip_or_print_test $1; then
      IMAGE_WIDTH=400 test_graphical $1 input/$1.gltf output/$1/$1.usd
  fi
}
# FIXME: check whether 'Nodes' prim exists and is populated
GT_DISABLE_GRAPHICAL_MTLX=1 test_scene "Scene_00"
GT_DISABLE_GRAPHICAL_MTLX=1 test_scene "Scene_01"
GT_DISABLE_GRAPHICAL_MTLX=1 test_scene "Scene_02"
GT_DISABLE_GRAPHICAL_MTLX=1 test_scene "Scene_03"
GT_DISABLE_GRAPHICAL_MTLX=1 test_scene "Scene_04"

# Cameras
if ! skip_or_print_test "Cameras"; then
    convert_glTF_to_hdSt_USD "input/glTF-Sample-Models/2.0/Cameras/glTF/Cameras.gltf" "output/Cameras.usd"
    if [ $? -ne 0 ]; then
        print_error
    elif [ ${GT_DISABLE_GRAPHICAL:-0} -eq 0 ] && [ ${GT_DISABLE_GRAPHICAL_PREVIEW:-0} -eq 0 ]; then
        IMAGE_WIDTH=400 render_and_compare "Cameras" "Cameras_00_preview" "Cameras_00_preview" "/T_Scene/Scenes/scene/node_1/cam"
        IMAGE_WIDTH=400 render_and_compare "Cameras" "Cameras_01_preview" "Cameras_01_preview" "/T_Scene/Scenes/scene/node_2/cam"
    fi
fi

#
# Cleanup
#
echo "Removing temp dir $TMP_DIR"
rm -rf $TMP_DIR

echo "==================================================================="
if (( $FAIL_COUNT > 0 )); then
    echo "=== FAILURE: $FAIL_COUNT test(s) failed!"
else
    echo "=== SUCCESS"
fi
echo "==================================================================="

test $FAIL_COUNT -eq 0
