# Install script for directory: /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src

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

IF(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/OpenThreads/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osg/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgDB/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgUtil/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgGA/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgText/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgViewer/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgAnimation/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgFX/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgManipulator/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgParticle/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgPresentation/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgShadow/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgSim/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgTerrain/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgWidget/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgVolume/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgWrappers/serializers/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgWrappers/deprecated-dotosg/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgPlugins/cmake_install.cmake")

ENDIF(NOT CMAKE_INSTALL_LOCAL_ONLY)

