#ANDROID makefile         osgEarthSymbology

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/src/osgEarthSymbology

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

LOCAL_MODULE :=           osgEarthSymbology

LOCAL_SRC_FILES :=         AltitudeSymbol.cpp Color.cpp CssUtils.cpp Expression.cpp ExtrusionSymbol.cpp Geometry.cpp GeometryFactory.cpp GEOS.cpp GeometryRasterizer.cpp IconResource.cpp IconSymbol.cpp InstanceResource.cpp InstanceSymbol.cpp LineSymbol.cpp MarkerResource.cpp MarkerSymbol.cpp MeshConsolidator.cpp MeshSubdivider.cpp ModelResource.cpp ModelSymbol.cpp PointSymbol.cpp PolygonSymbol.cpp Query.cpp RenderSymbol.cpp Resource.cpp ResourceCache.cpp ResourceLibrary.cpp Skins.cpp StencilVolumeNode.cpp Style.cpp StyleSelector.cpp StyleSheet.cpp Symbol.cpp TextSymbol.cpp

LOCAL_C_INCLUDES :=        /stlport /home/paulo/osgEarthAndroid/osgearth/src /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include /home/paulo/osgEarthAndroid/osgearth /home/paulo/osgEarthAndroid/osgearth/3rdparty/jni/geos-3.3.4/include

LOCAL_CFLAGS :=            -DANDROID -DOSGEARTHSYMBOLOGY_LIBRARY_STATIC -DOSGEARTH_HAVE_GEOS

LOCAL_CPPFLAGS :=          -DANDROID -DOSGEARTHSYMBOLOGY_LIBRARY_STATIC -DOSGEARTH_HAVE_GEOS

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := osgEarth

include $(BUILD_STATIC_LIBRARY)

