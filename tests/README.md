# Graphical Test Overview

This README visualizes a subset of the graphical tests and serves as an artifact for discussion around 
1) the conformance of guc and the MaterialX glTF PBR implementation
2) UsdPreviewSurface limitations and shading differences
3) existing problems in guc and involved technologies.

> Note: please see [run_tests.sh](../run_tests.sh) for additional notes and deactivated tests.

<hr />

### glTF-Asset-Generator (<a href="https://github.com/KhronosGroup/glTF-Asset-Generator/tree/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive">source</a>)

<table>
  <tr>
    <th>Index</th>
    <th>USD+UsdPreviewSurface</th>
    <th>USD+MaterialX</th>
    <th>glTF&nbsp;Ref.</th>
  </tr>

  <tr align="middle">
    <td colspan="4">Accessor_Sparse</td>
  </tr>
  <tr align="middle">
    <td>02</td>
    <td><img src="Accessor_Sparse_02_preview.png" align="middle" width=200 /></td>
    <td><img src="Accessor_Sparse_02_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Accessor_Sparse/Figures/SampleImages/Accessor_Sparse_02.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>03</td>
    <td><img src="Accessor_Sparse_03_preview.png" align="middle" width=200 /></td>
    <td><img src="Accessor_Sparse_03_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Accessor_Sparse/Figures/SampleImages/Accessor_Sparse_03.png" align="middle" width=200 /></td>
  </tr>

  <tr align="middle">
    <td colspan="4">Accessor_SparseType</td>
  </tr>
  <tr align="middle">
    <td>05</td>
    <td><img src="Accessor_SparseType_05_preview.png" align="middle" width=200 /></td>
    <td><img src="Accessor_SparseType_05_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Accessor_SparseType/Figures/SampleImages/Accessor_SparseType_05.png" align="middle" width=200 /></td>
  </tr>

  <tr align="middle">
    <td colspan="4">Buffer_Interleaved</td>
  </tr>
  <tr align="middle">
    <td>00</td>
    <td></td>
    <td><img src="Buffer_Interleaved_00_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Buffer_Interleaved/Figures/SampleImages/Buffer_Interleaved_00.png" align="middle" width=200 /></td>
  </tr align="middle">
  <tr align="middle">
    <td>01</td>
    <td></td>
    <td><img src="Buffer_Interleaved_01_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Buffer_Interleaved/Figures/SampleImages/Buffer_Interleaved_01.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>02</td>
    <td></td>
    <td><img src="Buffer_Interleaved_02_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Buffer_Interleaved/Figures/SampleImages/Buffer_Interleaved_02.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>03</td>
    <td></td>
    <td><img src="Buffer_Interleaved_03_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Buffer_Interleaved/Figures/SampleImages/Buffer_Interleaved_03.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>04</td>
    <td></td>
    <td><img src="Buffer_Interleaved_04_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Buffer_Interleaved/Figures/SampleImages/Buffer_Interleaved_04.png" align="middle" width=200 /></td>
  </tr>

  <tr align="middle">
    <td colspan="4">Instancing</td>
  </tr>
  <tr align="middle">
    <td>00</td>
    <td><img src="Instancing_00_preview.png" align="middle" width=200 /></td>
    <td><img src="Instancing_00_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Instancing/Figures/SampleImages/Instancing_00.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>01</td>
    <td><img src="Instancing_01_preview.png" align="middle" width=200 /></td>
    <td><img src="Instancing_01_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Instancing/Figures/SampleImages/Instancing_01.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>02</td>
    <td><img src="Instancing_02_preview.png" align="middle" width=200 /></td>
    <td><img src="Instancing_02_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Instancing/Figures/SampleImages/Instancing_02.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>03</td>
    <td><img src="Instancing_03_preview.png" align="middle" width=200 /></td>
    <td><img src="Instancing_03_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Instancing/Figures/SampleImages/Instancing_03.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>04</td>
    <td><img src="Instancing_04_preview.png" align="middle" width=200 /></td>
    <td><img src="Instancing_04_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Instancing/Figures/SampleImages/Instancing_04.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>05</td>
    <td><img src="Instancing_05_preview.png" align="middle" width=200 /></td>
    <td><img src="Instancing_05_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Instancing/Figures/SampleImages/Instancing_05.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>06</td>
    <td><img src="Instancing_06_preview.png" align="middle" width=200 /></td>
    <td><img src="Instancing_06_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Instancing/Figures/SampleImages/Instancing_06.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>07</td>
    <td><img src="Instancing_07_preview.png" align="middle" width=200 /></td>
    <td><img src="Instancing_07_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Instancing/Figures/SampleImages/Instancing_07.png" align="middle" width=200 /></td>
  </tr>

  <tr align="middle">
    <td colspan="4">Material</td>
  </tr>
  <tr align="middle">
    <td>00</td>
    <td><img src="Material_00_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_00_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material/Figures/SampleImages/Material_00.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>01</td>
    <td><img src="Material_01_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_01_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material/Figures/SampleImages/Material_01.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>02</td>
    <td><img src="Material_02_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_02_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material/Figures/SampleImages/Material_02.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>03</td>
    <td><img src="Material_03_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_03_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material/Figures/SampleImages/Material_03.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>04</td>
    <td><img src="Material_04_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_04_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material/Figures/SampleImages/Material_04.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>05</td>
    <td><img src="Material_05_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_05_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material/Figures/SampleImages/Material_05.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>06</td>
    <td><img src="Material_06_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_06_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material/Figures/SampleImages/Material_06.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>07</td>
    <td><img src="Material_07_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_07_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material/Figures/SampleImages/Material_07.png" align="middle" width=200 /></td>
  </tr>

  <tr align="middle">
    <td colspan="4">Material_AlphaBlend</td>
  </tr>
  <tr align="middle">
    <td>00</td>
    <td></td>
    <td><img src="Material_AlphaBlend_00_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_AlphaBlend/Figures/SampleImages/Material_AlphaBlend_00.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>01</td>
    <td><img src="Material_AlphaBlend_01_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_AlphaBlend_01_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_AlphaBlend/Figures/SampleImages/Material_AlphaBlend_01.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>02</td>
    <td><img src="Material_AlphaBlend_02_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_AlphaBlend_02_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_AlphaBlend/Figures/SampleImages/Material_AlphaBlend_02.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>03</td>
    <td></td>
    <td><img src="Material_AlphaBlend_03_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_AlphaBlend/Figures/SampleImages/Material_AlphaBlend_03.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>04</td>
    <td></td>
    <td><img src="Material_AlphaBlend_04_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_AlphaBlend/Figures/SampleImages/Material_AlphaBlend_04.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>05</td>
    <td><img src="Material_AlphaBlend_05_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_AlphaBlend_05_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_AlphaBlend/Figures/SampleImages/Material_AlphaBlend_05.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>06</td>
    <td></td>
    <td><img src="Material_AlphaBlend_06_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_AlphaBlend/Figures/SampleImages/Material_AlphaBlend_06.png" align="middle" width=200 /></td>
  </tr>

  <tr align="middle">
    <td colspan="4">Material_AlphaMask</td>
  </tr>
  <tr align="middle">
    <td>00</td>
    <td><img src="Material_AlphaMask_00_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_AlphaMask_00_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_AlphaMask/Figures/SampleImages/Material_AlphaMask_00.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>01</td>
    <td><img src="Material_AlphaMask_01_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_AlphaMask_01_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_AlphaMask/Figures/SampleImages/Material_AlphaMask_01.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>02</td>
    <td><img src="Material_AlphaMask_02_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_AlphaMask_02_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_AlphaMask/Figures/SampleImages/Material_AlphaMask_02.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>03</td>
    <td><img src="Material_AlphaMask_03_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_AlphaMask_03_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_AlphaMask/Figures/SampleImages/Material_AlphaMask_03.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>04</td>
    <td><img src="Material_AlphaMask_04_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_AlphaMask_04_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_AlphaMask/Figures/SampleImages/Material_AlphaMask_04.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>05</td>
    <td><img src="Material_AlphaMask_05_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_AlphaMask_05_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_AlphaMask/Figures/SampleImages/Material_AlphaMask_05.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>06</td>
    <td><img src="Material_AlphaMask_06_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_AlphaMask_06_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_AlphaMask/Figures/SampleImages/Material_AlphaMask_06.png" align="middle" width=200 /></td>
  </tr>

  <tr align="middle">
    <td colspan="4">Material_DoubleSided</td>
  </tr>
  <tr align="middle">
    <td>00</td>
    <td><img src="Material_DoubleSided_00_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_DoubleSided_00_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_DoubleSided/Figures/SampleImages/Material_DoubleSided_00.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>01</td>
    <td><img src="Material_DoubleSided_01_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_DoubleSided_01_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_DoubleSided/Figures/SampleImages/Material_DoubleSided_01.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>02</td>
    <td><img src="Material_DoubleSided_02_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_DoubleSided_02_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_DoubleSided/Figures/SampleImages/Material_DoubleSided_02.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>03</td>
    <td></td>
    <td><img src="Material_DoubleSided_03_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_DoubleSided/Figures/SampleImages/Material_DoubleSided_03.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>04</td>
    <td><img src="Material_DoubleSided_04_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_DoubleSided_04_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_DoubleSided/Figures/SampleImages/Material_DoubleSided_04.png" align="middle" width=200 /></td>
  </tr>

  <tr align="middle">
    <td colspan="4">Material_MetallicRoughness</td>
  </tr>
  <tr align="middle">
    <td>00</td>
    <td><img src="Material_MetallicRoughness_00_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_MetallicRoughness_00_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_MetallicRoughness/Figures/SampleImages/Material_MetallicRoughness_00.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>01</td>
    <td></td>
    <td><img src="Material_MetallicRoughness_01_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_MetallicRoughness/Figures/SampleImages/Material_MetallicRoughness_01.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>02</td>
    <td><img src="Material_MetallicRoughness_02_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_MetallicRoughness_02_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_MetallicRoughness/Figures/SampleImages/Material_MetallicRoughness_02.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>03</td>
    <td><img src="Material_MetallicRoughness_03_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_MetallicRoughness_03_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_MetallicRoughness/Figures/SampleImages/Material_MetallicRoughness_03.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>04</td>
    <td><img src="Material_MetallicRoughness_04_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_MetallicRoughness_04_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_MetallicRoughness/Figures/SampleImages/Material_MetallicRoughness_04.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>05</td>
    <td><img src="Material_MetallicRoughness_05_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_MetallicRoughness_05_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_MetallicRoughness/Figures/SampleImages/Material_MetallicRoughness_05.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>06</td>
    <td><img src="Material_MetallicRoughness_06_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_MetallicRoughness_06_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_MetallicRoughness/Figures/SampleImages/Material_MetallicRoughness_06.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>07</td>
    <td></td>
    <td><img src="Material_MetallicRoughness_07_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_MetallicRoughness/Figures/SampleImages/Material_MetallicRoughness_07.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>08</td>
    <td><img src="Material_MetallicRoughness_08_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_MetallicRoughness_08_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_MetallicRoughness/Figures/SampleImages/Material_MetallicRoughness_08.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>09</td>
    <td><img src="Material_MetallicRoughness_09_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_MetallicRoughness_09_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_MetallicRoughness/Figures/SampleImages/Material_MetallicRoughness_09.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>10</td>
    <td><img src="Material_MetallicRoughness_10_preview.png" align="middle" width=200 /></td>
    <td><img src="Material_MetallicRoughness_10_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_MetallicRoughness/Figures/SampleImages/Material_MetallicRoughness_10.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>11</td>
    <td></td>
    <td><img src="Material_MetallicRoughness_11_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Material_MetallicRoughness/Figures/SampleImages/Material_MetallicRoughness_11.png" align="middle" width=200 /></td>
  </tr>

  <tr align="middle">
    <td colspan="4">Mesh_PrimitiveAttribute</td>
  </tr>
  <tr align="middle">
    <td>00</td>
    <td><img src="Mesh_PrimitiveAttribute_00_preview.png" align="middle" width=200 /></td>
    <td><img src="Mesh_PrimitiveAttribute_00_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitiveAttribute/Figures/SampleImages/Mesh_PrimitiveAttribute_00.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>01</td>
    <td><img src="Mesh_PrimitiveAttribute_01_preview.png" align="middle" width=200 /></td>
    <td><img src="Mesh_PrimitiveAttribute_01_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitiveAttribute/Figures/SampleImages/Mesh_PrimitiveAttribute_01.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>02</td>
    <td><img src="Mesh_PrimitiveAttribute_02_preview.png" align="middle" width=200 /></td>
    <td><img src="Mesh_PrimitiveAttribute_02_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitiveAttribute/Figures/SampleImages/Mesh_PrimitiveAttribute_02.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>03</td>
    <td><img src="Mesh_PrimitiveAttribute_03_preview.png" align="middle" width=200 /></td>
    <td><img src="Mesh_PrimitiveAttribute_03_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitiveAttribute/Figures/SampleImages/Mesh_PrimitiveAttribute_03.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>04</td>
    <td><img src="Mesh_PrimitiveAttribute_04_preview.png" align="middle" width=200 /></td>
    <td><img src="Mesh_PrimitiveAttribute_04_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitiveAttribute/Figures/SampleImages/Mesh_PrimitiveAttribute_04.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>05</td>
    <td><img src="Mesh_PrimitiveAttribute_05_preview.png" align="middle" width=200 /></td>
    <td><img src="Mesh_PrimitiveAttribute_05_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitiveAttribute/Figures/SampleImages/Mesh_PrimitiveAttribute_05.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>06</td>
    <td></td>
    <td><img src="Mesh_PrimitiveAttribute_06_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitiveAttribute/Figures/SampleImages/Mesh_PrimitiveAttribute_06.png" align="middle" width=200 /></td>
  </tr>

  <tr align="middle">
    <td colspan="4">Mesh_PrimitiveMode</td>
  </tr>
  <tr align="middle">
    <td>04</td>
    <td><img src="Mesh_PrimitiveMode_04_preview.png" align="middle" width=200 /></td>
    <td><img src="Mesh_PrimitiveMode_04_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitiveMode/Figures/SampleImages/Mesh_PrimitiveMode_04.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>05</td>
    <td><img src="Mesh_PrimitiveMode_05_preview.png" align="middle" width=200 /></td>
    <td><img src="Mesh_PrimitiveMode_05_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitiveMode/Figures/SampleImages/Mesh_PrimitiveMode_05.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>06</td>
    <td><img src="Mesh_PrimitiveMode_06_preview.png" align="middle" width=200 /></td>
    <td><img src="Mesh_PrimitiveMode_06_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitiveMode/Figures/SampleImages/Mesh_PrimitiveMode_06.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>11</td>
    <td><img src="Mesh_PrimitiveMode_11_preview.png" align="middle" width=200 /></td>
    <td><img src="Mesh_PrimitiveMode_11_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitiveMode/Figures/SampleImages/Mesh_PrimitiveMode_11.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>12</td>
    <td><img src="Mesh_PrimitiveMode_12_preview.png" align="middle" width=200 /></td>
    <td><img src="Mesh_PrimitiveMode_12_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitiveMode/Figures/SampleImages/Mesh_PrimitiveMode_12.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>13</td>
    <td><img src="Mesh_PrimitiveMode_13_preview.png" align="middle" width=200 /></td>
    <td><img src="Mesh_PrimitiveMode_13_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitiveMode/Figures/SampleImages/Mesh_PrimitiveMode_13.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>14</td>
    <td><img src="Mesh_PrimitiveMode_14_preview.png" align="middle" width=200 /></td>
    <td><img src="Mesh_PrimitiveMode_14_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitiveMode/Figures/SampleImages/Mesh_PrimitiveMode_14.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>15</td>
    <td><img src="Mesh_PrimitiveMode_15_preview.png" align="middle" width=200 /></td>
    <td><img src="Mesh_PrimitiveMode_15_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitiveMode/Figures/SampleImages/Mesh_PrimitiveMode_15.png" align="middle" width=200 /></td>
  </tr>

  <tr align="middle">
    <td colspan="4">Mesh_PrimitiveVertexColor</td>
  </tr>
  <tr align="middle">
    <td>00</td>
    <td></td>
    <td><img src="Mesh_PrimitiveVertexColor_00_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitiveVertexColor/Figures/SampleImages/Mesh_PrimitiveVertexColor_00.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>01</td>
    <td></td>
    <td><img src="Mesh_PrimitiveVertexColor_01_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitiveVertexColor/Figures/SampleImages/Mesh_PrimitiveVertexColor_01.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>02</td>
    <td></td>
    <td><img src="Mesh_PrimitiveVertexColor_02_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitiveVertexColor/Figures/SampleImages/Mesh_PrimitiveVertexColor_02.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>03</td>
    <td></td>
    <td><img src="Mesh_PrimitiveVertexColor_03_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitiveVertexColor/Figures/SampleImages/Mesh_PrimitiveVertexColor_03.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>04</td>
    <td></td>
    <td><img src="Mesh_PrimitiveVertexColor_04_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitiveVertexColor/Figures/SampleImages/Mesh_PrimitiveVertexColor_04.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>05</td>
    <td></td>
    <td><img src="Mesh_PrimitiveVertexColor_05_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitiveVertexColor/Figures/SampleImages/Mesh_PrimitiveVertexColor_05.png" align="middle" width=200 /></td>
  </tr>

  <tr align="middle">
    <td colspan="4">Mesh_Primitives</td>
  </tr>
  <tr align="middle">
    <td>00</td>
    <td><img src="Mesh_Primitives_00_preview.png" align="middle" width=200 /></td>
    <td><img src="Mesh_Primitives_00_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_Primitives/Figures/SampleImages/Mesh_Primitives_00.png" align="middle" width=200 /></td>
  </tr>

  <tr align="middle">
    <td colspan="4">Mesh_PrimitivesUV</td>
  </tr>
  <tr align="middle">
    <td>00</td>
    <td><img src="Mesh_PrimitivesUV_00_preview.png" align="middle" width=200 /></td>
    <td><img src="Mesh_PrimitivesUV_00_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitivesUV/Figures/SampleImages/Mesh_PrimitivesUV_00.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
  <td>01</td>
    <td></td>
    <td><img src="Mesh_PrimitivesUV_01_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitivesUV/Figures/SampleImages/Mesh_PrimitivesUV_01.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>02</td>
    <td></td>
    <td><img src="Mesh_PrimitivesUV_02_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitivesUV/Figures/SampleImages/Mesh_PrimitivesUV_02.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>03</td>
    <td></td>
    <td><img src="Mesh_PrimitivesUV_03_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitivesUV/Figures/SampleImages/Mesh_PrimitivesUV_03.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>04</td>
    <td></td>
    <td><img src="Mesh_PrimitivesUV_04_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitivesUV/Figures/SampleImages/Mesh_PrimitivesUV_04.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>05</td>
    <td></td>
    <td><img src="Mesh_PrimitivesUV_05_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitivesUV/Figures/SampleImages/Mesh_PrimitivesUV_05.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>06</td>
    <td></td>
    <td><img src="Mesh_PrimitivesUV_06_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitivesUV/Figures/SampleImages/Mesh_PrimitivesUV_06.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>07</td>
    <td></td>
    <td><img src="Mesh_PrimitivesUV_07_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitivesUV/Figures/SampleImages/Mesh_PrimitivesUV_07.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>08</td>
    <td></td>
    <td><img src="Mesh_PrimitivesUV_08_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Mesh_PrimitivesUV/Figures/SampleImages/Mesh_PrimitivesUV_08.png" align="middle" width=200 /></td>
  </tr>

  <tr align="middle">
    <td colspan="4">Node_Attribute</td>
  </tr>
  <tr align="middle">
    <td>00</td>
    <td><img src="Node_Attribute_00_preview.png" align="middle" width=200 /></td>
    <td><img src="Node_Attribute_00_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Node_Attribute/Figures/SampleImages/Node_Attribute_00.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>01</td>
    <td><img src="Node_Attribute_01_preview.png" align="middle" width=200 /></td>
    <td><img src="Node_Attribute_01_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Node_Attribute/Figures/SampleImages/Node_Attribute_01.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>02</td>
    <td><img src="Node_Attribute_02_preview.png" align="middle" width=200 /></td>
    <td><img src="Node_Attribute_02_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Node_Attribute/Figures/SampleImages/Node_Attribute_02.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>03</td>
    <td><img src="Node_Attribute_03_preview.png" align="middle" width=200 /></td>
    <td><img src="Node_Attribute_03_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Node_Attribute/Figures/SampleImages/Node_Attribute_03.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>04</td>
    <td><img src="Node_Attribute_04_preview.png" align="middle" width=200 /></td>
    <td><img src="Node_Attribute_04_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Node_Attribute/Figures/SampleImages/Node_Attribute_04.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>05</td>
    <td><img src="Node_Attribute_05_preview.png" align="middle" width=200 /></td>
    <td><img src="Node_Attribute_05_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Node_Attribute/Figures/SampleImages/Node_Attribute_05.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>06</td>
    <td><img src="Node_Attribute_06_preview.png" align="middle" width=200 /></td>
    <td><img src="Node_Attribute_06_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Node_Attribute/Figures/SampleImages/Node_Attribute_06.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>07</td>
    <td><img src="Node_Attribute_07_preview.png" align="middle" width=200 /></td>
    <td><img src="Node_Attribute_07_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Node_Attribute/Figures/SampleImages/Node_Attribute_07.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>08</td>
    <td><img src="Node_Attribute_08_preview.png" align="middle" width=200 /></td>
    <td><img src="Node_Attribute_08_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Node_Attribute/Figures/SampleImages/Node_Attribute_08.png" align="middle" width=200 /></td>
  </tr>

  <tr align="middle">
    <td colspan="4">Node_NegativeScale</td>
  </tr>
  <tr align="middle">
    <td>00</td>
    <td><img src="Node_NegativeScale_00_preview.png" align="middle" width=200 /></td>
    <td><img src="Node_NegativeScale_00_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Node_NegativeScale/Figures/SampleImages/Node_NegativeScale_00.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>01</td>
    <td><img src="Node_NegativeScale_01_preview.png" align="middle" width=200 /></td>
    <td><img src="Node_NegativeScale_01_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Node_NegativeScale/Figures/SampleImages/Node_NegativeScale_01.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>02</td>
    <td><img src="Node_NegativeScale_02_preview.png" align="middle" width=200 /></td>
    <td><img src="Node_NegativeScale_02_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Node_NegativeScale/Figures/SampleImages/Node_NegativeScale_02.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>03</td>
    <td><img src="Node_NegativeScale_03_preview.png" align="middle" width=200 /></td>
    <td><img src="Node_NegativeScale_03_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Node_NegativeScale/Figures/SampleImages/Node_NegativeScale_03.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>04</td>
    <td><img src="Node_NegativeScale_04_preview.png" align="middle" width=200 /></td>
    <td><img src="Node_NegativeScale_04_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Node_NegativeScale/Figures/SampleImages/Node_NegativeScale_04.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>05</td>
    <td><img src="Node_NegativeScale_05_preview.png" align="middle" width=200 /></td>
    <td><img src="Node_NegativeScale_05_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Node_NegativeScale/Figures/SampleImages/Node_NegativeScale_05.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>06</td>
    <td><img src="Node_NegativeScale_06_preview.png" align="middle" width=200 /></td>
    <td><img src="Node_NegativeScale_06_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Node_NegativeScale/Figures/SampleImages/Node_NegativeScale_06.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>07</td>
    <td><img src="Node_NegativeScale_07_preview.png" align="middle" width=200 /></td>
    <td><img src="Node_NegativeScale_07_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Node_NegativeScale/Figures/SampleImages/Node_NegativeScale_07.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>08</td>
    <td><img src="Node_NegativeScale_08_preview.png" align="middle" width=200 /></td>
    <td><img src="Node_NegativeScale_08_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Node_NegativeScale/Figures/SampleImages/Node_NegativeScale_08.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>09</td>
    <td><img src="Node_NegativeScale_09_preview.png" align="middle" width=200 /></td>
    <td><img src="Node_NegativeScale_09_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Node_NegativeScale/Figures/SampleImages/Node_NegativeScale_09.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>10</td>
    <td></td>
    <td><img src="Node_NegativeScale_10_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Node_NegativeScale/Figures/SampleImages/Node_NegativeScale_10.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>11</td>
    <td></td>
    <td><img src="Node_NegativeScale_11_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Node_NegativeScale/Figures/SampleImages/Node_NegativeScale_11.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>12</td>
    <td></td>
    <td><img src="Node_NegativeScale_12_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Node_NegativeScale/Figures/SampleImages/Node_NegativeScale_12.png" align="middle" width=200 /></td>
  </tr>

  <tr align="middle">
    <td colspan="4">Texture_Sampler</td>
  </tr>
  <tr align="middle">
    <td>00</td>
    <td></td>
    <td><img src="Texture_Sampler_00_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Texture_Sampler/Figures/SampleImages/Texture_Sampler_00.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>01</td>
    <td></td>
    <td><img src="Texture_Sampler_01_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Texture_Sampler/Figures/SampleImages/Texture_Sampler_01.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>02</td>
    <td></td>
    <td><img src="Texture_Sampler_02_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Texture_Sampler/Figures/SampleImages/Texture_Sampler_02.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>03</td>
    <td></td>
    <td><img src="Texture_Sampler_03_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Texture_Sampler/Figures/SampleImages/Texture_Sampler_03.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>04</td>
    <td></td>
    <td><img src="Texture_Sampler_04_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Texture_Sampler/Figures/SampleImages/Texture_Sampler_04.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>05</td>
    <td></td>
    <td><img src="Texture_Sampler_05_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Texture_Sampler/Figures/SampleImages/Texture_Sampler_05.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>06</td>
    <td></td>
    <td><img src="Texture_Sampler_06_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Texture_Sampler/Figures/SampleImages/Texture_Sampler_06.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>07</td>
    <td></td>
    <td><img src="Texture_Sampler_07_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Texture_Sampler/Figures/SampleImages/Texture_Sampler_07.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>08</td>
    <td></td>
    <td><img src="Texture_Sampler_08_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Texture_Sampler/Figures/SampleImages/Texture_Sampler_08.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>09</td>
    <td></td>
    <td><img src="Texture_Sampler_09_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Texture_Sampler/Figures/SampleImages/Texture_Sampler_09.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>10</td>
    <td></td>
    <td><img src="Texture_Sampler_10_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Texture_Sampler/Figures/SampleImages/Texture_Sampler_10.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>11</td>
    <td></td>
    <td><img src="Texture_Sampler_11_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Texture_Sampler/Figures/SampleImages/Texture_Sampler_11.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>12</td>
    <td></td>
    <td><img src="Texture_Sampler_12_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Texture_Sampler/Figures/SampleImages/Texture_Sampler_12.png" align="middle" width=200 /></td>
  </tr>
  <tr align="middle">
    <td>13</td>
    <td></td>
    <td><img src="Texture_Sampler_13_mtlx.png" align="middle" width=200 /></td>
    <td><img src="https://github.com/KhronosGroup/glTF-Asset-Generator/raw/a2b0117b41a66d17f2a1860c81da498da65b6054/Output/Positive/Texture_Sampler/Figures/SampleImages/Texture_Sampler_13.png" align="middle" width=200 /></td>
  </tr>
