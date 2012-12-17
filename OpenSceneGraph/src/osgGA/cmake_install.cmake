# Install script for directory: /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgGA

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
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/osgGA" TYPE FILE FILES
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgGA/AnimationPathManipulator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgGA/DriveManipulator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgGA/EventQueue"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgGA/EventVisitor"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgGA/Export"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgGA/FirstPersonManipulator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgGA/FlightManipulator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgGA/GUIActionAdapter"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgGA/GUIEventAdapter"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgGA/GUIEventHandler"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgGA/KeySwitchMatrixManipulator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgGA/CameraManipulator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgGA/MultiTouchTrackballManipulator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgGA/NodeTrackerManipulator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgGA/OrbitManipulator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgGA/StandardManipulator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgGA/SphericalManipulator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgGA/StateSetManipulator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgGA/TerrainManipulator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgGA/TrackballManipulator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgGA/UFOManipulator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgGA/Version"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgGA/CameraViewSwitchManipulator"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "libopenscenegraph-dev")

