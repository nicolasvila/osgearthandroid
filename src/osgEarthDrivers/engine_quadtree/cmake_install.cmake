# Install script for directory: /home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/engine_quadtree

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

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/osgEarthDrivers/engine_quadtree" TYPE FILE FILES
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/engine_quadtree/Common"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/engine_quadtree/CustomPagedLOD"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/engine_quadtree/DynamicLODScaleCallback"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/engine_quadtree/FileLocationCallback"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/engine_quadtree/KeyNodeFactory"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/engine_quadtree/LODFactorCallback"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/engine_quadtree/QuadTreeTerrainEngineNode"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/engine_quadtree/QuadTreeTerrainEngineOptions"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/engine_quadtree/QuickReleaseGLObjects"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/engine_quadtree/SerialKeyNodeFactory"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/engine_quadtree/TerrainNode"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/engine_quadtree/TileModel"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/engine_quadtree/TileModelCompiler"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/engine_quadtree/TileNode"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/engine_quadtree/TileNodeRegistry"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/engine_quadtree/TileModelFactory"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")

