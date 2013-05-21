#ANDROID makefile         osgWidget

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgWidget

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

LOCAL_MODULE :=           osgWidget

LOCAL_SRC_FILES :=         Box.cpp Browser.cpp PdfReader.cpp VncClient.cpp Canvas.cpp Frame.cpp Input.cpp Label.cpp Lua.cpp Python.cpp StyleManager.cpp Table.cpp Util.cpp Version.cpp ViewerEventHandlers.cpp Widget.cpp Window.cpp WindowManager.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_CPPFLAGS :=          -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := osgText;osgViewer;osgDB;osg;OpenThreads;osgGA

include $(BUILD_STATIC_LIBRARY)

