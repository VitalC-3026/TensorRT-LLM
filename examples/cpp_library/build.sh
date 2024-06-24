#!/usr/bin/env bash

BUILD_DIR="build"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
TENSORRT_LLM_DIR="../../tensorrt_llm/libs"

rm -rf ${BUILD_DIR} && mkdir -p ${BUILD_DIR}

pushd ${BUILD_DIR}

cmake \
    -DCMAKE_BUILD_TYPE=Release \
    ..

make -j"$(grep -c ^processor /proc/cpuinfo)"

export LD_LIBRARY_PATH="${SCRIPT_DIR}:${LD_LIBRARY_PATH}"
export LD_LIBRARY_PATH="${TENSORRT_LLM_DIR}:${LD_LIBRARY_PATH}"

# Test Lib
echo
echo "--------------------------------------------------------------------"
echo "${LD_LIBRARY_PATH}"
./trt_llm_plugins_cpp_load_example
echo "--------------------------------------------------------------------"
echo

popd
