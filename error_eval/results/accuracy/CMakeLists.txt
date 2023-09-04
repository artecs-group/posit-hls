cmake_minimum_required(VERSION 3.0 FATAL_ERROR)
project(accuracy)

set(SRC_FOLDER "${CMAKE_CURRENT_LIST_DIR}/src")
include_directories("~/Documents/libs/universal/include")

add_executable(accuracy ${SRC_FOLDER}/accuracy.cpp)
set_property(TARGET accuracy PROPERTY CXX_STANDARD 17)

# Define the possible values for POLYB
set(POLYB_VALUES 3mm cholesky covariance durbin fdtd-2d gemm ludcmp seidel-2d)  # Add more values if needed

foreach(POLYB_VALUE ${POLYB_VALUES})
    add_executable(accuracy_${POLYB_VALUE} ${SRC_FOLDER}/accuracy.cpp)
    set_property(TARGET accuracy_${POLYB_VALUE} PROPERTY CXX_STANDARD 17)
    target_compile_definitions(accuracy_${POLYB_VALUE} PRIVATE -DPOLYB=\"${POLYB_VALUE}\")
endforeach()


# add_executable(accuracy_gemm ${SRC_FOLDER}/accuracy.cpp)
# set_property(TARGET accuracy_gemm PROPERTY CXX_STANDARD 17)
# target_compile_definitions(accuracy_gemm PRIVATE -DPOLYB=\"gemm\")

# add_executable(accuracy_3mm ${SRC_FOLDER}/accuracy.cpp)
# set_property(TARGET accuracy_3mm PROPERTY CXX_STANDARD 17)
# target_compile_definitions(accuracy_3mm PRIVATE -DPOLYB=\"3mm\")


