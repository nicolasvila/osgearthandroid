#ANDROID makefile         osgAnimation

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgAnimation

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

LOCAL_MODULE :=           osgAnimation

LOCAL_SRC_FILES :=         Action.cpp ActionAnimation.cpp ActionBlendIn.cpp ActionBlendOut.cpp ActionCallback.cpp ActionStripAnimation.cpp ActionVisitor.cpp Animation.cpp AnimationManagerBase.cpp BasicAnimationManager.cpp Bone.cpp BoneMapVisitor.cpp Channel.cpp LinkVisitor.cpp MorphGeometry.cpp RigGeometry.cpp RigTransformHardware.cpp RigTransformSoftware.cpp Skeleton.cpp StackedMatrixElement.cpp StackedQuaternionElement.cpp StackedRotateAxisElement.cpp StackedScaleElement.cpp StackedTransform.cpp StackedTranslateElement.cpp StatsVisitor.cpp StatsHandler.cpp Target.cpp TimelineAnimationManager.cpp Timeline.cpp UpdateBone.cpp UpdateMaterial.cpp UpdateMatrixTransform.cpp VertexInfluence.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_CPPFLAGS :=          -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := osg;osgText;osgGA;osgViewer;OpenThreads

include $(BUILD_STATIC_LIBRARY)

