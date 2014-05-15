Android VirtualGlobe
=================================

Implementation of a virtual globe application for Android.
This project is based on the virtual globe framework [osgEarth](http://osgearth.org/) and it\'s [android branch](https://github.com/gwaldron/osgearth/tree/topic-android).

## Requirements

Besides the Android SDK, the setup of this project needs the Android NDK framework. In this project the version r8b of this framework was used. To install the Android NDK its necessary to execute the following steps:

	cd Android
	wget https://dl.google.com/android/ndk/android-ndk-r8b-linux-x86.tar.bz2

After this installation, its necessary to define two environmental variables:

	export ANDROID_NDK=/home/jgr/Android/android-ndk-r8b 
	export ANDROID_SDK=/home/jgr/Android/android-sdk-linux

The Android folder used is then where both the SDK and the NDK frameworks are installed.
The compilation of this project is supported by the cmake tool, used to generate the necessary Makefiles. To compile this project the version 2.6.4, or higher, of cmake is necessary.

## Obtaining the source code

The necessary source code can be obtained from following repository:
https://bitbucket.org/jgrocha/osgearthandroid

To download the code the following steps should be taken:

	cd
	git clone git@bitbucket.org:jgrocha/osgearthandroid.git 
	cd osgearthandroid/

In this manner, all the code will be in the folder osgearthandroid.

## Compilation of OpenSceneGraph

The compilation of OpenSceneGraph depends on several auxiliary libraries. So, before the compilation process one should download these libraries into the appropriate folder.

	cd OpenSceneGraph 
	wget http://www2.ai2.upv.es/difusion/osgAndroid/3rdpartyAndroid.zip 
	unzip 3rdpartyAndroid.zip 

	cmake . -DOSG_BUILD_PLATFORM_ANDROID=ON -DDYNAMIC_OPENTHREADS=OFF -DDYNAMIC_OPENSCENEGRAPH=OFF -DOSG_GL1_AVAILABLE=OFF -DOSG_GL2_AVAILABLE=OFF -DOSG_GL3_AVAILABLE=OFF -DOSG_GLES1_AVAILABLE=OFF -DOSG_GLES2_AVAILABLE=ON -DOSG_GL_LIBRARY_STATIC=OFF -DOSG_GL_DISPLAYLISTS_AVAILABLE=OFF -DOSG_GL_MATRICES_AVAILABLE=OFF -DOSG_GL_VERTEX_FUNCS_AVAILABLE=OFF -DOSG_GL_VERTEX_ARRAY_FUNCS_AVAILABLE=OFF -DOSG_GL_FIXED_FUNCTION_AVAILABLE=OFF -DANDROID_ABI="armeabi armeabi-v7a" -DANDROID_PLATFORM=8 -DANDROID_STL="gnustl_static" -DJ=4 

	make

## Compilation of osgEarth

This compilation is executed in two steps.

### Compilation of all dependences to Android

	# Move into osgearthandroid/3rdparty/jni
	cd ../3rdparty/jni
	~/Android/android-ndk-r8b/ndk-build

### Compilation of osgEarth to Android

	# Move into osgearthandroid
	cd ../..
	cmake . -DOSG_BUILD_PLATFORM_ANDROID=ON -DJ=4 -DOSG_DIR="./OpenSceneGraph" -DDYNAMIC_OSGEARTH=OFF -DOPENTHREADS_LIBRARY="./OpenSceneGraph/obj/local/armeabi/libOpenThreads.a" -DCURL_LIBRARY="./OpenSceneGraph/3rdparty/build/curl/obj/local/armeabi/libcurl.a" -DGDAL_LIBRARY="./osgearthandroid/OpenSceneGraph/3rdparty/build/gdal/obj/local/armeabi/libgdal.a" -DGEOS_LIBRARY="./3rdparty/obj/local/armeabi/libgeos.a" -DSQLITE3_INCLUDE_DIR="./3rdparty/jni/sqlite-autoconf-3071401" -DSQLITE3_LIBRARY="./3rdparty/obj/local/armeabi/libsqlite3.a"

	make

## Generation of osgViewer

The generation of the Android application is made in two steps. First we build the library libosgNativeLib.so and than the osgViewer.apk.

### Generation of the library libosgNativeLib.so

	cd osgViewer/jni
	~/Android/android-ndk-r8b/ndk-build

The makefile includes two debug instructions that present the computed PATH. The output of the execution of this makefile (via ndk-build) should be similar to the following:

	value of LOCAL_PATH is: /home/jgr/GIS/osgearthandroid/osgViewer/jni 
	value of OSGEARTH_ANDROID_DIR is: /home/jgr/GIS/osgearthandroid/osgViewer/jni/../.. 
	Gdbserver      : [arm-linux-androideabi-4.6] libs/armeabi/gdbserver 
	Gdbsetup       : libs/armeabi/gdb.setup 
	Install        : libosgNativeLib.so => libs/armeabi/libosgNativeLib.so

### Generation of osgViewer.apk

After opening Eclipse IDE, go to File → Import..., choose the option “Existing Android Code Into Workspace”.
In the following dialog, its necessary to point out the folder with the source code (osgearthandroid) and select the project osgViewer.
After the project is imported into Eclipse we should be able to execute it. The generated apk is localized in osgViewer/bin/osgViewer.apk.
