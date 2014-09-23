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
## Set directories
## #############################################################################

EP_SetDirectories(${ep}
  EP_DIRECTORIES ep_dirs
  )


## #############################################################################
## Define repository where get the sources
## #############################################################################

set(url git://scm.gforge.inria.fr/qtshanoir/qtshanoir.git)
set(tag 604f109a1ae3a5251ad27a497077dd577fc8f8df)
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
  -DCMAKE_C_FLAGS:STRING=${${ep}_c_flags}
  -DCMAKE_CXX_FLAGS:STRING=${${ep}_cxx_flags}  
  -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
  -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS_${ep}}
  -DQT_QMAKE_EXECUTABLE:PATH=${QT_QMAKE_EXECUTABLE}
  )

## #############################################################################
## Add external-project
## #############################################################################

ExternalProject_Add(${ep}
  ${ep_dirs}
  ${location}
  CMAKE_GENERATOR ${gen}
  CMAKE_ARGS ${cmake_args}
  INSTALL_COMMAND ""  
  UPDATE_COMMAND ""
  )

## #############################################################################
## Set variable to provide infos about the project
## #############################################################################

ExternalProject_Get_Property(${ep} binary_dir)
set(${ep}_DIR ${binary_dir} PARENT_SCOPE)


## #############################################################################
## Add custom targets
## #############################################################################

EP_AddCustomTargets(${ep})

endif()

endfunction()
