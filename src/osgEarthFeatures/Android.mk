#ANDROID makefile         osgEarthFeatures

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/src/osgEarthFeatures

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

LOCAL_LDLIBS :=            -ldl

LOCAL_MODULE :=           osgEarthFeatures

LOCAL_SRC_FILES :=         AltitudeFilter.cpp BufferFilter.cpp BuildGeometryFilter.cpp BuildTextFilter.cpp BuildTextOperator.cpp CentroidFilter.cpp ConvertTypeFilter.cpp CropFilter.cpp ExtrudeGeometryFilter.cpp Feature.cpp FeatureCursor.cpp FeatureDisplayLayout.cpp FeatureDrawSet.cpp FeatureListSource.cpp FeatureModelGraph.cpp FeatureModelSource.cpp FeatureSource.cpp FeatureSourceIndexNode.cpp FeatureTileSource.cpp Filter.cpp FilterContext.cpp GeometryCompiler.cpp GeometryUtils.cpp LabelSource.cpp MeshClamper.cpp OptimizerHints.cpp ResampleFilter.cpp ScaleFilter.cpp Session.cpp ScatterFilter.cpp ScriptEngine.cpp SubstituteModelFilter.cpp TessellateOperator.cpp TextSymbolizer.cpp TransformFilter.cpp VirtualFeatureSource.cpp

LOCAL_C_INCLUDES :=        /stlport /home/paulo/osgEarthAndroid/osgearth/src /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/3rdparty/gdal/include

LOCAL_CFLAGS :=            -DANDROID -DOSGEARTHFEATURES_LIBRARY_STATIC -DOSGEARTH_HAVE_GEOS

LOCAL_CPPFLAGS :=          -DANDROID -DOSGEARTHFEATURES_LIBRARY_STATIC -DOSGEARTH_HAVE_GEOS

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := osgEarth;osgEarthSymbology

include $(BUILD_STATIC_LIBRARY)

