#ANDROID makefile         osgdb_serializers_osgshadow

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgWrappers/serializers/osgShadow

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

LOCAL_MODULE :=           osgdb_serializers_osgshadow

LOCAL_SRC_FILES :=         MinimalDrawBoundsShadowMap.cpp ShadowMap.cpp DebugShadowMap.cpp MinimalCullBoundsShadowMap.cpp ShadowedScene.cpp LightSpacePerspectiveShadowMapCB.cpp LightSpacePerspectiveShadowMapVB.cpp ShadowVolume.cpp ViewDependentShadowTechnique.cpp ShadowTexture.cpp ParallelSplitShadowMap.cpp LightSpacePerspectiveShadowMapDB.cpp MinimalShadowMap.cpp ShadowTechnique.cpp StandardShadowMap.cpp LibraryWrapper.cpp SoftShadowMap.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_CPPFLAGS :=          -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := 

include $(BUILD_STATIC_LIBRARY)

