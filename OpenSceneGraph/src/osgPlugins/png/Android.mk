#ANDROID makefile         osgdb_png

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgPlugins/png

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

LOCAL_MODULE :=           osgdb_png

LOCAL_SRC_FILES :=         ReaderWriterPNG.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/3rdparty/libpng

LOCAL_CFLAGS :=            -DANDROID -DOSG_LIBRARY_STATIC -DOSG_CPP_EXCEPTIONS_AVAILABLE

LOCAL_CPPFLAGS :=          -DANDROID -DOSG_LIBRARY_STATIC -DOSG_CPP_EXCEPTIONS_AVAILABLE

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := 

include $(BUILD_STATIC_LIBRARY)

