#ANDROID makefile         osgSim

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgSim

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

LOCAL_MODULE :=           osgSim

LOCAL_SRC_FILES :=         BlinkSequence.cpp ColorRange.cpp DOFTransform.cpp ElevationSlice.cpp HeightAboveTerrain.cpp Impostor.cpp ImpostorSprite.cpp InsertImpostorsVisitor.cpp LightPoint.cpp LightPointDrawable.cpp LightPointNode.cpp LightPointSpriteDrawable.cpp LineOfSight.cpp MultiSwitch.cpp OverlayNode.cpp ScalarBar.cpp ScalarsToColors.cpp Sector.cpp ShapeAttribute.cpp SphereSegment.cpp Version.cpp VisibilityGroup.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_CPPFLAGS :=          -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := osgText;osgUtil;osgDB;osg;OpenThreads

include $(BUILD_STATIC_LIBRARY)

