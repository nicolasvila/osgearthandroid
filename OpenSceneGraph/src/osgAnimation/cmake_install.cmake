# Install script for directory: /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgAnimation

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
  FILE(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/osgAnimation" TYPE FILE FILES
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/Action"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/ActionAnimation"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/ActionBlendIn"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/ActionBlendOut"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/ActionCallback"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/ActionStripAnimation"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/ActionVisitor"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/Animation"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/AnimationManagerBase"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/AnimationUpdateCallback"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/BasicAnimationManager"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/Bone"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/BoneMapVisitor"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/Channel"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/CubicBezier"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/EaseMotion"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/Export"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/FrameAction"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/Interpolator"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/Keyframe"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/LinkVisitor"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/MorphGeometry"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/RigGeometry"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/RigTransform"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/RigTransformHardware"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/RigTransformSoftware"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/Sampler"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/Skeleton"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/StackedMatrixElement"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/StackedQuaternionElement"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/StackedRotateAxisElement"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/StackedScaleElement"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/StackedTransformElement"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/StackedTranslateElement"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/StackedTransform"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/StatsVisitor"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/StatsHandler"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/Target"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/Timeline"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/TimelineAnimationManager"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/UpdateBone"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/UpdateMaterial"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/UpdateMatrixTransform"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/Vec3Packed"
    "/home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include/osgAnimation/VertexInfluence"
    )
ENDIF(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "libopenscenegraph-dev")

