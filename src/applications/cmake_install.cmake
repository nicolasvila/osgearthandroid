# Install script for directory: /home/paulo/osgEarthAndroid/osgearth/src/applications

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
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_viewer/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_seed/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_featureinfo/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_package/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_tfs/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_boundarygen/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_backfill/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_overlayviewer/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_version/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_clamp/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_manip/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_toc/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_elevation/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_features/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_featurefilter/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_los/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_terrainprofile/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_map/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_annotation/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_tracks/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_measure/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_controls/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_shadercomp/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_tilesource/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_imageoverlay/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_city/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_graticule/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_featuremanip/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_featurequery/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_occlusionculling/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_colorfilter/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_contour/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_verticalscale/cmake_install.cmake")

ENDIF(NOT CMAKE_INSTALL_LOCAL_ONLY)

