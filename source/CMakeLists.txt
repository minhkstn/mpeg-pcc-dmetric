cmake_minimum_required(VERSION 3.5 FATAL_ERROR)

set(CMAKE_CONFIGURATION_TYPES "Release;Debug" CACHE STRING "Release;Debug")

project(pc_error)

# Comment this block out, if no multithreading is wanted. @DT
find_package(OpenMP)
if (OPENMP_FOUND)
  message(STATUS "OpenMP found.")
  set (CMAKE_C_FLAGS   "${CMAKE_C_FLAGS}   ${OpenMP_C_FLAGS}")
  set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
  add_compile_options( -D OPENMP_FOUND )
endif()

if (NOT WIN32)
  if (CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -m64 -DNDEBUG -mfpmath=sse -ffp-contract=off -ffp-model=strict ")
  endif()

  # Compil and link config (no-fast-math is important for portable results)
  set(CMAKE_CXX_FLAGS_RELEASE "-Wno-unused-result -O3 -DNDEBUG -D_REENTRANT -DLinux -fno-fast-math -ftree-vectorize -msse2 -msse3 -D__STDC_CONSTANT_MACROS -fpermissive")
  set(CMAKE_C_FLAGS_RELEASE   "-Wno-unused-result -O3 -DNDEBUG -D_REENTRANT -DLinux -fno-fast-math -ftree-vectorize -msse2 -msse3")

  set(CMAKE_CXX_FLAGS_DEBUG   "-Wno-unused-result -g -DDEBUG  -D_REENTRANT -DLinux -D__STDC_CONSTANT_MACROS -fno-fast-math  -fpermissive")
  set(CMAKE_C_FLAGS_DEBUG     "-Wno-unused-result -g -DDEBUG  -D_REENTRANT -DLinux")

  if (CMAKE_CXX_COMPILER_VERSION VERSION_GREATER 4.7 OR CMAKE_CXX_COMPILER_VERSION VERSION_EQUAL 4.7)
    # message(STATUS "Version >= 4.7!" ${GCC_VERSION})
    set (CMAKE_C_FLAGS   "${CMAKE_C_FLAGS}   -std=c++11")
    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
  else()
    # message(STATUS "Version < 4.7!" ${GCC_VERSION})
    set (CMAKE_C_FLAGS   "${CMAKE_C_FLAGS}   -std=c++0x")
    set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
  endif()
endif()

file(GLOB_RECURSE PROJ_HEADERS ${CMAKE_CURRENT_SOURCE_DIR}/*.h*)
file(GLOB SOURCE               ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp
                               ${CMAKE_SOURCE_DIR}/../dependencies/program-options-lite/* )

include_directories( ${CMAKE_CURRENT_SOURCE_DIR}
                     ${CMAKE_SOURCE_DIR}/../dependencies/)

if (NOT MSVC)
  list(REMOVE_ITEM SOURCE "${CMAKE_CURRENT_SOURCE_DIR}/stdafx.cpp")
endif()
add_executable(pc_error ${SOURCE})

install(TARGETS pc_error DESTINATION ".")

# print target path
add_custom_command(TARGET pc_error POST_BUILD COMMAND echo "Target path: $<TARGET_FILE:pc_error>")
