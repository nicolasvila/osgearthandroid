# Install script for directory: /home/paulo/osgEarthAndroid/osgearth/src/osgEarthAnnotation

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

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "libosgearth-dev")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/osgEarthAnnotation" TYPE FILE FILES
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthAnnotation/AnnotationSettings"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthAnnotation/AnnotationEditing"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthAnnotation/AnnotationData"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthAnnotation/AnnotationNode"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthAnnotation/AnnotationRegistry"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthAnnotation/AnnotationUtils"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthAnnotation/CircleNode"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthAnnotation/Common"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthAnnotation/Decluttering"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthAnnotation/Decoration"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthAnnotation/EllipseNode"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthAnnotation/Export"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthAnnotation/FeatureNode"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthAnnotation/LocalGeometryNode"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthAnnotation/HighlightDecoration"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthAnnotation/ImageOverlay"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthAnnotation/ImageOverlayEditor"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthAnnotation/LabelNode"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthAnnotation/LocalizedNode"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthAnnotation/ModelNode"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthAnnotation/OrthoNode"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthAnnotation/PlaceNode"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthAnnotation/RectangleNode"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthAnnotation/ScaleDecoration"
    "/home/paulo/osgEarthAndroid/osgearth/src/osgEarthAnnotation/TrackNode"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "libosgearth-dev")

