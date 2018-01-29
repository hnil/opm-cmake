project(opm)

cmake_minimum_required(VERSION 2.8)

foreach(TARGET opm-common opm-parser opm-output opm-material opm-grid
               opm-core ewoms opm-simulators opm-upscaling)
  set(${TARGET}_DIR ${CMAKE_BINARY_DIR}/${TARGET})
endforeach()

set(SIBLING_SEARCH 0)
set_property(GLOBAL PROPERTY ALLOW_DUPLICATE_CUSTOM_TARGETS 1)

enable_testing()
add_subdirectory(opm-common)
add_subdirectory(opm-parser)
add_dependencies(opmparser ecl)
add_subdirectory(opm-output)
add_dependencies(opmoutput opmparser)
add_subdirectory(opm-material)

# # This is nasty but there is no single target to depend on in template-only libraries
# foreach(TARGET test_blackoilfluidstate test_eclblackoilfluidsystem
#                test_eclblackoilpvt test_eclmateriallawmanager
#                test_fluidmatrixinteractions test_pengrobinson
#                test_densead test_ncpflash test_spline test_tabulation
#                test_2dtables test_components test_fluidsystems test_immiscibleflash)
#   add_dependencies(${TARGET} opmparser)
# endforeach()
add_subdirectory(opm-grid)
add_dependencies(opmgrid opmparser)
# # To not build a shitload of unrelated "tests" in ewoms unless requested
set(BUILD_TESTING 0)

# # To not add disabled tests to the ctest list.. Another andreas quirk
set(ADD_DISABLED_CTESTS 0)

# # Nope. Quadmath make everything run like molassis
set(USE_QUADMATH 0)

add_subdirectory(ewoms)
# set(BUILD_TESTING 1)
add_subdirectory(opm-simulators)
add_dependencies(opmsimulators opmgrid)
# add_subdirectory(opm-upscaling)
# add_dependencies(opmupscaling opmcore)
