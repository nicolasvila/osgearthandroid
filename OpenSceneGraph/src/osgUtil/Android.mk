#ANDROID makefile         osgUtil

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgUtil

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

LOCAL_MODULE :=           osgUtil

LOCAL_SRC_FILES :=         CubeMapGenerator.cpp CullVisitor.cpp DelaunayTriangulator.cpp DisplayRequirementsVisitor.cpp DrawElementTypeSimplifier.cpp EdgeCollector.cpp GLObjectsVisitor.cpp HalfWayMapGenerator.cpp HighlightMapGenerator.cpp IntersectionVisitor.cpp IntersectVisitor.cpp IncrementalCompileOperation.cpp LineSegmentIntersector.cpp MeshOptimizers.cpp Optimizer.cpp PerlinNoise.cpp PlaneIntersector.cpp PolytopeIntersector.cpp PositionalStateContainer.cpp PrintVisitor.cpp RenderBin.cpp RenderLeaf.cpp RenderStage.cpp ReversePrimitiveFunctor.cpp SceneView.cpp ShaderGen.cpp Simplifier.cpp SmoothingVisitor.cpp SceneGraphBuilder.cpp StateGraph.cpp Statistics.cpp TangentSpaceGenerator.cpp Tessellator.cpp TransformAttributeFunctor.cpp TransformCallback.cpp tristripper/src/tri_stripper.cpp tristripper/src/policy.cpp tristripper/src/connectivity_graph.cpp TriStripVisitor.cpp UpdateVisitor.cpp Version.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgUtil/tristripper/include

LOCAL_CFLAGS :=            -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_CPPFLAGS :=          -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := osg;OpenThreads

include $(BUILD_STATIC_LIBRARY)

