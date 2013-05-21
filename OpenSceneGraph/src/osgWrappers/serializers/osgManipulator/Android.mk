#ANDROID makefile         osgdb_serializers_osgmanipulator

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgWrappers/serializers/osgManipulator

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

LOCAL_MODULE :=           osgdb_serializers_osgmanipulator

LOCAL_SRC_FILES :=         TranslateAxisDragger.cpp CompositeDragger.cpp Dragger.cpp TrackballDragger.cpp Scale2DDragger.cpp TabBoxTrackballDragger.cpp RotateCylinderDragger.cpp Translate1DDragger.cpp RotateSphereDragger.cpp Translate2DDragger.cpp TabBoxDragger.cpp TabPlaneDragger.cpp Scale1DDragger.cpp AntiSquish.cpp ScaleAxisDragger.cpp TranslatePlaneDragger.cpp LibraryWrapper.cpp TabPlaneTrackballDragger.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_CPPFLAGS :=          -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := 

include $(BUILD_STATIC_LIBRARY)

