#ANDROID makefile         osgdb_serializers_osgparticle

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgWrappers/serializers/osgParticle

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

LOCAL_MODULE :=           osgdb_serializers_osgparticle

LOCAL_SRC_FILES :=         SegmentPlacer.cpp SmokeTrailEffect.cpp Shooter.cpp ModularEmitter.cpp SinkOperator.cpp RandomRateCounter.cpp Emitter.cpp Program.cpp ParticleProcessor.cpp FluidProgram.cpp ConnectedParticleSystem.cpp Interpolator.cpp DomainOperator.cpp LinearInterpolator.cpp ExplosionOperator.cpp CompositePlacer.cpp SmokeEffect.cpp AccelOperator.cpp CenteredPlacer.cpp AngularAccelOperator.cpp AngularDampingOperator.cpp ParticleSystem.cpp DampingOperator.cpp RadialShooter.cpp MultiSegmentPlacer.cpp BoxPlacer.cpp SectorPlacer.cpp Particle.cpp PrecipitationEffect.cpp ExplosionEffect.cpp ParticleEffect.cpp OrbitOperator.cpp PointPlacer.cpp ForceOperator.cpp ModularProgram.cpp Operator.cpp LibraryWrapper.cpp Counter.cpp ParticleSystemUpdater.cpp FireEffect.cpp ConstantRateCounter.cpp FluidFrictionOperator.cpp VariableRateCounter.cpp Placer.cpp BounceOperator.cpp ExplosionDebrisEffect.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_CPPFLAGS :=          -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := 

include $(BUILD_STATIC_LIBRARY)

