#ANDROID makefile         OpenThreads

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/OpenThreads/pthreads

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

LOCAL_MODULE :=           OpenThreads

LOCAL_SRC_FILES :=         PThread.cpp PThreadBarrier.cpp PThreadCondition.cpp PThreadMutex.cpp ../common/Version.cpp ../common/Atomic.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID -DOPENTHREADS_EXPORTS -D_GNU_SOURCE

LOCAL_CPPFLAGS :=          -DANDROID -DOPENTHREADS_EXPORTS -D_GNU_SOURCE

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := 

include $(BUILD_STATIC_LIBRARY)

