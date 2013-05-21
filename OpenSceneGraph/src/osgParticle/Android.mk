#ANDROID makefile         osgParticle

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgParticle

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

LOCAL_MODULE :=           osgParticle

LOCAL_SRC_FILES :=         ConnectedParticleSystem.cpp Emitter.cpp ExplosionDebrisEffect.cpp ExplosionEffect.cpp FireEffect.cpp FluidFrictionOperator.cpp FluidProgram.cpp ModularEmitter.cpp ModularProgram.cpp MultiSegmentPlacer.cpp Particle.cpp ParticleEffect.cpp ParticleProcessor.cpp ParticleSystem.cpp ParticleSystemUpdater.cpp PrecipitationEffect.cpp Program.cpp SmokeEffect.cpp SmokeTrailEffect.cpp Version.cpp DomainOperator.cpp BounceOperator.cpp SinkOperator.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_CPPFLAGS :=          -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := osgUtil;osgDB;osg;OpenThreads

include $(BUILD_STATIC_LIBRARY)