</table>

### glTF-Sample-Models (<a href="https://github.com/KhronosGroup/glTF-Sample-Models/tree/master/2.0">source</a>)

Complex Models

<table>
  <tr>
    <th>Name</th>
    <th>USD+UsdPreviewSurface</th>
    <th>USD+MaterialX</th>
  </tr>
  <tr>
    <td>2CylinderEngine</td>
    <td><img src="2CylinderEngine_preview.png" align="middle" width=350 /></td>
    <td><img src="2CylinderEngine_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>ABeautifulGame</td>
    <td><img src="ABeautifulGame_preview.png" align="middle" width=350 /></td>
    <td><img src="ABeautifulGame_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>DamagedHelmet</td>
    <td><img src="DamagedHelmet_preview.png" align="middle" width=350 /></td>
    <td><img src="DamagedHelmet_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>IridescenceLamp</td>
    <td><img src="IridescenceLamp_preview.png" align="middle" width=350 /></td>
    <td><img src="IridescenceLamp_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>IridescentDishWithOlives</td>
    <td><img src="IridescentDishWithOlives_preview.png" align="middle" width=350 /></td>
    <td><img src="IridescentDishWithOlives_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>MosquitoInAmber</td>
    <td><img src="MosquitoInAmber_preview.png" align="middle" width=350 /></td>
    <td><img src="MosquitoInAmber_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>SheenCloth</td>
    <td><img src="SheenCloth_preview.png" align="middle" width=350 /></td>
    <td><img src="SheenCloth_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>StainedGlassLamp</td>
    <td><img src="StainedGlassLamp_preview.png" align="middle" width=350 /></td>
    <td><img src="StainedGlassLamp_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>ToyCar</td>
    <td><img src="ToyCar_preview.png" align="middle" width=350 /></td>
    <td><img src="ToyCar_mtlx.png" align="middle" width=350 /></td>
  </tr>
