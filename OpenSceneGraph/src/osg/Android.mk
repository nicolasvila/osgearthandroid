#ANDROID makefile         osg

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osg

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

LOCAL_MODULE :=           osg

LOCAL_SRC_FILES :=         AlphaFunc.cpp AnimationPath.cpp ApplicationUsage.cpp ArgumentParser.cpp Array.cpp ArrayDispatchers.cpp AudioStream.cpp AutoTransform.cpp Billboard.cpp BlendColor.cpp BlendEquation.cpp BlendFunc.cpp BufferIndexBinding.cpp BufferObject.cpp Camera.cpp CameraView.cpp ClampColor.cpp ClearNode.cpp ClipNode.cpp ClipPlane.cpp ClusterCullingCallback.cpp CollectOccludersVisitor.cpp ColorMask.cpp ColorMatrix.cpp ComputeBoundsVisitor.cpp ConvexPlanarOccluder.cpp ConvexPlanarPolygon.cpp CoordinateSystemNode.cpp CopyOp.cpp CullFace.cpp CullingSet.cpp CullSettings.cpp CullStack.cpp DeleteHandler.cpp Depth.cpp DisplaySettings.cpp Drawable.cpp DrawPixels.cpp dxtctool.cpp Fog.cpp FragmentProgram.cpp FrameBufferObject.cpp FrameStamp.cpp FrontFace.cpp Geode.cpp Geometry.cpp GL2Extensions.cpp GLExtensions.cpp GLBeginEndAdapter.cpp GLObjects.cpp GLStaticLibrary.cpp GraphicsCostEstimator.cpp GraphicsContext.cpp GraphicsThread.cpp Group.cpp Hint.cpp Image.cpp ImageSequence.cpp ImageStream.cpp ImageUtils.cpp KdTree.cpp Light.cpp LightModel.cpp LightSource.cpp LineSegment.cpp LineStipple.cpp LineWidth.cpp LOD.cpp LogicOp.cpp Material.cpp Math.cpp Matrixd.cpp MatrixDecomposition.cpp Matrixf.cpp MatrixTransform.cpp Multisample.cpp NodeCallback.cpp Node.cpp NodeTrackerCallback.cpp NodeVisitor.cpp Notify.cpp Object.cpp Observer.cpp ObserverNodePath.cpp OccluderNode.cpp OcclusionQueryNode.cpp OperationThread.cpp PagedLOD.cpp Point.cpp PointSprite.cpp PolygonMode.cpp PolygonOffset.cpp PolygonStipple.cpp PositionAttitudeTransform.cpp PrimitiveSet.cpp Program.cpp Projection.cpp ProxyNode.cpp Quat.cpp Referenced.cpp Scissor.cpp Sequence.cpp ShadeModel.cpp Shader.cpp ShaderAttribute.cpp ShaderComposer.cpp ShadowVolumeOccluder.cpp Shape.cpp ShapeDrawable.cpp StateAttribute.cpp State.cpp StateSet.cpp Stats.cpp Stencil.cpp StencilTwoSided.cpp Switch.cpp TexEnvCombine.cpp TexEnv.cpp TexEnvFilter.cpp TexGen.cpp TexGenNode.cpp TexMat.cpp Texture1D.cpp Texture2DArray.cpp Texture2D.cpp Texture2DMultisample.cpp Texture3D.cpp Texture.cpp TextureCubeMap.cpp TextureRectangle.cpp Timer.cpp TransferFunction.cpp Transform.cpp Uniform.cpp UserDataContainer.cpp Version.cpp VertexProgram.cpp View.cpp Viewport.cpp glu/libutil/error.cpp glu/libutil/mipmap.cpp glu/libtess/normal.cpp glu/libtess/memalloc.cpp glu/libtess/priorityq.cpp glu/libtess/render.cpp glu/libtess/mesh.cpp glu/libtess/tessmono.cpp glu/libtess/sweep.cpp glu/libtess/dict.cpp glu/libtess/geom.cpp glu/libtess/tess.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_CPPFLAGS :=          -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := OpenThreads

include $(BUILD_STATIC_LIBRARY)

