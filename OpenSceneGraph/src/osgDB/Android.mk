#ANDROID makefile         osgDB

LOCAL_PATH :=             /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/src/osgDB

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

LOCAL_MODULE :=           osgDB

LOCAL_SRC_FILES :=         ObjectWrapper.cpp InputStream.cpp OutputStream.cpp Compressors.cpp Archive.cpp AuthenticationMap.cpp Callbacks.cpp ConvertUTF.cpp DatabasePager.cpp DatabaseRevisions.cpp DotOsgWrapper.cpp DynamicLibrary.cpp ExternalFileWriter.cpp Field.cpp FieldReader.cpp FieldReaderIterator.cpp FileCache.cpp FileNameUtils.cpp FileUtils.cpp fstream.cpp ImageOptions.cpp ImagePager.cpp Input.cpp MimeTypes.cpp Output.cpp Options.cpp PluginQuery.cpp ReaderWriter.cpp ReadFile.cpp Registry.cpp SharedStateManager.cpp StreamOperator.cpp Version.cpp WriteFile.cpp XmlParser.cpp

LOCAL_C_INCLUDES :=        /home/paulo/osgEarthAndroid/osgearth/OpenSceneGraph/include

LOCAL_CFLAGS :=            -DANDROID -DOSG_LIBRARY_STATIC -DOSG_PLUGIN_EXTENSION=.so

LOCAL_CPPFLAGS :=          -DANDROID -DOSG_LIBRARY_STATIC -DOSG_PLUGIN_EXTENSION=.so

LOCAL_SHARED_LIBRARIES :=  
LOCAL_STATIC_LIBRARIES := osg;osgUtil;OpenThreads

include $(BUILD_STATIC_LIBRARY)

