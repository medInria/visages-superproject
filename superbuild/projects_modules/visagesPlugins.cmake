function(visagesPlugins_project)

set(ep visagesPlugins)

## #############################################################################
## List the dependencies of the project
## #############################################################################

list(APPEND ${ep}_dependencies 
  ANIMA
#  QtShanoir
  )
  
  
## #############################################################################
## Prepare the project
## ############################################################################# 

EP_Initialisation(${ep}  
  USE_SYSTEM OFF 
  BUILD_SHARED_LIBS ON
  REQUIRED_FOR_PLUGINS OFF
  )


if (NOT USE_SYSTEM_${ep})

## #############################################################################
## Define repository where get the sources
## #############################################################################

set(url ${GITHUB_PREFIX}medInria/medInria-visages.git)
if (NOT DEFINED ${ep}_SOURCE_DIR)
  set(location GIT_REPOSITORY ${url})
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
  -DCMAKE_C_FLAGS:STRING=${${ep}_c_flags}
  -DCMAKE_CXX_FLAGS:STRING=${${ep}_cxx_flags}  
  -DCMAKE_SHARED_LINKER_FLAGS:STRING=${${ep}_shared_linker_flags}  
  -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
  -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS_${ep}}
  -DQt5_DIR:PATH=${Qt5_DIR}
  -Ddtk_DIR:FILEPATH=${dtk_DIR}
  -DITK_DIR:FILEPATH=${ITK_DIR}
  -DVTK_DIR:FILEPATH=${VTK_DIR}
  -DRPI_DIR:FILEPATH=${RPI_DIR}
  -DmedInria_DIR:FILEPATH=${medInria_DIR}
  -DANIMA_DIR:FILEPATH=${ANIMA_BUILD_DIR}
  -DANIMA_PRIVATE_DIR:FILEPATH=${ANIMA_PRIVATE_DIR}
#  -DQTSHANOIR_DIR:FILEPATH=${QtShanoir_DIR}
  -DBOOST_ROOT:PATH=${BOOST_ROOT}
  )

## #############################################################################
## Add external-project
## #############################################################################

ExternalProject_Add(${ep}
  PREFIX ${CMAKE_BINARY_DIR}/${ep}
  SOURCE_DIR ${CMAKE_SOURCE_DIR}/thirdparts/${ep}
  BINARY_DIR ${CMAKE_BINARY_DIR}/${ep}
  ${location}
  CMAKE_GENERATOR ${gen}
  CMAKE_ARGS ${cmake_args}
  DEPENDS ${${ep}_dependencies}
  INSTALL_COMMAND ""
  )

## #############################################################################
## Set variable to provide infos about the project
## #############################################################################

ExternalProject_Get_Property(${ep} binary_dir)
set(${ep}_DIR ${binary_dir} PARENT_SCOPE)

endif()

endfunction()
