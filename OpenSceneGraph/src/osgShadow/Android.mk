#ANDROID makefile         osgShadow

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgShadow

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

LOCAL_MODULE :=           osgShadow

LOCAL_SRC_FILES :=         OccluderGeometry.cpp ShadowMap.cpp ShadowTechnique.cpp ShadowTexture.cpp ShadowVolume.cpp ShadowedScene.cpp ShadowSettings.cpp SoftShadowMap.cpp ParallelSplitShadowMap.cpp Version.cpp ConvexPolyhedron.cpp DebugShadowMap.cpp LightSpacePerspectiveShadowMap.cpp MinimalCullBoundsShadowMap.cpp MinimalDrawBoundsShadowMap.cpp MinimalShadowMap.cpp StandardShadowMap.cpp ViewDependentShadowTechnique.cpp ViewDependentShadowMap.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_CPPFLAGS :=          -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := osgUtil;osgDB;osg;OpenThreads

include $(BUILD_STATIC_LIBRARY)