</table>

Feature Tests

<table>
  <tr>
    <th>Name</th>
    <th>USD+UsdPreviewSurface</th>
    <th>USD+MaterialX</th>
  </tr>
  <tr>
    <td>AlphaBlendModeTest</td>
    <td><img src="AlphaBlendModeTest_preview.png" align="middle" width=350 /></td>
    <td><img src="AlphaBlendModeTest_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>AttenuationTest</td>
    <td><img src="AttenuationTest_preview.png" align="middle" width=350 /></td>
    <td><img src="AttenuationTest_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>ClearCoatTest</td>
    <td><img src="ClearCoatTest_preview.png" align="middle" width=350 /></td>
    <td><img src="ClearCoatTest_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>EmissiveStrengthTest</td>
    <td><img src="EmissiveStrengthTest_preview.png" align="middle" width=350 /></td>
    <td><img src="EmissiveStrengthTest_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>EnvironmentTest</td>
    <td><img src="EnvironmentTest_preview.png" align="middle" width=350 /></td>
    <td><img src="EnvironmentTest_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>IridescenceDielectricSpheres</td>
    <td><img src="IridescenceDielectricSpheres_preview.png" align="middle" width=350 /></td>
    <td><img src="IridescenceDielectricSpheres_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>IridescenceMetallicSpheres</td>
    <td><img src="IridescenceMetallicSpheres_preview.png" align="middle" width=350 /></td>
    <td><img src="IridescenceMetallicSpheres_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>LightsPunctualLamp</td>
    <td><img src="LightsPunctualLamp_preview.png" align="middle" width=350 /></td>
    <td><img src="LightsPunctualLamp_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>MetalRoughSpheres</td>
    <td><img src="MetalRoughSpheres_preview.png" align="middle" width=350 /></td>
    <td><img src="MetalRoughSpheres_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>MetalRoughSpheresNoTextures</td>
    <td><img src="MetalRoughSpheresNoTextures_preview.png" align="middle" width=350 /></td>
    <td><img src="MetalRoughSpheresNoTextures_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>MultiUVTest</td>
    <td><img src="MultiUVTest_preview.png" align="middle" width=350 /></td>
    <td><img src="MultiUVTest_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>NormalTangentMirrorTest</td>
    <td><img src="NormalTangentMirrorTest_preview.png" align="middle" width=350 /></td>
    <td><img src="NormalTangentMirrorTest_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>NormalTangentTest</td>
    <td><img src="NormalTangentTest_preview.png" align="middle" width=350 /></td>
    <td><img src="NormalTangentTest_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>OrientationTest</td>
    <td><img src="OrientationTest_preview.png" align="middle" width=350 /></td>
    <td><img src="OrientationTest_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>SpecularTest</td>
    <td><img src="SpecularTest_preview.png" align="middle" width=350 /></td>
    <td><img src="SpecularTest_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>TextureCoordinateTest</td>
    <td><img src="TextureCoordinateTest_preview.png" align="middle" width=350 /></td>
    <td><img src="TextureCoordinateTest_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>TextureEncodingTest</td>
    <td><img src="TextureEncodingTest_preview.png" align="middle" width=350 /></td>
    <td><img src="TextureEncodingTest_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>TextureSettingsTest</td>
    <td><img src="TextureSettingsTest_preview.png" align="middle" width=350 /></td>
    <td><img src="TextureSettingsTest_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>TextureTransformTest</td>
    <td><img src="TextureTransformTest_preview.png" align="middle" width=350 /></td>
    <td><img src="TextureTransformTest_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>TextureTransformMultiTest</td>
    <td><img src="TextureTransformMultiTest_preview.png" align="middle" width=350 /></td>
    <td><img src="TextureTransformMultiTest_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>TransmissionRoughnessTest</td>
    <td><img src="TransmissionRoughnessTest_preview.png" align="middle" width=350 /></td>
    <td><img src="TransmissionRoughnessTest_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>TransmissionTest</td>
    <td><img src="TransmissionTest_preview.png" align="middle" width=350 /></td>
    <td><img src="TransmissionTest_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>UnlitTest</td>
    <td><img src="UnlitTest_preview.png" align="middle" width=350 /></td>
    <td><img src="UnlitTest_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>VertexColorTest</td>
    <td><img src="VertexColorTest_preview.png" align="middle" width=350 /></td>
    <td><img src="VertexColorTest_mtlx.png" align="middle" width=350 /></td>
  </tr>
