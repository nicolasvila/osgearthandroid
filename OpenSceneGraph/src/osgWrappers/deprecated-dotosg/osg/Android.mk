#ANDROID makefile         osgdb_deprecated_osg

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgWrappers/deprecated-dotosg/osg

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

LOCAL_MODULE :=           osgdb_deprecated_osg

LOCAL_SRC_FILES :=         Group.cpp ClipNode.cpp TexMat.cpp Light.cpp TexEnvCombine.cpp Texture2D.cpp PointSprite.cpp Cone.cpp ConvexPlanarOccluder.cpp Cylinder.cpp Program.cpp Fog.cpp LineWidth.cpp FrontFace.cpp LightModel.cpp Material.cpp VertexProgram.cpp Scissor.cpp Depth.cpp ClipPlane.cpp TexEnv.cpp ProxyNode.cpp ShapeDrawable.cpp Camera.cpp Texture1D.cpp BlendColor.cpp Transform.cpp CoordinateSystemNode.cpp CompositeShape.cpp MatrixTransform.cpp TexGenNode.cpp ImageSequence.cpp Geode.cpp Texture3D.cpp Uniform.cpp StateSet.cpp TexEnvFilter.cpp AnimationPath.cpp Switch.cpp Viewport.cpp PolygonOffset.cpp ColorMatrix.cpp Shader.cpp Billboard.cpp TransferFunction.cpp ShadeModel.cpp Object.cpp ColorMask.cpp Sequence.cpp ClearNode.cpp HeightField.cpp PositionAttitudeTransform.cpp Drawable.cpp Box.cpp BlendFunc.cpp TexGen.cpp LightSource.cpp Texture.cpp LOD.cpp Projection.cpp LineStipple.cpp NodeCallback.cpp CullFace.cpp Point.cpp Image.cpp Capsule.cpp TessellationHints.cpp PolygonMode.cpp Node.cpp AlphaFunc.cpp OcclusionQueryNode.cpp StateAttribute.cpp EllipsoidModel.cpp LibraryWrapper.cpp CameraView.cpp ClusterCullingCallback.cpp Stencil.cpp TextureCubeMap.cpp BlendEquation.cpp PagedLOD.cpp Geometry.cpp AutoTransform.cpp Matrix.cpp TextureRectangle.cpp OccluderNode.cpp FragmentProgram.cpp Sphere.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_CPPFLAGS :=          -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := 

include $(BUILD_STATIC_LIBRARY)

