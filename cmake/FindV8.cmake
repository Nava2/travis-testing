# Locate V8
# This module defines
# V8_LIBRARY
# V8_FOUND, if false, do not try to link to gdal
# V8_INCLUDE_DIR, where to find the headers
#
# $V8_DIR is an environment variable that would
# correspond to the ./configure --prefix=$V8_DIR
#
# Created by Robert Osfield (based on FindFLTK.cmake)
# 
# Source: http://trac.openscenegraph.org/projects/osg/browser/OpenSceneGraph/trunk/CMakeModules/FindV8.cmake

FIND_PATH(V8_HEADER_DIR 
  NAMES "v8.h" "v8-platform.h"
  PATHS
  $ENV{V8_DIR}/include
  $ENV{V8_DIR}
  ~/Library/Frameworks
  /Library/Frameworks
  /usr/local/include
  /usr/include
  /sw/include # Fink
  /opt/local/include # DarwinPorts
  /opt/csw/include # Blastwave
  /opt/include
  /usr/freeware/include
)

FIND_PATH(V8_LIBRARY_DIR
  # NAMES v8 libv8 
  NAMES v8 libv8 libv8_base.a libv8_libbase.a libv8_libplatform.a
  PATHS
  ${V8_HEADER_DIR}/../
  $ENV{V8_DIR}
  ~/Library/Frameworks
  /Library/Frameworks
  /usr/local
  /usr
  /sw
  /opt/local
  /opt/csw
  /opt
  /usr/freeware/lib64
  PATH_SUFFIXES lib out/x64.release out/x86.release
)

SET(V8_FOUND "NO")
IF(V8_LIBRARY_DIR AND V8_HEADER_DIR)
  SET(V8_FOUND "YES")

  get_filename_component(V8_INCLUDE_DIR ${V8_HEADER_DIR} DIRECTORY)

  find_package( Threads )

  set(V8_LIBRARIES ${V8_LIBRARY_DIR}/libv8_base.a 
                   ${V8_LIBRARY_DIR}/libv8_libbase.a 
                   ${V8_LIBRARY_DIR}/libv8_libplatform.a
                   ${V8_LIBRARY_DIR}/libv8_nosnapshot.a  
                   ${V8_LIBRARY_DIR}/libv8_snapshot.a 
                   ${CMAKE_THREAD_LIBS_INIT} )
ENDIF()
