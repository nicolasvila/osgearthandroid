#ANDROID makefile         osgdb_serializers_osg

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgWrappers/serializers/osg

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

LOCAL_MODULE :=           osgdb_serializers_osg

LOCAL_SRC_FILES :=         Group.cpp ClipNode.cpp TexMat.cpp TransferFunction1D.cpp Light.cpp TexEnvCombine.cpp Texture2D.cpp PointSprite.cpp Cone.cpp ConvexPlanarOccluder.cpp Cylinder.cpp Program.cpp Fog.cpp LineWidth.cpp FrontFace.cpp LightModel.cpp Material.cpp VertexProgram.cpp Scissor.cpp Depth.cpp NodeTrackerCallback.cpp ClipPlane.cpp DrawPixels.cpp TexEnv.cpp ValueObject.cpp ProxyNode.cpp ShapeDrawable.cpp Camera.cpp Texture1D.cpp BlendColor.cpp Transform.cpp ClampColor.cpp CoordinateSystemNode.cpp CompositeShape.cpp AudioStream.cpp MatrixTransform.cpp PolygonStipple.cpp TexGenNode.cpp ImageSequence.cpp Geode.cpp Texture3D.cpp Uniform.cpp StateSet.cpp TexEnvFilter.cpp AnimationPath.cpp Switch.cpp Viewport.cpp PolygonOffset.cpp ColorMatrix.cpp AnimationPathCallback.cpp LogicOp.cpp Shader.cpp Billboard.cpp TransferFunction.cpp ShadeModel.cpp Object.cpp ColorMask.cpp Sequence.cpp Shape.cpp ClearNode.cpp HeightField.cpp PositionAttitudeTransform.cpp ConvexHull.cpp Drawable.cpp TriangleMesh.cpp Box.cpp BlendFunc.cpp TexGen.cpp LightSource.cpp Texture.cpp LOD.cpp Projection.cpp ShaderBinary.cpp LineStipple.cpp NodeCallback.cpp UserDataContainer.cpp CullFace.cpp Point.cpp Image.cpp Capsule.cpp Hint.cpp TessellationHints.cpp PolygonMode.cpp AudioSink.cpp Texture2DArray.cpp StencilTwoSided.cpp Node.cpp AlphaFunc.cpp OcclusionQueryNode.cpp StateAttribute.cpp EllipsoidModel.cpp LibraryWrapper.cpp CameraView.cpp ClusterCullingCallback.cpp Stencil.cpp TextureCubeMap.cpp Multisample.cpp BlendEquation.cpp PagedLOD.cpp Geometry.cpp AutoTransform.cpp TextureRectangle.cpp OccluderNode.cpp FragmentProgram.cpp Sphere.cpp ImageStream.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_CPPFLAGS :=          -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := 

include $(BUILD_STATIC_LIBRARY)

