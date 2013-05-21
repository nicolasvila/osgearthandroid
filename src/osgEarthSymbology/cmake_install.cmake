# Install script for directory: /home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology

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
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/osgEarthSymbology" TYPE FILE FILES
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/AGG.h"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/AltitudeSymbol"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/Common"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/Color"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/CssUtils"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/Expression"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/ExtrusionSymbol"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/Geometry"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/GeometryFactory"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/GEOS"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/GeometryRasterizer"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/IconResource"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/IconSymbol"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/InstanceResource"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/InstanceSymbol"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/LineSymbol"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/MarkerResource"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/MarkerSymbol"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/MeshConsolidator"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/MeshSubdivider"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/ModelResource"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/ModelSymbol"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/PointSymbol"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/PolygonSymbol"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/Query"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/RenderSymbol"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/Resource"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/ResourceCache"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/ResourceLibrary"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/Skins"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/StencilVolumeNode"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/Style"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/StyleSelector"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/StyleSheet"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/Symbol"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/Tags"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology/TextSymbol"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "libosgearth-dev")

