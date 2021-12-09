#
# IMGUI_INCLUDE_DIRS
# IMGUI_CFLAGS

SET(_IMGUI_SOURCE_FILES
    imgui.cpp
    imgui_demo.cpp
    imgui_draw.cpp
    imgui_tables.cpp
    imgui_widgets.cpp

    backends/imgui_impl_sdl.cpp
    backends/imgui_impl_opengl2.cpp
)

SET(_IMGUI_HEADER_FILES
    imgui.h

    backends/imgui_impl_sdl.h
    backends/imgui_impl_opengl2.h
)


find_path(IMGUI_PATH
    NAMES ${_IMGUI_HEADER_FILES} ${_IMGUI_SOURCE_FILES}
    HINTS
        ENV imguiPath
    PATHS
        ${PROJECT_SOURCE_DIR}/deps/imgui
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(IMGUI DEFAULT_MSG IMGUI_PATH)
mark_as_advanced(IMGUI_PATH)

find_package(SDL2 REQUIRED)

add_library(
    libimgui
    STATIC
    ${IMGUI_PATH}/imgui.cpp
    ${IMGUI_PATH}/imgui_demo.cpp
    ${IMGUI_PATH}/imgui_draw.cpp
    ${IMGUI_PATH}/imgui_tables.cpp
    ${IMGUI_PATH}/imgui_widgets.cpp

    ${IMGUI_PATH}/backends/imgui_impl_sdl.cpp
    ${IMGUI_PATH}/backends/imgui_impl_opengl2.cpp
)

target_include_directories(libimgui PRIVATE ${IMGUI_PATH} ${IMGUI_PATH}/backends)
target_include_directories(libimgui PUBLIC ${SDL2_INCLUDE_DIRS})

if(IMGUI_FOUND)
    set(IMGUI_INCLUDE_DIRS ${IMGUI_PATH} ${IMGUI_PATH}/backends)
    set(IMGUI_LIBRARIES libimgui)
endif()