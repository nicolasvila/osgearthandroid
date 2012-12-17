# Install script for directory: /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgUtil

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
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/osgUtil" TYPE FILE FILES
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/ConvertVec"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/CubeMapGenerator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/CullVisitor"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/DelaunayTriangulator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/DisplayRequirementsVisitor"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/DrawElementTypeSimplifier"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/EdgeCollector"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/Export"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/GLObjectsVisitor"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/HalfWayMapGenerator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/HighlightMapGenerator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/IntersectionVisitor"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/IntersectVisitor"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/IncrementalCompileOperation"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/LineSegmentIntersector"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/MeshOptimizers"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/OperationArrayFunctor"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/Optimizer"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/PerlinNoise"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/PlaneIntersector"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/PolytopeIntersector"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/PositionalStateContainer"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/PrintVisitor"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/ReflectionMapGenerator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/RenderBin"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/RenderLeaf"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/RenderStage"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/ReversePrimitiveFunctor"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/SceneView"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/SceneGraphBuilder"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/ShaderGen"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/Simplifier"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/SmoothingVisitor"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/StateGraph"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/Statistics"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/TangentSpaceGenerator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/Tessellator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/TransformAttributeFunctor"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/TransformCallback"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/TriStripVisitor"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/UpdateVisitor"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgUtil/Version"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "libopenscenegraph-dev")

