#ANDROID makefile         osgdb_ive

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgPlugins/ive

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

LOCAL_MODULE :=           osgdb_ive

LOCAL_SRC_FILES :=         AlphaFunc.cpp AnimationPathCallback.cpp AnimationPath.cpp AnisotropicLighting.cpp AutoTransform.cpp AzimElevationSector.cpp AzimSector.cpp Billboard.cpp BlendColor.cpp BlendEquation.cpp BlendFunc.cpp BlinkSequence.cpp BumpMapping.cpp Camera.cpp CameraView.cpp Cartoon.cpp ClipNode.cpp ClipPlane.cpp ClusterCullingCallback.cpp ColorMask.cpp CompositeLayer.cpp ConeSector.cpp ConvexPlanarOccluder.cpp ConvexPlanarPolygon.cpp CoordinateSystemNode.cpp CullFace.cpp DataInputStream.cpp DataOutputStream.cpp Depth.cpp DirectionalSector.cpp DOFTransform.cpp Drawable.cpp DrawArrayLengths.cpp DrawArrays.cpp DrawElementsUByte.cpp DrawElementsUInt.cpp DrawElementsUShort.cpp Effect.cpp ElevationSector.cpp EllipsoidModel.cpp Exception.cpp FadeText.cpp Fog.cpp FragmentProgram.cpp FrontFace.cpp Geode.cpp Geometry.cpp Group.cpp HeightFieldLayer.cpp Image.cpp ImageLayer.cpp ImageSequence.cpp Impostor.cpp Layer.cpp Light.cpp LightModel.cpp LightPoint.cpp LightPointNode.cpp LightSource.cpp LineStipple.cpp LineWidth.cpp Locator.cpp LOD.cpp Material.cpp MatrixTransform.cpp Multisample.cpp MultiSwitch.cpp MultiTextureControl.cpp Node.cpp Object.cpp OccluderNode.cpp OcclusionQueryNode.cpp PagedLOD.cpp Point.cpp PointSprite.cpp PolygonMode.cpp PolygonOffset.cpp PolygonStipple.cpp PositionAttitudeTransform.cpp PrimitiveSet.cpp Program.cpp ProxyNode.cpp ReaderWriterIVE.cpp Scissor.cpp Scribe.cpp Sequence.cpp ShadeModel.cpp Shader.cpp ShapeAttributeList.cpp Shape.cpp ShapeDrawable.cpp SpecularHighlights.cpp StateSet.cpp Stencil.cpp StencilTwoSided.cpp Switch.cpp SwitchLayer.cpp Terrain.cpp TerrainTile.cpp TexEnvCombine.cpp TexEnv.cpp TexGen.cpp TexGenNode.cpp TexMat.cpp Text3D.cpp Text.cpp Texture1D.cpp Texture2D.cpp Texture2DArray.cpp Texture3D.cpp Texture.cpp TextureCubeMap.cpp TextureRectangle.cpp Transform.cpp Uniform.cpp VertexProgram.cpp Viewport.cpp VisibilityGroup.cpp VolumeCompositeLayer.cpp VolumeCompositeProperty.cpp VolumeSwitchProperty.cpp VolumeScalarProperty.cpp VolumeTransferFunctionProperty.cpp VolumePropertyAdjustmentCallback.cpp Volume.cpp VolumeImageLayer.cpp VolumeLayer.cpp VolumeLocator.cpp VolumeTile.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_CPPFLAGS :=          -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := 

include $(BUILD_STATIC_LIBRARY)

