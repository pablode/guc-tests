# guc-tests

This is the test suite for [guc](https://github.com/pablode/guc), a glTF to USD converter.

For test-specific information, please see the [Graphical Test Overview](tests).

## Local setup

1. Build and install [USD](https://github.com/PixarAnimationStudios/USD/tree/v22.11) with the following flags:  
`--materialx --openimageio --build-args OpenImageIO,"-DOIIO_BUILD_TOOLS=ON"`
2. Build guc in debug configuration, add it to your PATH
3. Patch your USD MaterialX installation as follows: [MaterialX_patch.diff](https://github.com/pablode/USD/blob/8293f10bbc66b8ade36fd1c5ef66a9815aff3e07/.github/MaterialX_patch.diff)

Then, execute `run_tests.sh` using _bash_.

## Environment variables

Test execution can be influenced using following variables:

Name    | Description
---     | ---
GT_DISABLE_CONVERSION | Disable glTF to USD conversion. This option reduces test execution time when debugging the MaterialX glTF PBR implementation or hdStorm.
GT_DISABLE_GRAPHICAL | Disable all graphical tests
GT_DISABLE_GRAPHICAL_MTLX | Disable MaterialX graphical tests
GT_DISABLE_GRAPHICAL_PREVIEW | Disable UsdPreviewSurface graphical tests
GT_VERBOSE | Print all executed commands

## Continuous integration

Tests can be executed on the CI, via guc's [GitHub Actions workflow](https://github.com/pablode/guc/actions/workflows/run-tests.yml).

> Note: graphical test execution on the CI is not advised due to long execution times and rendering artifacts.