</table>

### Third-party glTF models

<table>
  <tr>
    <th>Name</th>
    <th>USD+UsdPreviewSurface</th>
    <th>USD+MaterialX</th>
  </tr>
  <tr>
    <td>Camera_01</td>
    <td><img src="Camera_01_preview.png" align="middle" width=350 /></td>
    <td><img src="Camera_01_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>CoffeeCart_01</td>
    <td><img src="CoffeeCart_01_preview.png" align="middle" width=350 /></td>
    <td><img src="CoffeeCart_01_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>Fangyi</td>
    <td><img src="Fangyi_preview.png" align="middle" width=350 /></td>
    <td><img src="Fangyi_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>Loewe_von_Asparn</td>
    <td><img src="Loewe_von_Asparn_preview.png" align="middle" width=350 /></td>
    <td><img src="Loewe_von_Asparn_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>Perseverance</td>
    <td><img src="Perseverance_preview.png" align="middle" width=350 /></td>
    <td><img src="Perseverance_mtlx.png" align="middle" width=350 /></td>
  </tr>
  <tr>
    <td>Space_Shuttle</td>
    <td><img src="Space_Shuttle_preview.png" align="middle" width=350 /></td>
    <td><img src="Space_Shuttle_mtlx.png" align="middle" width=350 /></td>
  </tr>
