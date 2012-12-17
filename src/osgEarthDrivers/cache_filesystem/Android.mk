#ANDROID makefile         osgdb_osgearth_cache_filesystem

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/cache_filesystem

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

LOCAL_MODULE :=           osgdb_osgearth_cache_filesystem

LOCAL_SRC_FILES :=         FileSystemCache.cpp

LOCAL_C_INCLUDES :=        /stlport /home/paulo/osgEarthAndroid/osgearth/src /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID -DOSGEARTH_HAVE_ZLIB

LOCAL_CPPFLAGS :=          -DANDROID -DOSGEARTH_HAVE_ZLIB

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := 

include $(BUILD_STATIC_LIBRARY)

