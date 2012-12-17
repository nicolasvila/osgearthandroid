# Install script for directory: /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgDB

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
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/osgDB" TYPE FILE FILES
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/DataTypes"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/StreamOperator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/Serializer"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/ObjectWrapper"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/InputStream"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/OutputStream"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/Archive"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/AuthenticationMap"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/Callbacks"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/ConvertUTF"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/DatabasePager"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/DatabaseRevisions"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/DotOsgWrapper"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/DynamicLibrary"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/Export"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/ExternalFileWriter"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/FileCache"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/FileNameUtils"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/FileUtils"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/fstream"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/ImageOptions"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/ImagePager"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/ImageProcessor"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/Input"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/Output"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/Options"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/ParameterOutput"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/PluginQuery"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/ReaderWriter"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/ReadFile"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/Registry"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/SharedStateManager"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/Version"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/WriteFile"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgDB/XmlParser"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "libopenscenegraph-dev")

