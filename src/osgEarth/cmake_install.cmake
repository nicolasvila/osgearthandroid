# Install script for directory: /home/paulo/osgEarthAndroid/osgearth/src/osgEarth

# Set the install prefix
IF(NOT DEFINED CMAKE_INSTALL_PREFIX)
  SET(CMAKE_INSTALL_PREFIX "/usr/local")
ENDIF(NOT DEFINED CMAKE_INSTALL_PREFIX)
STRING(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
IF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  IF(BUILD_TYPE)
    STRING(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  ELSE(BUILD_TYPE)
    SET(CMAKE_INSTALL_CONFIG_NAME "")
  ENDIF(BUILD_TYPE)
  MESSAGE(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
ENDIF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)

# Set the component getting installed.
IF(NOT CMAKE_INSTALL_COMPONENT)
  IF(COMPONENT)
    MESSAGE(STATUS "Install component: \"${COMPONENT}\"")
    SET(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  ELSE(COMPONENT)
    SET(CMAKE_INSTALL_COMPONENT)
  ENDIF(COMPONENT)
ENDIF(NOT CMAKE_INSTALL_COMPONENT)

# Install shared libraries without execute permission?
IF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  SET(CMAKE_INSTALL_SO_NO_EXE "1")
ENDIF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "libosgearth-dev")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/osgEarth" TYPE FILE FILES
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/AndroidCapabilities"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/Bounds"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/Cache"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/CacheBin"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/CachePolicy"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/CacheSeed"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/Capabilities"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/ClampableNode"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/ClampingTechnique"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/ClampingBinTechnique"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/ColorFilter"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/Common"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/CompositeTileSource"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/Config"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/Containers"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/Cube"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/CullingUtils"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/DepthOffset"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/DPLineSegmentIntersector"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/Draggers"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/DrapeableNode"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/DrapingTechnique"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/DrawInstanced"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/ECEF"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/ElevationLayer"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/ElevationLOD"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/ElevationQuery"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/Export"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/FadeEffect"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/FileUtils"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/GeoCommon"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/GeoData"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/Geoid"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/GeoMath"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/HeightFieldUtils"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/HTTPClient"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/ImageLayer"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/ImageMosaic"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/ImageToHeightFieldConverter"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/ImageUtils"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/IOTypes"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/JsonUtils"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/Layer"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/LineFunctor"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/Locators"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/LocalTangentPlane"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/Map"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/MapCallback"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/MapFrame"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/MapInfo"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/MapModelChange"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/MapNode"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/MapNodeObserver"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/MapNodeOptions"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/MapOptions"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/MaskLayer"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/MaskNode"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/MaskSource"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/MemCache"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/ModelLayer"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/ModelSource"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/NodeUtils"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/Notify"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/optional"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/OverlayDecorator"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/OverlayNode"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/Pickers"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/Profile"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/Progress"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/Random"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/Registry"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/Revisioning"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/ShaderFactory"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/ShaderGenerator"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/ShaderUtils"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/SparseTexture2DArray"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/SpatialReference"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/StateSetCache"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/StringUtils"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/TaskService"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/Terrain"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/TerrainLayer"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/TerrainOptions"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/TerrainEngineNode"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/TextureCompositor"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/TextureCompositorMulti"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/TextureCompositorTexArray"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/TileKey"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/TileSource"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/ThreadingUtils"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/Units"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/URI"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/Utils"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/Version"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/VerticalDatum"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/Viewpoint"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/VirtualProgram"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/XmlUtils"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/tinystr.h"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarth/tinyxml.h"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "libosgearth-dev")

