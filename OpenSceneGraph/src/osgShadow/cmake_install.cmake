# Install script for directory: /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgShadow

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
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/osgShadow" TYPE FILE FILES
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgShadow/Export"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgShadow/OccluderGeometry"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgShadow/ShadowMap"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgShadow/ShadowTechnique"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgShadow/ShadowTexture"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgShadow/ShadowVolume"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgShadow/ShadowedScene"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgShadow/ShadowSettings"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgShadow/SoftShadowMap"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgShadow/ParallelSplitShadowMap"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgShadow/Version"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgShadow/ConvexPolyhedron"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgShadow/DebugShadowMap"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgShadow/LightSpacePerspectiveShadowMap"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgShadow/MinimalCullBoundsShadowMap"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgShadow/MinimalDrawBoundsShadowMap"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgShadow/MinimalShadowMap"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgShadow/ProjectionShadowMap"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgShadow/StandardShadowMap"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgShadow/ViewDependentShadowTechnique"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgShadow/ViewDependentShadowMap"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "libopenscenegraph-dev")

