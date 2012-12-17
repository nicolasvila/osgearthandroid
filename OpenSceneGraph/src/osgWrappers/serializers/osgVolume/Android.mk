#ANDROID makefile         osgdb_serializers_osgvolume

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgWrappers/serializers/osgVolume

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

LOCAL_LDLIBS :=           -lGLESv2 -ldl

LOCAL_MODULE :=           osgdb_serializers_osgvolume

LOCAL_SRC_FILES :=         MaximumIntensityProjectionProperty.cpp VolumeTile.cpp IsoSurfaceProperty.cpp ImageDetails.cpp PropertyAdjustmentCallback.cpp TransparencyProperty.cpp Property.cpp LightingProperty.cpp AlphaFuncProperty.cpp SampleDensityProperty.cpp Locator.cpp RayTracedTechnique.cpp VolumeTechnique.cpp CompositeProperty.cpp ScalarProperty.cpp TransferFunctionProperty.cpp Layer.cpp ImageLayer.cpp CompositeLayer.cpp LibraryWrapper.cpp Volume.cpp FixedFunctionTechnique.cpp SwitchProperty.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_CPPFLAGS :=          -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := 

include $(BUILD_STATIC_LIBRARY)

