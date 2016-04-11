cmake_minimum_required(VERSION 3.1)

project(visages-superProject)

## #############################################################################
## Add packages
## #############################################################################

list(APPEND external_projects
  ANIMA
#  QtShanoir  
  visagesPlugins
  )


## #############################################################################
## Add modules
## #############################################################################

set(CMAKE_MODULE_PATH
  ${CMAKE_CURRENT_SOURCE_DIR}/superbuild/projects_modules
  ${CMAKE_MODULE_PATH}
  )
    
    
## #############################################################################
## Add variables
## #############################################################################

if (DEFINED CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE ${CMAKE_BUILD_TYPE} CACHE STRING
    "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel.")
else()
   
  set(CMAKE_BUILD_TYPE Release CACHE STRING
    "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel.")
endif()

## #############################################################################
## Add Targets
## #############################################################################

set(global_targets 
  configure 
  install
  )
  
# This adds targets that will be run in each external-projects
set_property(DIRECTORY PROPERTY EP_STEP_TARGETS ${global_targets})

## #############################################################################
## Find medinria super build
## #############################################################################

file(TO_CMAKE_PATH “${MEDINRIA_SUPERBUILD_DIR}" MEDINRIA_SUPERBUILD_DIR)
find_package(MEDINRIA_SUPERBUILD REQUIRED)


## #############################################################################
## Configure external-projects
## #############################################################################

include(ConfigureExternalProjects)





