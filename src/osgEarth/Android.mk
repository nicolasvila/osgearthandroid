#ANDROID makefile         osgEarth

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/src/osgEarth

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

LOCAL_MODULE :=           osgEarth

LOCAL_SRC_FILES :=         tinystr.cpp tinyxml.cpp tinyxmlerror.cpp tinyxmlparser.cpp AndroidCapabilities.cpp Bounds.cpp Cache.cpp CachePolicy.cpp CacheSeed.cpp Capabilities.cpp ClampableNode.cpp ClampingTechnique.cpp ClampingBinTechnique.cpp ColorFilter.cpp CompositeTileSource.cpp Config.cpp Cube.cpp CullingUtils.cpp DepthOffset.cpp Draggers.cpp DPLineSegmentIntersector.cpp DrapeableNode.cpp DrapingTechnique.cpp DrawInstanced.cpp ECEF.cpp ElevationLayer.cpp ElevationLOD.cpp ElevationQuery.cpp EntityCache.cpp FadeEffect.cpp FileUtils.cpp GeoData.cpp Geoid.cpp GeoMath.cpp HeightFieldUtils.cpp HTTPClient.cpp ImageLayer.cpp ImageMosaic.cpp ImageToHeightFieldConverter.cpp ImageUtils.cpp IOTypes.cpp JsonUtils.cpp Layer.cpp Locators.cpp LocalTangentPlane.cpp Map.cpp MapCallback.cpp MapFrame.cpp MapInfo.cpp MapNode.cpp MapNodeOptions.cpp MapOptions.cpp MaskLayer.cpp MaskNode.cpp MaskSource.cpp MemCache.cpp MimeTypes.cpp ModelLayer.cpp ModelSource.cpp NodeUtils.cpp Notify.cpp OverlayDecorator.cpp OverlayNode.cpp Pickers.cpp Profile.cpp Progress.cpp Random.cpp Registry.cpp Revisioning.cpp ShaderFactory.cpp ShaderGenerator.cpp ShaderUtils.cpp SparseTexture2DArray.cpp SpatialReference.cpp StateSetCache.cpp StringUtils.cpp TaskService.cpp Terrain.cpp TerrainLayer.cpp TerrainOptions.cpp TerrainEngineNode.cpp TextureCompositor.cpp TextureCompositorMulti.cpp TextureCompositorTexArray.cpp TileKey.cpp TileSource.cpp ThreadingUtils.cpp Units.cpp URI.cpp Utils.cpp Version.cpp VerticalDatum.cpp Viewpoint.cpp VirtualProgram.cpp XmlUtils.cpp

LOCAL_C_INCLUDES :=        /stlport /home/paulo/osgEarthAndroid/osgearth/src /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/3rdparty/gdal/include /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/3rdparty/curl/include

LOCAL_CFLAGS :=            -DANDROID -DOSGEARTH_LIBRARY_STATIC -DTIXML_USE_STL

LOCAL_CPPFLAGS :=          -DANDROID -DOSGEARTH_LIBRARY_STATIC -DTIXML_USE_STL

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := 

include $(BUILD_STATIC_LIBRARY)

