#
# Get information about the current processor
#
execute_process(
  COMMAND uname -m
  COMMAND tr -d '\n'
  OUTPUT_VARIABLE BUZZ_PROCESSOR_ARCH)

#
# Select ISO C++11
#
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

#
# General compilation flags
#
set(CMAKE_C_FLAGS   "${CMAKE_C_FLAGS} -Wall -std=c99 -D_GNU_SOURCE")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -D_GNU_SOURCE")
if(NOT APPLE)
  set(BUZZ_FLAGS_DEBUG "-g -ggdb3")
  add_definitions(-D_GNU_SOURCE)
else(NOT APPLE)
  set(BUZZ_FLAGS_DEBUG "-g -gdwarf-3")
endif(NOT APPLE)
set(CMAKE_C_FLAGS_DEBUG             ${BUZZ_FLAGS_DEBUG})
set(CMAKE_C_FLAGS_RELEASE           "-Os -DNDEBUG")
set(CMAKE_C_FLAGS_RELWITHDEBINFO    "${BUZZ_FLAGS_DEBUG} -Os -DNDEBUG")
set(CMAKE_CXX_FLAGS_DEBUG           ${CMAKE_C_FLAGS_DEBUG})
set(CMAKE_CXX_FLAGS_RELEASE         ${CMAKE_C_FLAGS_RELEASE})
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO  ${CMAKE_C_FLAGS_RELWITHDEBINFO})
set(CMAKE_EXE_LINKER_FLAGS_DEBUG    ${BUZZ_FLAGS_DEBUG})
set(CMAKE_MODULE_LINKER_FLAGS_DEBUG ${BUZZ_FLAGS_DEBUG})
set(CMAKE_SHARED_LINKER_FLAGS_DEBUG ${BUZZ_FLAGS_DEBUG})

if(APPLE)
  # Add address sanitizer support for CLang
  set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -fsanitize=address -fno-optimize-sibling-calls -fno-omit-frame-pointer")
  set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -fsanitize=address -fno-optimize-sibling-calls -fno-omit-frame-pointer")
  set(CMAKE_C_FLAGS_RELWITHDEBINFO "${CMAKE_C_FLAGS_DEBUG} ${CMAKE_C_FLAGS_RELEASE}")
  set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELEASE} ${CMAKE_CXX_FLAGS_DEBUG}")
  set(CMAKE_MODULE_LINKER_FLAGS_DEBUG "${CMAKE_MODULE_LINKER_FLAGS_DEBUG} -fsanitize=address")
  set(CMAKE_SHARED_LINKER_FLAGS_DEBUG "${CMAKE_SHARED_LINKER_FLAGS_DEBUG} -fsanitize=address")
  set(CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG} -fsanitize=address")
  set(CMAKE_MODULE_LINKER_FLAGS_RELWITHDEBINFO "${CMAKE_MODULE_LINKER_FLAGS_RELEASE} ${CMAKE_MODULE_LINKER_FLAGS_DEBUG}")
  set(CMAKE_SHARED_LINKER_FLAGS_RELWITHDEBINFO "${CMAKE_SHARED_LINKER_FLAGS_RELEASE} ${CMAKE_SHARED_LINKER_FLAGS_DEBUG}")
  set(CMAKE_EXE_LINKER_FLAGS_RELWITHDEBINFO "${CMAKE_EXE_LINKER_FLAGS_RELEASE} ${CMAKE_EXE_LINKER_FLAGS_DEBUG}")
endif(APPLE)
