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
include src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/depend.make

# Include the progress variables for this target.
include src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/progress.make

# Include the compile flags for this target's objects.
include src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/flags.make

src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/ReaderWriterWMS.cpp.o: src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/flags.make
src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/ReaderWriterWMS.cpp.o: src/osgEarthDrivers/wms/ReaderWriterWMS.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/paulo/osgEarthAndroid/osgearth/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/ReaderWriterWMS.cpp.o"
	cd /home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/wms && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/osgdb_osgearth_wms.dir/ReaderWriterWMS.cpp.o -c /home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/wms/ReaderWriterWMS.cpp

src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/ReaderWriterWMS.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/osgdb_osgearth_wms.dir/ReaderWriterWMS.cpp.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CXX_CREATE_PREPROCESSED_SOURCE

src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/ReaderWriterWMS.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/osgdb_osgearth_wms.dir/ReaderWriterWMS.cpp.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CXX_CREATE_ASSEMBLY_SOURCE

src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/ReaderWriterWMS.cpp.o.requires:
.PHONY : src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/ReaderWriterWMS.cpp.o.requires

src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/ReaderWriterWMS.cpp.o.provides: src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/ReaderWriterWMS.cpp.o.requires
	$(MAKE) -f src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/build.make src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/ReaderWriterWMS.cpp.o.provides.build
.PHONY : src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/ReaderWriterWMS.cpp.o.provides

src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/ReaderWriterWMS.cpp.o.provides.build: src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/ReaderWriterWMS.cpp.o

src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/TileService.cpp.o: src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/flags.make
src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/TileService.cpp.o: src/osgEarthDrivers/wms/TileService.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /home/paulo/osgEarthAndroid/osgearth/CMakeFiles $(CMAKE_PROGRESS_2)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/TileService.cpp.o"
	cd /home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/wms && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/osgdb_osgearth_wms.dir/TileService.cpp.o -c /home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/wms/TileService.cpp

src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/TileService.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/osgdb_osgearth_wms.dir/TileService.cpp.i"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CXX_CREATE_PREPROCESSED_SOURCE

src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/TileService.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/osgdb_osgearth_wms.dir/TileService.cpp.s"
	$(CMAKE_COMMAND) -E cmake_unimplemented_variable CMAKE_CXX_CREATE_ASSEMBLY_SOURCE

src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/TileService.cpp.o.requires:
.PHONY : src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/TileService.cpp.o.requires

src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/TileService.cpp.o.provides: src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/TileService.cpp.o.requires
	$(MAKE) -f src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/build.make src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/TileService.cpp.o.provides.build
.PHONY : src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/TileService.cpp.o.provides

src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/TileService.cpp.o.provides.build: src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/TileService.cpp.o

# Object files for target osgdb_osgearth_wms
osgdb_osgearth_wms_OBJECTS = \
"CMakeFiles/osgdb_osgearth_wms.dir/ReaderWriterWMS.cpp.o" \
"CMakeFiles/osgdb_osgearth_wms.dir/TileService.cpp.o"

# External object files for target osgdb_osgearth_wms
osgdb_osgearth_wms_EXTERNAL_OBJECTS =

lib/libosgdb_osgearth_wms.a: src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/ReaderWriterWMS.cpp.o
lib/libosgdb_osgearth_wms.a: src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/TileService.cpp.o
lib/libosgdb_osgearth_wms.a: src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/build.make
lib/libosgdb_osgearth_wms.a: src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX static library ../../../lib/libosgdb_osgearth_wms.a"
	cd /home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/wms && $(CMAKE_COMMAND) -P CMakeFiles/osgdb_osgearth_wms.dir/cmake_clean_target.cmake
	cd /home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/wms && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/osgdb_osgearth_wms.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/build: lib/libosgdb_osgearth_wms.a
.PHONY : src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/build

src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/requires: src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/ReaderWriterWMS.cpp.o.requires
src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/requires: src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/TileService.cpp.o.requires
.PHONY : src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/requires

src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/clean:
	cd /home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/wms && $(CMAKE_COMMAND) -P CMakeFiles/osgdb_osgearth_wms.dir/cmake_clean.cmake
.PHONY : src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/clean

src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/depend:
	cd /home/paulo/osgEarthAndroid/osgearth && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/paulo/osgEarthAndroid/osgearth /home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/wms /home/paulo/osgEarthAndroid/osgearth /home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/wms /home/paulo/osgEarthAndroid/osgearth/src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/osgEarthDrivers/wms/CMakeFiles/osgdb_osgearth_wms.dir/depend
