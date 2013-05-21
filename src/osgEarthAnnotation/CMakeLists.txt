IF   (DYNAMIC_OSGEARTH)
    ADD_DEFINITIONS(-DOSGEARTHANNO_LIBRARY)
ELSE (DYNAMIC_OSGEARTH)
    ADD_DEFINITIONS(-DOSGEARTHANNO_LIBRARY_STATIC)
ENDIF(DYNAMIC_OSGEARTH)

SET(LIB_NAME osgEarthAnnotation)

SET(HEADER_PATH ${OSGEARTH_SOURCE_DIR}/include/${LIB_NAME})

SET(TARGET_H 
    AnnotationSettings
    AnnotationEditing
    AnnotationData
    AnnotationNode
    AnnotationRegistry
    AnnotationUtils
    CircleNode
    Common
    Decluttering
    Decoration
    EllipseNode
    Export
    FeatureNode
    LocalGeometryNode
    HighlightDecoration
    ImageOverlay
    ImageOverlayEditor
    LabelNode
    LocalizedNode
    ModelNode
    OrthoNode
    PlaceNode
	RectangleNode
    ScaleDecoration
    TrackNode
)

SET(TARGET_SRC
    AnnotationEditing.cpp
    AnnotationSettings.cpp
    AnnotationData.cpp
    AnnotationNode.cpp
    AnnotationRegistry.cpp
    AnnotationUtils.cpp
    CircleNode.cpp
    Decluttering.cpp
    Decoration.cpp
    EllipseNode.cpp
    FeatureNode.cpp
    LocalGeometryNode.cpp
    HighlightDecoration.cpp
    ImageOverlay.cpp
    ImageOverlayEditor.cpp
    LabelNode.cpp
    LocalizedNode.cpp
	RectangleNode.cpp
	ModelNode.cpp
    OrthoNode.cpp
    PlaceNode.cpp
    TrackNode.cpp
)

if( NOT ${OPENSCENEGRAPH_VERSION} VERSION_LESS "2.9.6" )

    SET(TARGET_H ${TARGET_H}
	    AnnotationEditing
	    FeatureEditing
	    ImageOverlayEditor
    )
    	
    SET(TARGET_SRC ${TARGET_SRC}
	    AnnotationEditing.cpp
	    FeatureEditing.cpp
        ImageOverlayEditor.cpp
    )
        
endif()


#ADD_LIBRARY( ${LIB_NAME} ${OSGEARTH_USER_DEFINED_DYNAMIC_OR_STATIC}
#    ${LIB_PUBLIC_HEADERS}  
#	${LIB_COMMON_FILES}
#)



INCLUDE_DIRECTORIES(${OSG_INCLUDE_DIR} ${OSGEARTH_SOURCE_DIR} ${GDAL_INCLUDE_DIR})

IF (WIN32)
  SET(TARGET_EXTERNAL_LIBRARIES ${TARGET_EXTERNAL_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT} ${MATH_LIBRARY})
ELSE(WIN32)
  SET(TARGET_EXTERNAL_LIBRARIES ${TARGET_EXTERNAL_LIBRARIES} ${CMAKE_THREAD_LIBS_INIT} ${MATH_LIBRARY})
ENDIF(WIN32)

SET(TARGET_LIBRARIES
    osgEarth
    osgEarthFeatures
    osgEarthSymbology
)

SET(TARGET_LIBRARIES_VARS OSG_LIBRARY OSGUTIL_LIBRARY OSGSIM_LIBRARY OSGTERRAIN_LIBRARY OSGDB_LIBRARY OSGFX_LIBRARY OSGMANIPULATOR_LIBRARY OSGVIEWER_LIBRARY OSGTEXT_LIBRARY OSGGA_LIBRARY OPENTHREADS_LIBRARY GDAL_LIBRARY)


SETUP_LIBRARY(${LIB_NAME})


#LINK_CORELIB_DEFAULT(${LIB_NAME} ${CMAKE_THREAD_LIBS_INIT} ${MATH_LIBRARY})

#INCLUDE(ModuleInstall OPTIONAL)

