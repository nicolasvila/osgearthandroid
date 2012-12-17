# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# The program to use to edit the cache.
CMAKE_EDIT_COMMAND = /usr/bin/cmake-gui

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/paulo/osgEarthAndroid/osgearth

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/paulo/osgEarthAndroid/osgearth

# Include any dependencies generated for this target.
include src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/depend.make

# Include the progress variables for this target.
include src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/progress.make

# Include the compile flags for this target's objects.
include src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/flags.make

src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/osgearth_city.cpp.o: src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/flags.make
src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/osgearth_city.cpp.o: src/applications/osgearth_city/osgearth_city.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/paulo/osgEarthAndroid/osgearth/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/osgearth_city.cpp.o"
	cd /home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_city && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/application_osgearth_city.dir/osgearth_city.cpp.o -c /home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_city/osgearth_city.cpp

src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/osgearth_city.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/application_osgearth_city.dir/osgearth_city.cpp.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CXX_CREATE_PREPROCESSED_SOURCE

src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/osgearth_city.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/application_osgearth_city.dir/osgearth_city.cpp.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CXX_CREATE_ASSEMBLY_SOURCE

src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/osgearth_city.cpp.o.requires:
.PHONY : src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/osgearth_city.cpp.o.requires

src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/osgearth_city.cpp.o.provides: src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/osgearth_city.cpp.o.requires
	$(MAKE) -f src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/build.make src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/osgearth_city.cpp.o.provides.build
.PHONY : src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/osgearth_city.cpp.o.provides

src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/osgearth_city.cpp.o.provides.build: src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/osgearth_city.cpp.o

# Object files for target application_osgearth_city
application_osgearth_city_OBJECTS = \
"CMakeFiles/application_osgearth_city.dir/osgearth_city.cpp.o"

# External object files for target application_osgearth_city
application_osgearth_city_EXTERNAL_OBJECTS =

bin/osgearth_city: src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/osgearth_city.cpp.o
bin/osgearth_city: lib/libosgEarth.a
bin/osgearth_city: lib/libosgEarthFeatures.a
bin/osgearth_city: lib/libosgEarthUtil.a
bin/osgearth_city: lib/libosgEarthSymbology.a
bin/osgearth_city: lib/libosgEarthAnnotation.a
bin/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosg.a
bin/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosgDB.a
bin/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosgUtil.a
bin/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosgViewer.a
bin/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libOpenThreads.a
bin/osgearth_city: lib/libosgEarthFeatures.a
bin/osgearth_city: lib/libosgEarthSymbology.a
bin/osgearth_city: lib/libosgEarth.a
bin/osgearth_city: OpenSceneGraph/3rdparty/build/curl/obj/local/armeabi-v7a/libcurl.a
bin/osgearth_city: OpenSceneGraph/3rdparty/build/zlib/obj/local/armeabi-v7a/libz.a
bin/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosgWidget.a
bin/osgearth_city: 3rdparty/obj/local/armeabi-v7a/libgeos.a
bin/osgearth_city: OpenSceneGraph/3rdparty/build/gdal/obj/local/armeabi-v7a/libgdal.a
bin/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosg.a
bin/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosgUtil.a
bin/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosgSim.a
bin/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosgTerrain.a
bin/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosgDB.a
bin/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosgFX.a
bin/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosgShadow.a
bin/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosgManipulator.a
bin/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosgViewer.a
bin/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosgText.a
bin/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosgGA.a
bin/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libOpenThreads.a
bin/osgearth_city: src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/build.make
bin/osgearth_city: src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX executable ../../../bin/osgearth_city"
	cd /home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_city && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/application_osgearth_city.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/build: bin/osgearth_city
.PHONY : src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/build

# Object files for target application_osgearth_city
application_osgearth_city_OBJECTS = \
"CMakeFiles/application_osgearth_city.dir/osgearth_city.cpp.o"

# External object files for target application_osgearth_city
application_osgearth_city_EXTERNAL_OBJECTS =

src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/osgearth_city.cpp.o
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: lib/libosgEarth.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: lib/libosgEarthFeatures.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: lib/libosgEarthUtil.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: lib/libosgEarthSymbology.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: lib/libosgEarthAnnotation.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosg.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosgDB.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosgUtil.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosgViewer.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libOpenThreads.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: lib/libosgEarthFeatures.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: lib/libosgEarthSymbology.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: lib/libosgEarth.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: OpenSceneGraph/3rdparty/build/curl/obj/local/armeabi-v7a/libcurl.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: OpenSceneGraph/3rdparty/build/zlib/obj/local/armeabi-v7a/libz.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosgWidget.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: 3rdparty/obj/local/armeabi-v7a/libgeos.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: OpenSceneGraph/3rdparty/build/gdal/obj/local/armeabi-v7a/libgdal.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosg.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosgUtil.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosgSim.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosgTerrain.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosgDB.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosgFX.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosgShadow.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosgManipulator.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosgViewer.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosgText.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libosgGA.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: OpenSceneGraph/obj/local/armeabi-v7a/libOpenThreads.a
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/build.make
src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city: src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/relink.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX executable CMakeFiles/CMakeRelink.dir/osgearth_city"
	cd /home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_city && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/application_osgearth_city.dir/relink.txt --verbose=$(VERBOSE)

# Rule to relink during preinstall.
src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/preinstall: src/applications/osgearth_city/CMakeFiles/CMakeRelink.dir/osgearth_city
.PHONY : src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/preinstall

src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/requires: src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/osgearth_city.cpp.o.requires
.PHONY : src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/requires

src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/clean:
	cd /home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_city && $(CMAKE_COMMAND) -P CMakeFiles/application_osgearth_city.dir/cmake_clean.cmake
.PHONY : src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/clean

src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/depend:
	cd /home/paulo/osgEarthAndroid/osgearth && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/paulo/osgEarthAndroid/osgearth /home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_city /home/paulo/osgEarthAndroid/osgearth /home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_city /home/paulo/osgEarthAndroid/osgearth/src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/applications/osgearth_city/CMakeFiles/application_osgearth_city.dir/depend

