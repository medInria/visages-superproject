function(QtShanoir_project)

set(ep QtShanoir)
  
## #############################################################################
## Prepare the project
## ############################################################################# 

EP_Initialisation(${ep}  
  USE_SYSTEM OFF 
  BUILD_SHARED_LIBS OFF
  REQUIRED_FOR_PLUGINS OFF
  )


if (NOT USE_SYSTEM_${ep})

## #############################################################################
## Define repository where get the sources
## #############################################################################

set(url ${GITHUB_PREFIX}Inria-Visages/QtShanoir.git)
set(tag 360c3ef96529287aed8d5a4fa89ab71dc51d7f90)
if (NOT DEFINED ${ep}_SOURCE_DIR)
  set(location GIT_REPOSITORY ${url} GIT_TAG ${tag})
endif()


## #############################################################################
## Add specific cmake arguments for configuration step of the project
## #############################################################################

# set compilation flags
if (UNIX)
  set(${ep}_c_flags "${${ep}_c_flags} -Wall")
  set(${ep}_cxx_flags "${${ep}_cxx_flags} -Wall")
endif()

set(cmake_args
  ${ep_common_cache_args}
  -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
  -DCMAKE_C_FLAGS:STRING=${${ep}_c_flags}
  -DCMAKE_CXX_FLAGS:STRING=${${ep}_cxx_flags}
  -DCMAKE_CXX_STANDARD:STRING=11
  -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
  -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS_${ep}}
  -DQt5_DIR:PATH=${Qt5_DIR}
  )

## #############################################################################
## Add external-project
## #############################################################################

ExternalProject_Add(${ep}
  PREFIX ${CMAKE_BINARY_DIR}/${ep}
  SOURCE_DIR ${CMAKE_SOURCE_DIR}/${ep}
  BINARY_DIR ${CMAKE_BINARY_DIR}/${ep}
  ${location}
  CMAKE_GENERATOR ${gen}
  CMAKE_ARGS ${cmake_args}
  INSTALL_COMMAND ""
  )

## #############################################################################
## Set variable to provide infos about the project
## #############################################################################

ExternalProject_Get_Property(${ep} binary_dir)
set(${ep}_DIR ${binary_dir} PARENT_SCOPE)

endif()

endfunction()
