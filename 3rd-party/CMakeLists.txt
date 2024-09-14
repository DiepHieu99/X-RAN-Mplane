# CMakeLists.txt in the 3rd-party folder
cmake_minimum_required (VERSION 3.16)

# Iterate over all subfolders in the 3rd-party folder
file(GLOB subfolders RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *)
foreach(subfolder ${subfolders})
    # Create a CMakeLists.txt file in each subfolder
    set(subfolder_CMakeLists ${CMAKE_CURRENT_SOURCE_DIR}/${subfolder}/CMakeLists.txt)
    file(WRITE ${subfolder_CMakeLists} "cmake_minimum_required(VERSION 3.16)\n")
    file(APPEND ${subfolder_CMakeLists} "project(${subfolder})\n")
    file(APPEND ${subfolder_CMakeLists} "add_executable(${subfolder} ${subfolder}/src/main.cpp)\n")
    file(APPEND ${subfolder_CMakeLists} "install(TARGETS ${subfolder} DESTINATION bin)\n")
endforeach()

# Create a Makefile in the 3rd-party folder
add_custom_target(make_all
    COMMAND ${CMAKE_MAKE_PROGRAM} -j8
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

# Create an install target in the 3rd-party folder
add_custom_target(install_all
    COMMAND ${CMAKE_MAKE_PROGRAM} install
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    DEPENDS make_all
)
