# Install script for directory: /home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers

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
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/earth/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/kml/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/wcs/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/wms/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/tilecache/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/tileservice/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/yahoo/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/arcgis_map_cache/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/arcgis/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/tms/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/vpb/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/osg/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/agglite/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/model_simple/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/debug/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/cache_filesystem/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/ocean_surface/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/refresh/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/xyz/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/gdal/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/feature_ogr/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/feature_wfs/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/feature_tfs/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/model_feature_stencil/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/model_feature_geom/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/mask_feature/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/label_overlay/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/label_annotation/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/mbtiles/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/engine_osgterrain/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/engine_quadtree/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/vdatum_egm84/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/vdatum_egm96/cmake_install.cmake")
  INCLUDE("/home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/vdatum_egm2008/cmake_install.cmake")

ENDIF(NOT CMAKE_INSTALL_LOCAL_ONLY)

