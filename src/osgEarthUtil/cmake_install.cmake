# Install script for directory: /home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil

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
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/osgEarthUtil" TYPE FILE FILES
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/AnnotationEvents"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/AutoClipPlaneHandler"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/Common"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/Controls"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/ClampCallback"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/EarthManipulator"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/ElevationManager"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/ExampleResources"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/Export"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/FeatureManipTool"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/FeatureQueryTool"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/Formatter"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/GeodeticGraticule"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/LatLongFormatter"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/LineOfSight"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/LinearLineOfSight"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/MeasureTool"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/MGRSFormatter"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/MGRSGraticule"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/MouseCoordsTool"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/ObjectPlacer"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/ObjectLocator"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/PolyhedralLineOfSight"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/RadialLineOfSight"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/SkyNode"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/SpatialData"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/StarData"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/TerrainProfile"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/TFS"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/TFSPackager"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/TMS"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/TMSBackFiller"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/TMSPackager"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/UTMGraticule"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/WFS"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/WMS"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/BrightnessContrastColorFilter"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/CMYKColorFilter"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/GammaColorFilter"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/HSLColorFilter"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/RGBColorFilter"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil/ChromaKeyColorFilter"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "libosgearth-dev")

