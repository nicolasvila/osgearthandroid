# Install script for directory: /home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures

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
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/osgEarthFeatures" TYPE FILE FILES
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/AltitudeFilter"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/BufferFilter"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/BuildGeometryFilter"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/BuildTextFilter"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/BuildTextOperator"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/CentroidFilter"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/Common"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/ConvertTypeFilter"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/CropFilter"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/ExtrudeGeometryFilter"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/Feature"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/FeatureCursor"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/FeatureDisplayLayout"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/FeatureDrawSet"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/FeatureListSource"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/FeatureModelGraph"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/FeatureModelSource"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/FeatureSource"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/FeatureSourceIndexNode"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/FeatureTileSource"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/Filter"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/FilterContext"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/GeometryCompiler"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/GeometryUtils"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/LabelSource"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/MeshClamper"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/OgrUtils"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/OptimizerHints"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/ResampleFilter"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/ScaleFilter"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/Session"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/ScatterFilter"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/Script"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/ScriptEngine"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/SubstituteModelFilter"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/TessellateOperator"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/TextSymbolizer"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/TransformFilter"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures/VirtualFeatureSource"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "libosgearth-dev")

