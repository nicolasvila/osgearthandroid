LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := osgNativeLib
### Main Install dir
OSG_ANDROID_DIR		:= /Users/hogbox/Documents/AlphaPixel/androidPort/osg-gles2-android
OSGEARTH_ANDROID_DIR	:= /Users/hogbox/Documents/AlphaPixel/androidPort/osgearth-android
THIRDPARTY_ANDROID_DIR	:= /Users/hogbox/Documents/AlphaPixel/androidPort/builds/3rdparty

OSG_LIBDIR 			:= $(OSG_ANDROID_DIR)/obj/local/armeabi
OSGEARTH_LIBDIR 		:= $(OSGEARTH_ANDROID_DIR)/obj/local/armeabi
PNG_LIBDIR 			:= $(THIRDPARTY_ANDROID_DIR)/obj/local/armeabi
TIFF_LIBDIR 			:= $(THIRDPARTY_ANDROID_DIR)/obj/local/armeabi
GDAL_LIBDIR 			:= $(THIRDPARTY_ANDROID_DIR)/obj/local/armeabi
GEOS_LIBDIR 			:= $(THIRDPARTY_ANDROID_DIR)/obj/local/armeabi
PROJ_LIBDIR 			:= $(THIRDPARTY_ANDROID_DIR)/obj/local/armeabi
CURL_LIBDIR 			:= $(THIRDPARTY_ANDROID_DIR)/obj/local/armeabi
FREETYPE_LIBDIR 		:= $(THIRDPARTY_ANDROID_DIR)/obj/local/armeabi
SQLITE_LIBDIR 			:= $(THIRDPARTY_ANDROID_DIR)/obj/local/armeabi

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
	LOCAL_ARM_NEON 	:= true
	OSG_LIBDIR 			:= $(OSG_ANDROID_DIR)/obj/local/armeabi-v7a
	OSGEARTH_LIBDIR 		:= $(OSGEARTH_ANDROID_DIR)/obj/local/armeabi-v7a
	PNG_LIBDIR 			:= $(THIRDPARTY_ANDROID_DIR)/libpng/obj/local/armeabi-v7a
	TIFF_LIBDIR 			:= $(THIRDPARTY_ANDROID_DIR)/libtiff/obj/local/armeabi-v7a
	GDAL_LIBDIR 			:= $(THIRDPARTY_ANDROID_DIR)/gdal/obj/local/armeabi-v7a
	GEOS_LIBDIR 			:= $(THIRDPARTY_ANDROID_DIR)/geos/obj/local/armeabi-v7a
	PROJ_LIBDIR 			:= $(THIRDPARTY_ANDROID_DIR)/proj/obj/local/armeabi-v7a
	CURL_LIBDIR 			:= $(THIRDPARTY_ANDROID_DIR)/curl/obj/local/armeabi-v7a
	FREETYPE_LIBDIR 		:= $(THIRDPARTY_ANDROID_DIR)/freetype/obj/local/armeabi-v7a
	SQLITE_LIBDIR 			:= $(THIRDPARTY_ANDROID_DIR)/sqlite/obj/local/armeabi-v7a
endif

### Add all source file names to be included in lib separated by a whitespace

LOCAL_C_INCLUDES:= $(OSG_ANDROID_DIR)/include $(OSGEARTH_ANDROID_DIR)/src
LOCAL_CFLAGS    := -Werror -fno-short-enums -DANDROID -DOSGEARTH_LIBRARY_STATIC
LOCAL_CPPFLAGS  := -DOSG_LIBRARY_STATIC -DOSGEARTH_LIBRARY_STATIC -DANDROID

LOCAL_LDLIBS    := -llog -lGLESv2 -lz -lgnustl_static -ldl -fuse-ld=gold
LOCAL_SRC_FILES := osgNativeLib.cpp OsgMainApp.cpp OsgAndroidNotifyHandler.cpp DemoScene.cpp osgEarthDemo.cpp

LOCAL_LDFLAGS   := -L $(OSGEARTH_LIBDIR) \
-losgdb_kml \
-losgdb_osgearth_gdal \
-losgdb_osgearth_yahoo \
-losgdb_osgearth_osg \
-losgdb_osgearth_engine_osgterrain \
-losgdb_osgearth_engine_quadtree \
-losgdb_osgearth_feature_wfs \
-losgdb_osgearth_feature_tfs \
-losgdb_osgearth_tms \
-losgdb_osgearth_wms \
-losgdb_osgearth_label_overlay \
-losgdb_osgearth_xyz \
-losgdb_osgearth_label_annotation \
-losgdb_osgearth_mask_feature \
-losgdb_osgearth_model_feature_geom \
-losgdb_osgearth_feature_ogr \
-losgdb_osgearth_model_feature_stencil \
-losgdb_osgearth_vdatum_egm2008 \
-losgdb_osgearth_model_simple \
-losgdb_osgearth_vdatum_egm96 \
-losgdb_osgearth_ocean_surface \
-losgdb_osgearth_debug \
-losgdb_osgearth_mbtiles \
-losgdb_osgearth_vdatum_egm84 \
-losgdb_osgearth_tileservice \
-losgdb_osgearth_arcgis_map_cache \
-losgdb_osgearth_tilecache \
-losgdb_osgearth_wcs \
-losgdb_osgearth_cache_filesystem \
-losgdb_osgearth_arcgis \
-losgdb_earth \
-losgEarthAnnotation \
-losgEarthFeatures \
-losgEarthSymbology \
-losgEarthUtil \
-losgEarth \
-L $(OSG_LIBDIR) \
-losgdb_openflight \
-losgdb_curl \
-losgdb_tiff \
-losgdb_png \
-losgdb_obj \
-losgdb_shp \
-losgdb_rot \
-losgdb_scale \
-losgdb_trans \
-losgdb_jpeg \
-losgdb_freetype \
-losgdb_osgterrain \
-losgdb_osg \
-losgdb_ive \
-losgdb_deprecated_osgviewer \
-losgdb_deprecated_osgvolume \
-losgdb_deprecated_osgtext \
-losgdb_deprecated_osgterrain \
-losgdb_deprecated_osgsim \
-losgdb_deprecated_osgshadow \
-losgdb_deprecated_osgparticle \
-losgdb_deprecated_osgfx \
-losgdb_deprecated_osganimation \
-losgdb_deprecated_osg \
-losgdb_serializers_osgvolume \
-losgdb_serializers_osgtext \
-losgdb_serializers_osgterrain \
-losgdb_serializers_osgsim \
-losgdb_serializers_osgshadow \
-losgdb_serializers_osgparticle \
-losgdb_serializers_osgmanipulator \
-losgdb_serializers_osgfx \
-losgdb_serializers_osganimation \
-losgdb_serializers_osg \
-losgViewer \
-losgVolume \
-losgTerrain \
-losgText \
-losgShadow \
-losgSim \
-losgParticle \
-losgManipulator \
-losgGA \
-losgFX \
-losgDB \
-losgAnimation \
-losgUtil \
-losg \
-lOpenThreads \
-L $(PNG_LIBDIR) \
-lpng \
-L $(FREETYPE_LIBDIR) \
-lft2 \
-L $(CURL_LIBDIR) \
-lcurl \
-L $(GDAL_LIBDIR) \
-lgdal \
-L $(GEOS_LIBDIR) \
-lgeos \
-L $(PROJ_LIBDIR) \
-lproj \
-L $(SQLITE_LIBDIR) \
-lsqlite3
include $(BUILD_SHARED_LIBRARY)
