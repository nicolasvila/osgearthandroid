#ANDROID makefile         osgdb_deprecated_osgfx

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgWrappers/deprecated-dotosg/osgFX

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

LOCAL_MODULE :=           osgdb_deprecated_osgfx

LOCAL_SRC_FILES :=         IO_MultiTextureControl.cpp IO_Effect.cpp IO_SpecularHighlights.cpp IO_Cartoon.cpp IO_AnisotropicLighting.cpp IO_Outline.cpp LibraryWrapper.cpp IO_Scribe.cpp IO_BumpMapping.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_CPPFLAGS :=          -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := 

include $(BUILD_STATIC_LIBRARY)

