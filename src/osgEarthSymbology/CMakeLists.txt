IF   (DYNAMIC_OSGEARTH)
    ADD_DEFINITIONS(-DOSGEARTHSYMBOLOGY_LIBRARY)
ELSE (DYNAMIC_OSGEARTH)
    ADD_DEFINITIONS(-DOSGEARTHSYMBOLOGY_LIBRARY_STATIC)
ENDIF(DYNAMIC_OSGEARTH)

IF (GEOS_FOUND)
    ADD_DEFINITIONS(-DOSGEARTH_HAVE_GEOS)
ENDIF(GEOS_FOUND)

SET(LIB_NAME osgEarthSymbology)

SET(HEADER_PATH ${OSGEARTH_SOURCE_DIR}/include/${LIB_NAME})
SET(TARGET_H
#   header files go here
    AGG.h
    AltitudeSymbol
    Common
    Color
    CssUtils
    Expression
    ExtrusionSymbol
    Geometry
    GeometryFactory
    GEOS
    GeometryRasterizer
    IconResource
    IconSymbol
    InstanceResource
    InstanceSymbol
    LineSymbol
    MarkerResource
    MarkerSymbol
    MeshConsolidator
    MeshSubdivider
    ModelResource
    ModelSymbol
    PointSymbol
    PolygonSymbol
    Query
    RenderSymbol
    Resource
    ResourceCache
    ResourceLibrary
    Skins
    StencilVolumeNode
    Style
    StyleSelector
    StyleSheet
    Symbol
    Tags
    TextSymbol
)

SET(TARGET_SRC
#  .cpp files go here
    AltitudeSymbol.cpp
    Color.cpp
    CssUtils.cpp
    Expression.cpp
    ExtrusionSymbol.cpp
    Geometry.cpp
    GeometryFactory.cpp
    GEOS.cpp
    GeometryRasterizer.cpp
    IconResource.cpp
    IconSymbol.cpp
    InstanceResource.cpp
    InstanceSymbol.cpp
    LineSymbol.cpp
    MarkerResource.cpp
    MarkerSymbol.cpp
    MeshConsolidator.cpp
    MeshSubdivider.cpp
    ModelResource.cpp
    ModelSymbol.cpp
    PointSymbol.cpp
    PolygonSymbol.cpp
    Query.cpp
    RenderSymbol.cpp
    Resource.cpp
    ResourceCache.cpp
    ResourceLibrary.cpp
    Skins.cpp
    StencilVolumeNode.cpp
    Style.cpp
    StyleSelector.cpp
    StyleSheet.cpp
    Symbol.cpp
    TextSymbol.cpp
)

IF(GEOS_FOUND)
  INCLUDE_DIRECTORIES(${OSG_INCLUDE_DIR} ${OSGEARTH_SOURCE_DIR} ${GEOS_INCLUDE_DIR})
ELSE(GEOS_FOUND)
  INCLUDE_DIRECTORIES(${OSG_INCLUDE_DIR} ${OSGEARTH_SOURCE_DIR})
ENDIF(GEOS_FOUND)

IF (WIN32)
  SET(TARGET_EXTERNAL_LIBRARIES ${TARGET_EXTERNAL_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT} ${MATH_LIBRARY})
ELSE(WIN32)
  SET(TARGET_EXTERNAL_LIBRARIES ${TARGET_EXTERNAL_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT} ${MATH_LIBRARY})
ENDIF(WIN32)

SET(TARGET_LIBRARIES
    osgEarth
)

IF(GEOS_FOUND)
   SET(TARGET_LIBRARIES_VARS OSG_LIBRARY OSGWIDGET_LIBRARY OSGUTIL_LIBRARY OSGSIM_LIBRARY OSGTERRAIN_LIBRARY OSGDB_LIBRARY OSGFX_LIBRARY OSGVIEWER_LIBRARY OSGTEXT_LIBRARY OSGGA_LIBRARY OPENTHREADS_LIBRARY GEOS_LIBRARY)
ELSE(GEOS_FOUND)
  LINK_WITH_VARIABLES(${LIB_NAME} OSG_LIBRARY OSGWIDGET_LIBRARY OSGUTIL_LIBRARY OSGSIM_LIBRARY OSGTERRAIN_LIBRARY OSGDB_LIBRARY OSGFX_LIBRARY OSGVIEWER_LIBRARY OSGTEXT_LIBRARY OSGGA_LIBRARY OPENTHREADS_LIBRARY)
ENDIF(GEOS_FOUND)


SETUP_LIBRARY(${LIB_NAME})


#LINK_CORELIB_DEFAULT(${LIB_NAME} ${CMAKE_THREAD_LIBS_INIT} ${MATH_LIBRARY})

#INCLUDE(ModuleInstall OPTIONAL)
