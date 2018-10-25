project(opm)

cmake_minimum_required(VERSION 2.8)

foreach(TARGET opm-common opm-parser opm-output opm-material opm-grid
               ewoms opm-simulators opm-upscaling)
  set(${TARGET}_DIR ${CMAKE_BINARY_DIR}/${TARGET})
endforeach()

set(SIBLING_SEARCH 0)
# Necessary, sadly this means no IDE project generation
set_property(GLOBAL PROPERTY ALLOW_DUPLICATE_CUSTOM_TARGETS 1)
# new
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-sign-compare -Wno-deprecated-declarations -Wno-ignored-attributes")
enable_testing()
add_subdirectory(opm-common EXCLUDE_FROM_ALL)
add_dependencies(opmcommon ecl)
add_subdirectory(opm-material EXCLUDE_FROM_ALL)
add_dependencies(opm-material_prepare opmcommon)
add_subdirectory(opm-grid EXCLUDE_FROM_ALL)
add_dependencies(opmgrid opmcommon)

# To not build unrelated "tests" in ewoms unless requested
set(BUILD_TESTING 0)
# To not add disabled tests to the ctest list
set(ADD_DISABLED_CTESTS 0)
add_subdirectory(ewoms EXCLUDE_FROM_ALL)
add_dependencies(ewoms_prepare opmgrid)
set(BUILD_TESTING 0)

add_subdirectory(opm-simulators)
add_dependencies(opmsimulators opmgrid)
#add_subdirectory(opm-upscaling)
#add_dependencies(opmupscaling opmgrid)
