#ANDROID makefile         osgManipulator

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgManipulator

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

LOCAL_MODULE :=           osgManipulator

LOCAL_SRC_FILES :=         AntiSquish.cpp Command.cpp Constraint.cpp Dragger.cpp Projector.cpp RotateCylinderDragger.cpp RotateSphereDragger.cpp Scale1DDragger.cpp Scale2DDragger.cpp ScaleAxisDragger.cpp TabBoxDragger.cpp TabBoxTrackballDragger.cpp TabPlaneDragger.cpp TabPlaneTrackballDragger.cpp TrackballDragger.cpp Translate1DDragger.cpp Translate2DDragger.cpp TranslateAxisDragger.cpp TranslatePlaneDragger.cpp Version.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_CPPFLAGS :=          -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := osgViewer;osgGA;osgUtil;osg;OpenThreads

include $(BUILD_STATIC_LIBRARY)

