#ANDROID makefile         osgdb_earth

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/earth

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

LOCAL_MODULE :=           osgdb_earth

LOCAL_SRC_FILES :=         ReaderWriterOsgEarth.cpp EarthFileSerializer1.cpp EarthFileSerializer2.cpp

LOCAL_C_INCLUDES :=        /stlport /home/paulo/osgEarthAndroid/osgearth/src /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID -DOSGEARTH_DEBUG_POSTFIX=d

LOCAL_CPPFLAGS :=          -DANDROID -DOSGEARTH_DEBUG_POSTFIX=d

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := 

include $(BUILD_STATIC_LIBRARY)

