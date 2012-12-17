#ANDROID makefile         osgEarthAnnotation

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/src/osgEarthAnnotation

include $(CLEAR_VARS)

ifeq (false,true)
    ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
        LOCAL_ARM_NEON := true
    endif
endif

ifeq (false,true)
    LOCAL_ARM_MODE := arm
endif


LOCAL_CPP_EXTENSION :=    cpp

LOCAL_LDLIBS :=            -ldl

LOCAL_MODULE :=           osgEarthAnnotation

LOCAL_SRC_FILES :=         AnnotationEditing.cpp AnnotationSettings.cpp AnnotationData.cpp AnnotationNode.cpp AnnotationRegistry.cpp AnnotationUtils.cpp CircleNode.cpp Decluttering.cpp Decoration.cpp EllipseNode.cpp FeatureNode.cpp LocalGeometryNode.cpp HighlightDecoration.cpp ImageOverlay.cpp ImageOverlayEditor.cpp LabelNode.cpp LocalizedNode.cpp RectangleNode.cpp ModelNode.cpp OrthoNode.cpp PlaceNode.cpp TrackNode.cpp

LOCAL_C_INCLUDES :=        /stlport /home/paulo/osgEarthAndroid/osgearth/src /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include /home/paulo/osgEarthAndroid/osgearth /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/3rdparty/gdal/include

LOCAL_CFLAGS :=            -DANDROID -DOSGEARTHANNO_LIBRARY_STATIC

LOCAL_CPPFLAGS :=          -DANDROID -DOSGEARTHANNO_LIBRARY_STATIC

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := osgEarth;osgEarthFeatures;osgEarthSymbology

include $(BUILD_STATIC_LIBRARY)

