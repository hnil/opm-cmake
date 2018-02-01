project(opm)
option(DEV_BUILD "only include needed" ON )
cmake_minimum_required(VERSION 2.8)
#cmake_policy(SET CMP0024 OLD)#cgiykd be removed
foreach(TARGET opm-common opm-parser opm-output opm-material opm-grid
               ewoms opm-simulators opm-upscaling)
  set(${TARGET}_DIR ${CMAKE_BINARY_DIR}/${TARGET})
endforeach()
set(BUILD_TESTING 0)
set(BUILD_EXAMPLES 1)
set(ADD_DISABLED_CTESTS 0)
set(SIBLING_SEARCH 0)
set_property(GLOBAL PROPERTY ALLOW_DUPLICATE_CUSTOM_TARGETS 1)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-sign-compare -Wno-deprecated-declarations ")

#enable_testing()
add_subdirectory(opm-common  EXCLUDE_FROM_ALL)

add_subdirectory(opm-parser  EXCLUDE_FROM_ALL)
add_dependencies(opmparser ecl)

add_subdirectory(opm-output EXCLUDE_FROM_ALL)
add_dependencies(opmoutput opmparser)

add_subdirectory(opm-material EXCLUDE_FROM_ALL)
# opmmaterial not make target
#add_dependencies(opmmaterial opmcommon)#opmparser 
#foreach(TARGET test_blackoilfluidstate test_eclblackoilfluidsystem
#                test_eclblackoilpvt test_eclmateriallawmanager
#                test_fluidmatrixinteractions test_pengrobinson
#                test_densead test_ncpflash test_spline test_tabulation
#                test_2dtables test_components test_fluidsystems test_immiscibleflash)
#   add_dependencies(${TARGET} opmcommon opmparser)
# endforeach()



add_subdirectory(opm-grid  EXCLUDE_FROM_ALL)
add_dependencies(opmgrid opmparser)
# # # To not build a shitload of unrelated "tests" in ewoms unless requested


# # # To not add disabled tests to the ctest list.. Another andreas quirk


# # # Nope. Quadmath make everything run like molassis
# set(USE_QUADMATH 0)

#eworms do not make a target
add_subdirectory(ewoms EXCLUDE_FROM_ALL)
#add_subdirectory(ewoms)
#ewoms is not a target use an executable to get dependencies
#add_dependencies(ebos opmgrid opmoutput)
# # set(BUILD_TESTING 1) 
add_subdirectory(opm-simulators  EXCLUDE_FROM_ALL)
add_dependencies(opmsimulators opmgrid opmoutput opmcommon)

add_subdirectory(opm-testing)
add_dependencies(flow_test opmgrid opmoutput opmcommon opmsimulators)
# # add_subdirectory(opm-upscaling)
# # add_dependencies(opmupscaling opmoutput opmgrid)
