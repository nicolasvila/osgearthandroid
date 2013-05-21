#ANDROID makefile         osgdb_kml

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/kml

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

LOCAL_MODULE :=           osgdb_kml

LOCAL_SRC_FILES :=         ReaderWriterKML.cpp KMLReader.cpp KML_Document.cpp KML_Feature.cpp KML_Folder.cpp KML_Geometry.cpp KML_GroundOverlay.cpp KML_IconStyle.cpp KML_LabelStyle.cpp KML_LinearRing.cpp KML_LineString.cpp KML_LineStyle.cpp KML_Model.cpp KML_MultiGeometry.cpp KML_NetworkLink.cpp KML_NetworkLinkControl.cpp KMLNodeInfo.cpp KML_Object.cpp KML_Overlay.cpp KML_PhotoOverlay.cpp KML_Placemark.cpp KML_Point.cpp KML_Polygon.cpp KML_PolyStyle.cpp KML_Root.cpp KML_Schema.cpp KML_ScreenOverlay.cpp KML_Style.cpp KML_StyleMap.cpp KMZArchive.cpp

LOCAL_C_INCLUDES :=        /stlport /home/paulo/osgEarthAndroid/osgearth/src /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID

LOCAL_CPPFLAGS :=          -DANDROID

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := 

include $(BUILD_STATIC_LIBRARY)

