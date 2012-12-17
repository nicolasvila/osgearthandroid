#ANDROID makefile         osgdb_deprecated_osgvolume

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgWrappers/deprecated-dotosg/osgVolume

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

LOCAL_MODULE :=           osgdb_deprecated_osgvolume

LOCAL_SRC_FILES :=         VolumeTile.cpp PropertyAdjustmentCallback.cpp Property.cpp Locator.cpp RayTracedTechnique.cpp CompositeProperty.cpp ScalarProperty.cpp TransferFunctionProperty.cpp Layer.cpp ImageLayer.cpp LibraryWrapper.cpp Volume.cpp FixedFunctionTechnique.cpp SwitchProperty.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_CPPFLAGS :=          -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := 

include $(BUILD_STATIC_LIBRARY)

