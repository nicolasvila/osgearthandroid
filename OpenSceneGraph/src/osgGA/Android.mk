#ANDROID makefile         osgGA

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgGA

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

LOCAL_MODULE :=           osgGA

LOCAL_SRC_FILES :=         AnimationPathManipulator.cpp DriveManipulator.cpp EventQueue.cpp EventVisitor.cpp FirstPersonManipulator.cpp FlightManipulator.cpp GUIEventAdapter.cpp GUIEventHandler.cpp KeySwitchMatrixManipulator.cpp CameraManipulator.cpp MultiTouchTrackballManipulator.cpp NodeTrackerManipulator.cpp OrbitManipulator.cpp StandardManipulator.cpp SphericalManipulator.cpp StateSetManipulator.cpp TerrainManipulator.cpp TrackballManipulator.cpp UFOManipulator.cpp Version.cpp CameraViewSwitchManipulator.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_CPPFLAGS :=          -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := osgDB;osgUtil;osg;OpenThreads

include $(BUILD_STATIC_LIBRARY)

