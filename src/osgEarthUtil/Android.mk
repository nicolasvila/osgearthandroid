#ANDROID makefile         osgEarthUtil

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/src/osgEarthUtil

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

LOCAL_MODULE :=           osgEarthUtil

LOCAL_SRC_FILES :=         AnnotationEvents.cpp AutoClipPlaneHandler.cpp ClampCallback.cpp Controls.cpp EarthManipulator.cpp ElevationManager.cpp ExampleResources.cpp FeatureManipTool.cpp FeatureQueryTool.cpp GeodeticGraticule.cpp LatLongFormatter.cpp LinearLineOfSight.cpp MeasureTool.cpp MGRSFormatter.cpp MGRSGraticule.cpp MouseCoordsTool.cpp ObjectPlacer.cpp ObjectLocator.cpp PolyhedralLineOfSight.cpp RadialLineOfSight.cpp SpatialData.cpp SkyNode.cpp TerrainProfile.cpp TFS.cpp TFSPackager.cpp TMS.cpp TMSBackFiller.cpp TMSPackager.cpp UTMGraticule.cpp WFS.cpp WMS.cpp BrightnessContrastColorFilter.cpp CMYKColorFilter.cpp GammaColorFilter.cpp HSLColorFilter.cpp RGBColorFilter.cpp ChromaKeyColorFilter.cpp

LOCAL_C_INCLUDES :=        /stlport /home/paulo/osgEarthAndroid/osgearth/src /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include /home/paulo/osgEarthAndroid/osgearth

LOCAL_CFLAGS :=            -DANDROID -DOSGEARTHUTIL_LIBRARY_STATIC

LOCAL_CPPFLAGS :=          -DANDROID -DOSGEARTHUTIL_LIBRARY_STATIC

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := osgEarth;osgEarthFeatures;osgEarthSymbology;osgEarthAnnotation

include $(BUILD_STATIC_LIBRARY)

