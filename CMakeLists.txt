cmake_minimum_required(VERSION 3.15)
option(JS_ONLY "Compiles to native JS (No WASM)" OFF)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/dist")

project(mujoco_wasm)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++17 -O3")


list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include(dependencies)


include_directories("${FETCHCONTENT_BASE_DIR}/mujoco-src/include")

add_subdirectory(src)
