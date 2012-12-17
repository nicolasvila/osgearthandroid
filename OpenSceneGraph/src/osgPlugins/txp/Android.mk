#ANDROID makefile         osgdb_txp

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgPlugins/txp

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

LOCAL_MODULE :=           osgdb_txp

LOCAL_SRC_FILES :=         ReaderWriterTXP.cpp TileMapper.cpp trpage_basic.cpp trpage_compat.cpp trpage_geom.cpp trpage_header.cpp trpage_label.cpp trpage_light.cpp trpage_main.cpp trpage_managers.cpp trpage_material.cpp trpage_model.cpp trpage_nodes.cpp trpage_parse.cpp trpage_pparse.cpp trpage_print.cpp trpage_print_parse.cpp trpage_range.cpp trpage_rarchive.cpp trpage_readbuf.cpp trpage_scene.cpp trpage_swap.cpp trpage_tile.cpp trpage_util.cpp trpage_warchive.cpp trpage_writebuf.cpp TXPArchive.cpp TXPIO.cpp TXPNode.cpp TXPPagedLOD.cpp TXPPageManager.cpp TXPParser.cpp TXPSeamLOD.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgPlugins/txp

LOCAL_CFLAGS :=            -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_CPPFLAGS :=          -DANDROID -DOSG_LIBRARY_STATIC

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := 

include $(BUILD_STATIC_LIBRARY)