</table>

### Custom Tests

<table>
  <tr>
    <th colspan=3>MaterialVariants</th>
  </tr>
  <tr>
    <th>Variant</th>
    <th>UsdPreviewSurface</th>
    <th>MaterialX</th>
  </tr>
  <tr>
    <td>Midnight (0, default)</td>
    <td><img src="MaterialVariants_Variant0_preview.png" align="middle" width=300 /></td>
    <td><img src="MaterialVariants_Variant0_mtlx.png" align="middle" width=300 /></td>
  </tr>
  <tr>
    <td>Beach (1)</td>
    <td><img src="MaterialVariants_Variant1_preview.png" align="middle" width=300 /></td>
    <td><img src="MaterialVariants_Variant1_mtlx.png" align="middle" width=300 /></td>
  </tr>
</table>

## Discussion

Minor observations:
* **Brightness differences**  
Between the UsdPreviewSurface and glTF PBR shading models, the specular response is most likely the cause (see MetalRoughSpheresNoTextures).
* **Missing transmission color attenuation**  
For instance, in the TransmissionTest sample model. This seems to be a current limitation of HdStorm's MaterialX integration.
* **TextureSettingsTest seems to fail**  
It's actually working, but backface culling is disabled by default.

Failures:
* **Material\_04 looks more specular than it should**  
This hints at an actual issue in either 1) guc's handling of normal maps, 2) the MaterialX glTF PBR implementation, 3) MaterialXGenGlsl or 4) HdStorm.
* **ToyCar model cloth is too bright and has shading artifacts**  
The artifacts exist in MaterialXView too, suggesting an issue with the GLSL sheen implementation, or the MaterialX glTF PBR.
