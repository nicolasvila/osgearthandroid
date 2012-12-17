# Install script for directory: /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgText

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
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/osgText" TYPE FILE FILES
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgText/Export"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgText/Font"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgText/Font3D"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgText/FadeText"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgText/Glyph"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgText/KerningType"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgText/String"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgText/Style"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgText/TextBase"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgText/Text"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgText/Text3D"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgText/Version"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "libopenscenegraph-dev")

