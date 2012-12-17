# Install script for directory: /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgWidget

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
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/osgWidget" TYPE FILE FILES
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgWidget/Export"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgWidget/Box"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgWidget/Browser"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgWidget/PdfReader"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgWidget/VncClient"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgWidget/Canvas"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgWidget/EventInterface"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgWidget/Frame"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgWidget/Input"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgWidget/Label"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgWidget/Lua"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgWidget/Python"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgWidget/ScriptEngine"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgWidget/StyleInterface"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgWidget/StyleManager"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgWidget/Table"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgWidget/Types"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgWidget/UIObjectParent"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgWidget/Util"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgWidget/Version"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgWidget/ViewerEventHandlers"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgWidget/Widget"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgWidget/Window"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgWidget/WindowManager"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "libopenscenegraph-dev")

