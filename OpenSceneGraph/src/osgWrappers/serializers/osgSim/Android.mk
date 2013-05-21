#ANDROID makefile         osgdb_serializers_osgsim

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgWrappers/serializers/osgSim

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

LOCAL_MODULE :=           osgdb_serializers_osgsim

LOCAL_SRC_FILES :=         ObjectRecordData.cpp DOFTransform.cpp DirectionalSector.cpp AzimElevationSector.cpp ElevationSector.cpp Impostor.cpp BlinkSequence.cpp SphereSegment.cpp Sector.cpp VisibilityGroup.cpp MultiSwitch.cpp LightPointNode.cpp ScalarBar.cpp SequenceGroup.cpp OverlayNode.cpp ShapeAttributeList.cpp ConeSector.cpp AzimSector.cpp LibraryWrapper.cpp LightPointSystem.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_CPPFLAGS :=          -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := 

include $(BUILD_STATIC_LIBRARY)

