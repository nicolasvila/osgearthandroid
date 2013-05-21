# Install script for directory: /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgFX

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
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/osgFX" TYPE FILE FILES
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgFX/AnisotropicLighting"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgFX/BumpMapping"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgFX/Cartoon"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgFX/Effect"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgFX/Export"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgFX/MultiTextureControl"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgFX/Outline"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgFX/Registry"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgFX/Scribe"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgFX/SpecularHighlights"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgFX/Technique"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgFX/Validator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgFX/Version"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "libopenscenegraph-dev")

