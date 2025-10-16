project(mujoco_wasm)

set(SOURCE_FILES throw_hook.cpp main.genned.cc)
add_compile_options(-pthread)
set(EMCC_LINKER_FLAGS "-s ASSERTIONS=1 --bind -s ALLOW_MEMORY_GROWTH=1 -s STACK_SIZE=131072 -s EXPORT_ES6=1 -s MODULARIZE=1 -s FORCE_FILESYSTEM=1 -s EXPORTED_RUNTIME_METHODS=['FS','MEMFS'] -s EXPORT_NAME=load_mujoco -s EXCEPTION_CATCHING_ALLOWED=['load_from_xml'] -s DEMANGLE_SUPPORT=1 --profiling --profiling-funcs")
set(CMAKE_REQUIRED_FLAGS "${EMCC_LINKER_FLAGS}")
add_executable(mujoco_wasm ${SOURCE_FILES})
set_target_properties(mujoco_wasm PROPERTIES LINK_FLAGS "${EMCC_LINKER_FLAGS}")

target_link_options(mujoco_wasm PRIVATE "-Wl,--wrap=__cxa_throw")
target_link_libraries(mujoco_wasm ccd elasticity lodepng mujoco tinyxml2 qhullstatic_r)
install(TARGETS mujoco_wasm DESTINATION ${DIVISIBLE_INSTALL_BIN_DIR})
