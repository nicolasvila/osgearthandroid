#ANDROID makefile         osgVolume

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgVolume

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

LOCAL_MODULE :=           osgVolume

LOCAL_SRC_FILES :=         FixedFunctionTechnique.cpp Layer.cpp Locator.cpp Property.cpp RayTracedTechnique.cpp Version.cpp Volume.cpp VolumeTechnique.cpp VolumeTile.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_CPPFLAGS :=          -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := osgUtil;osgDB;osgGA;osg;OpenThreads

include $(BUILD_STATIC_LIBRARY)

