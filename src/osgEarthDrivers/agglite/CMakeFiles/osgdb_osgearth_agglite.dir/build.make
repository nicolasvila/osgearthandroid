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
include src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/depend.make

# Include the progress variables for this target.
include src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/progress.make

# Include the compile flags for this target's objects.
include src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/flags.make

src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/AGGLiteRasterizerTileSource.cpp.o: src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/flags.make
src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/AGGLiteRasterizerTileSource.cpp.o: src/osgEarthDrivers/agglite/AGGLiteRasterizerTileSource.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/paulo/osgEarthAndroid/osgearth/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/AGGLiteRasterizerTileSource.cpp.o"
	cd /home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/agglite && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/osgdb_osgearth_agglite.dir/AGGLiteRasterizerTileSource.cpp.o -c /home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/agglite/AGGLiteRasterizerTileSource.cpp

src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/AGGLiteRasterizerTileSource.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/osgdb_osgearth_agglite.dir/AGGLiteRasterizerTileSource.cpp.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CXX_CREATE_PREPROCESSED_SOURCE

src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/AGGLiteRasterizerTileSource.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/osgdb_osgearth_agglite.dir/AGGLiteRasterizerTileSource.cpp.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CXX_CREATE_ASSEMBLY_SOURCE

src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/AGGLiteRasterizerTileSource.cpp.o.requires:
.PHONY : src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/AGGLiteRasterizerTileSource.cpp.o.requires

src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/AGGLiteRasterizerTileSource.cpp.o.provides: src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/AGGLiteRasterizerTileSource.cpp.o.requires
	$(MAKE) -f src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/build.make src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/AGGLiteRasterizerTileSource.cpp.o.provides.build
.PHONY : src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/AGGLiteRasterizerTileSource.cpp.o.provides

src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/AGGLiteRasterizerTileSource.cpp.o.provides.build: src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/AGGLiteRasterizerTileSource.cpp.o

# Object files for target osgdb_osgearth_agglite
osgdb_osgearth_agglite_OBJECTS = \
"CMakeFiles/osgdb_osgearth_agglite.dir/AGGLiteRasterizerTileSource.cpp.o"

# External object files for target osgdb_osgearth_agglite
osgdb_osgearth_agglite_EXTERNAL_OBJECTS =

lib/libosgdb_osgearth_agglite.a: src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/AGGLiteRasterizerTileSource.cpp.o
lib/libosgdb_osgearth_agglite.a: src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/build.make
lib/libosgdb_osgearth_agglite.a: src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX static library ../../../lib/libosgdb_osgearth_agglite.a"
	cd /home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/agglite && $(CMAKE_COMMAND) -P CMakeFiles/osgdb_osgearth_agglite.dir/cmake_clean_target.cmake
	cd /home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/agglite && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/osgdb_osgearth_agglite.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/build: lib/libosgdb_osgearth_agglite.a
.PHONY : src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/build

src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/requires: src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/AGGLiteRasterizerTileSource.cpp.o.requires
.PHONY : src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/requires

src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/clean:
	cd /home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/agglite && $(CMAKE_COMMAND) -P CMakeFiles/osgdb_osgearth_agglite.dir/cmake_clean.cmake
.PHONY : src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/clean

src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/depend:
	cd /home/paulo/osgEarthAndroid/osgearth && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/paulo/osgEarthAndroid/osgearth /home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/agglite /home/paulo/osgEarthAndroid/osgearth /home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/agglite /home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/osgEarthDrivers/agglite/CMakeFiles/osgdb_osgearth_agglite.dir/depend

