#ANDROID makefile         osgViewer

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgViewer

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

LOCAL_MODULE :=           osgViewer

LOCAL_SRC_FILES :=         CompositeViewer.cpp GraphicsWindow.cpp HelpHandler.cpp Renderer.cpp Scene.cpp ScreenCaptureHandler.cpp StatsHandler.cpp Version.cpp View.cpp Viewer.cpp ViewerBase.cpp ViewerEventHandlers.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_CPPFLAGS :=          -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := osgGA;osgText;osgDB;osgUtil;osg;OpenThreads

include $(BUILD_STATIC_LIBRARY)

