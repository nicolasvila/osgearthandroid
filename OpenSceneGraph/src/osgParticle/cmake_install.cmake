# Install script for directory: /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgParticle

# Set the install prefix
IF(NOT DEFINED CMAKE_INSTALL_PREFIX)
  SET(CMAKE_INSTALL_PREFIX "/usr/local")
ENDIF(NOT DEFINED CMAKE_INSTALL_PREFIX)
STRING(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
IF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  IF(BUILD_TYPE)
    STRING(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  ELSE(BUILD_TYPE)
    SET(CMAKE_INSTALL_CONFIG_NAME "")
  ENDIF(BUILD_TYPE)
  MESSAGE(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
ENDIF(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)

# Set the component getting installed.
IF(NOT CMAKE_INSTALL_COMPONENT)
  IF(COMPONENT)
    MESSAGE(STATUS "Install component: \"${COMPONENT}\"")
    SET(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  ELSE(COMPONENT)
    SET(CMAKE_INSTALL_COMPONENT)
  ENDIF(COMPONENT)
ENDIF(NOT CMAKE_INSTALL_COMPONENT)

# Install shared libraries without execute permission?
IF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  SET(CMAKE_INSTALL_SO_NO_EXE "1")
ENDIF(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)

IF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "libopenscenegraph-dev")
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/osgParticle" TYPE FILE FILES
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/AccelOperator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/AngularAccelOperator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/BoxPlacer"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/CenteredPlacer"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/ConnectedParticleSystem"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/ConstantRateCounter"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/Counter"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/Emitter"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/ExplosionDebrisEffect"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/ExplosionEffect"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/Export"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/FireEffect"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/FluidFrictionOperator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/FluidProgram"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/ForceOperator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/Interpolator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/LinearInterpolator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/ModularEmitter"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/ModularProgram"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/MultiSegmentPlacer"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/Operator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/Particle"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/ParticleEffect"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/ParticleProcessor"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/ParticleSystem"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/ParticleSystemUpdater"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/Placer"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/PointPlacer"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/PrecipitationEffect"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/Program"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/RadialShooter"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/RandomRateCounter"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/range"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/SectorPlacer"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/SegmentPlacer"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/Shooter"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/SmokeEffect"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/SmokeTrailEffect"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/VariableRateCounter"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/Version"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/CompositePlacer"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/AngularDampingOperator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/DampingOperator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/ExplosionOperator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/OrbitOperator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/DomainOperator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/BounceOperator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgParticle/SinkOperator"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "libopenscenegraph-dev")

