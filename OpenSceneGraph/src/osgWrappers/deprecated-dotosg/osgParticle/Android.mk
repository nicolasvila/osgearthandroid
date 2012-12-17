#ANDROID makefile         osgdb_deprecated_osgparticle

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgWrappers/deprecated-dotosg/osgParticle

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

LOCAL_MODULE :=           osgdb_deprecated_osgparticle

LOCAL_SRC_FILES :=         IO_ConstantRateCounter.cpp IO_SegmentPlacer.cpp IO_MultiSegmentPlacer.cpp IO_ModularProgram.cpp IO_FluidFrictionOperator.cpp IO_Particle.cpp IO_OrbitOperator.cpp IO_RandomRateCounter.cpp IO_ExplosionDebrisEffect.cpp IO_ExplosionOperator.cpp IO_DampingOperator.cpp IO_AccelOperator.cpp IO_SinkOperator.cpp IO_ModularEmitter.cpp IO_Program.cpp IO_SmokeTrailEffect.cpp IO_AngularDampingOperator.cpp IO_VariableRateCounter.cpp IO_CenteredPlacer.cpp IO_BounceOperator.cpp IO_RadialShooter.cpp IO_ParticleSystem.cpp IO_ParticleEffect.cpp IO_Emitter.cpp IO_FireEffect.cpp IO_DomainOperator.cpp IO_ForceOperator.cpp IO_PointPlacer.cpp IO_ConnectedParticleSystem.cpp IO_SectorPlacer.cpp IO_ParticleProcessor.cpp IO_ExplosionEffect.cpp IO_ParticleSystemUpdater.cpp LibraryWrapper.cpp IO_LinearInterpolator.cpp IO_FluidProgram.cpp IO_BoxPlacer.cpp IO_AngularAccelOperator.cpp IO_SmokeEffect.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_CPPFLAGS :=          -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := 

include $(BUILD_STATIC_LIBRARY)

