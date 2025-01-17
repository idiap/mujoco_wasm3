include(FetchContent)


#################################################
# libccd

set(ENABLE_DOUBLE_PRECISION ON)
set(CCD_HIDE_ALL_SYMBOLS ON)

set(LIBCCD_CMAKE_PATCH git apply ${CMAKE_CURRENT_SOURCE_DIR}/cmake/patches/libccd.patch)

# Fetch the repositories
FetchContent_Declare(
    ccd
    GIT_REPOSITORY https://github.com/danfis/libccd.git
    GIT_TAG "7931e764a19ef6b21b443376c699bbc9c6d4fba8" # aka "v2.1"
    PATCH_COMMAND ${LIBCCD_CMAKE_PATCH}
    UPDATE_DISCONNECTED 1
)

FetchContent_MakeAvailable(ccd)


#################################################
# Mujoco

set(MUJOCO_CMAKE_PATCH git apply ${CMAKE_CURRENT_SOURCE_DIR}/cmake/patches/mujoco.patch)

# Fetch the repositories
FetchContent_Declare(
    mujoco
    GIT_REPOSITORY https://github.com/google-deepmind/mujoco.git
    GIT_TAG "0f64959e279e63b62a7610c23e0396c000f28c06" # aka "3.2.6"
    PATCH_COMMAND ${MUJOCO_CMAKE_PATCH}
    UPDATE_DISCONNECTED 1
)

FetchContent_MakeAvailable(mujoco)
