#ANDROID makefile         osgdb_serializers_osganimation

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgWrappers/serializers/osgAnimation

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

LOCAL_MODULE :=           osgdb_serializers_osganimation

LOCAL_SRC_FILES :=         UpdateMatrixTransform.cpp TimelineAnimationManager.cpp Timeline.cpp BasicAnimationManager.cpp Animation.cpp Action.cpp StackedQuaternionElement.cpp UpdateMaterial.cpp StackedMatrixElement.cpp ActionAnimation.cpp UpdateSkeleton.cpp RigGeometry.cpp AnimationManagerBase.cpp Bone.cpp UpdateBone.cpp StackedTranslateElement.cpp StackedTransformElement.cpp ActionBlendOut.cpp MorphGeometry.cpp StackedScaleElement.cpp StackedRotateAxisElement.cpp Skeleton.cpp LibraryWrapper.cpp ActionStripAnimation.cpp UpdateMorph.cpp ActionBlendIn.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_CPPFLAGS :=          -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := 

include $(BUILD_STATIC_LIBRARY)

