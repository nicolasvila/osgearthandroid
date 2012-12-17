# Install script for directory: /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgSim

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

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "libopenscenegraph-dev")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/osgSim" TYPE FILE FILES
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgSim/BlinkSequence"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgSim/ColorRange"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgSim/DOFTransform"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgSim/ElevationSlice"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgSim/HeightAboveTerrain"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgSim/Export"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgSim/GeographicLocation"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgSim/Impostor"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgSim/ImpostorSprite"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgSim/InsertImpostorsVisitor"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgSim/LightPoint"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgSim/LightPointNode"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgSim/LightPointSystem"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgSim/LineOfSight"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgSim/MultiSwitch"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgSim/OverlayNode"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgSim/ObjectRecordData"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgSim/ScalarBar"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgSim/ScalarsToColors"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgSim/Sector"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgSim/ShapeAttribute"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgSim/SphereSegment"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgSim/Version"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgSim/VisibilityGroup"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "libopenscenegraph-dev")

