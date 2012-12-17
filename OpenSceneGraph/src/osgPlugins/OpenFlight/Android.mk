#ANDROID makefile         osgdb_openflight

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgPlugins/OpenFlight

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

LOCAL_MODULE :=           osgdb_openflight

LOCAL_SRC_FILES :=         AncillaryRecords.cpp AttrData.cpp ControlRecords.cpp DataInputStream.cpp DataOutputStream.cpp Document.cpp expAncillaryRecords.cpp expControlRecords.cpp expGeometryRecords.cpp expPrimaryRecords.cpp ExportOptions.cpp FltExportVisitor.cpp GeometryRecords.cpp LightPointRecords.cpp LightSourcePaletteManager.cpp MaterialPaletteManager.cpp PaletteRecords.cpp Pools.cpp PrimaryRecords.cpp ReaderWriterATTR.cpp ReaderWriterFLT.cpp Record.cpp RecordInputStream.cpp Registry.cpp ReservedRecords.cpp RoadRecords.cpp TexturePaletteManager.cpp Vertex.cpp VertexPaletteManager.cpp VertexRecords.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_CPPFLAGS :=          -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := 

include $(BUILD_STATIC_LIBRARY)

