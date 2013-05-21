#ANDROID makefile         osgdb_osgearth_engine_mp

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/engine_mp

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

LOCAL_MODULE :=           osgdb_osgearth_engine_mp

LOCAL_SRC_FILES :=         CustomPagedLOD.cpp KeyNodeFactory.cpp LODFactorCallback.cpp MPGeometry.cpp MPTerrainEngineNode.cpp MPTerrainEngineDriver.cpp SerialKeyNodeFactory.cpp TerrainNode.cpp TileModelCompiler.cpp TileNode.cpp TileNodeRegistry.cpp TileModelFactory.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/src /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID

LOCAL_CPPFLAGS :=          -DANDROID

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := 

include $(BUILD_STATIC_LIBRARY)

