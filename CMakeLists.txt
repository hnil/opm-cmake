project(opm)


cmake_minimum_required(VERSION 2.8)

foreach(TARGET opm-common opm-parser opm-output opm-material opm-grid
               opm-core ewoms opm-simulators opm-upscaling)
  set(${TARGET}_DIR ${CMAKE_BINARY_DIR}/${TARGET})
endforeach()
option(DEV_BUILD "only include needed" ON )
set(SIBLING_SEARCH 0)
set_property(GLOBAL PROPERTY ALLOW_DUPLICATE_CUSTOM_TARGETS 1)

enable_testing()
add_subdirectory(opm-common)
add_subdirectory(opm-parser)
add_dependencies(opmparser ecl opmcommon)
add_subdirectory(opm-output)
add_dependencies(opmoutput opmparser)
add_subdirectory(opm-material)

# This is nasty but there is no single target to depend on in template-only libraries
foreach(TARGET test_blackoilfluidstate test_eclblackoilfluidsystem
               test_eclblackoilpvt test_eclmateriallawmanager
               test_fluidmatrixinteractions test_pengrobinson
               test_densead test_ncpflash test_spline test_tabulation
               test_2dtables test_components test_fluidsystems test_immiscibleflash)
  add_dependencies(${TARGET} opmparser)
endforeach()
add_subdirectory(opm-grid)
add_dependencies(opmgrid opmparser)
#add_subdirectory(opm-core)
#add_dependencies(opmcore opmgrid opmoutput)

# To not build a shitload of unrelated "tests" in ewoms unless requested
set(BUILD_TESTING 0)

# To not add disabled tests to the ctest list.. Another andreas quirk
set(ADD_DISABLED_CTESTS 0)

# Nope. Quadmath make everything run like molassis
set(USE_QUADMATH 0)

add_subdirectory(ewoms)
add_dependencies(eworm ecl opmcommon opmgrid)
set(ewoms_TARGETS ebos)

# .. template library
# set(ewoms_TARGETS ebos art2dgf co2injection_flash_ni_vcfv
#                   co2injection_flash_ni_ecfv
#                   co2injection_flash_vcfv
#                   co2injection_flash_ecfv
#                   co2injection_ncp_ni_vcfv
#                   co2injection_pvs_ni_vcfv
#                   co2injection_ncp_vcfv
#                   co2injection_pvs_vcfv
#                   co2injection_immiscible_ni_vcfv
#                   co2injection_immiscible_vcfv
#                   co2injection_immiscible_ecfv
#                   co2injection_ncp_ecfv
#                   co2injection_pvs_ecfv
#                   co2injection_immiscible_ni_ecfv
#                   co2injection_ncp_ni_ecfv
#                   co2injection_pvs_ni_ecfv
#                   powerinjection_forchheimer_fd
#                   powerinjection_forchheimer_ad
#                   powerinjection_darcy_fd
#                   powerinjection_darcy_ad
#                   cuvette_pvs
#                   infiltration_pvs
#                   lens_richards_vcfv
#                   lens_richards_ecfv
#                   obstacle_immiscible
#                   obstacle_ncp
#                   obstacle_pvs
#                   outflow_pvs
#                   diffusion_flash
#                   diffusion_ncp
#                   diffusion_pvs
#                   groundwater_immiscible
#                   reservoir_blackoil_vcfv
#                   reservoir_blackoil_ecfv
#                   reservoir_ncp_vcfv
#                   reservoir_ncp_ecfv
#                   test_propertysystem
#                   test_quadrature
#                   obstacle_immiscible_parameters
#                   obstacle_pvs_restart
#                   tutorial1
#                   fracture_discretefracture
#                   finger_immiscible_ecfv
#                   finger_immiscible_vcfv
#                   finger_immiscible_ecfv
#                   co2injection_ncp_ni_ecfv_parallel
#                   obstacle_immiscible_parallel
#                   lens_immiscible_vcfv_fd_parallel
#                   lens_immiscible_vcfv_ad_parallel
#                   lens_immiscible_ecfv_ad_parallel
#                   lens_immiscible_vcfv_fd
#                   lens_immiscible_ecfv_ad
#                   lens_immiscible_vcfv_ad
#                   lens_immiscible_ecfv_ad_mcu
#                   test_equil
#                   waterair_pvs_ni)

#foreach(TARGET ${ewoms_TARGETS})
#  if(TARGET ${TARGET})
#    add_dependencies(${TARGET} opmcore) 
#  endif()
#endforeach()

set(BUILD_TESTING 1)
add_subdirectory(opm-simulators)
add_dependencies(opmsimulators opmgrid)# opmcore)
add_subdirectory(opm-upscaling)
add_dependencies(opmupscaling opmsimulators)
