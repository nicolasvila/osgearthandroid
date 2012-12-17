# Install script for directory: /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgManipulator

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
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/osgManipulator" TYPE FILE FILES
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgManipulator/AntiSquish"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgManipulator/Command"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgManipulator/CommandManager"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgManipulator/Constraint"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgManipulator/Dragger"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgManipulator/Export"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgManipulator/Projector"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgManipulator/RotateCylinderDragger"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgManipulator/RotateSphereDragger"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgManipulator/Scale1DDragger"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgManipulator/Scale2DDragger"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgManipulator/ScaleAxisDragger"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgManipulator/Selection"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgManipulator/TabBoxDragger"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgManipulator/TabBoxTrackballDragger"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgManipulator/TabPlaneDragger"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgManipulator/TabPlaneTrackballDragger"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgManipulator/TrackballDragger"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgManipulator/Translate1DDragger"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgManipulator/Translate2DDragger"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgManipulator/TranslateAxisDragger"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgManipulator/TranslatePlaneDragger"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgManipulator/Version"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "libopenscenegraph-dev")
