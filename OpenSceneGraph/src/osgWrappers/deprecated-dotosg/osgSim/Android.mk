#ANDROID makefile         osgdb_deprecated_osgsim

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgWrappers/deprecated-dotosg/osgSim

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

LOCAL_MODULE :=           osgdb_deprecated_osgsim

LOCAL_SRC_FILES :=         IO_LightPointNode.cpp IO_BlinkSequence.cpp IO_ObjectRecordData.cpp IO_MultiSwitch.cpp IO_Impostor.cpp IO_VisibilityGroup.cpp IO_OverlayNode.cpp IO_LightPoint.cpp IO_DOFTransform.cpp IO_Sector.cpp LibraryWrapper.cpp IO_ShapeAttribute.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_CPPFLAGS :=          -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := 

include $(BUILD_STATIC_LIBRARY)

