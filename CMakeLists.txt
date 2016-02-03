cmake_minimum_required(VERSION 3.1)

project(test)

set(CMAKE_CXX_STANDARD 11)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

if(NOT CMAKE_BUILD_TYPE)
    SET(CMAKE_BUILD_TYPE "DEBUG")
    message("Setting to be debug")
ENDIF()

# Configure the compiler:
if (APPLE)
    set(CMAKE_MACOSX_RPATH true)
endif(APPLE)

set ( CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS} ${CMAKE_CXX_FLAGS_DEBUG} -Wall -pedantic -Wuninitialized")
set ( CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS} ${CMAKE_CXX_FLAGS_RELEASE} -Wall -Wuninitialized")

#need to add more components, used for testing
# find_package(Boost 1.57.0 COMPONENTS system chrono thread filesystem unit_test_framework signals REQUIRED )

# if(NOT Boost_FOUND)
#     message(fatal_error "Boost was not found. See FindBoost.cmake for details.")
# endif()

find_package(V8 REQUIRED)

INCLUDE_DIRECTORIES(${Boost_INCLUDE_DIR} /usr/local/include)

list(APPEND CMAKE_LIBRARY_PATH "${Boost_LIBRARY_DIR}")

add_executable(testmain ./main.cpp)
target_link_libraries(testmain ${Boost_LIBRARIES})