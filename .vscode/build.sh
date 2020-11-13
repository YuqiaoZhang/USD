#!/bin/bash

HERE="$(dirname "$(readlink -f "${0}")")"

cd "${HERE}/../"

#PATH="${HERE}"${PATH:+:}${PATH}
#python build_scripts/build_usd.py build --debug

#rm -rf build_cmake
mkdir -p build_cmake
cd build_cmake 

cmake \
-DOpenGL_GL_PREFERENCE=LEGACY \
-DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
-DCMAKE_C_FLAGS="-fPIE -fPIC" \
-DCMAKE_CXX_FLAGS="-fPIE -fPIC" \
-DCMAKE_EXE_LINKER_FLAGS="-pie -Wl,--no-undefined" \
-DCMAKE_SHARED_LINKER_FLAGS="-Wl,--no-undefined" \
-DPXR_BUILD_TESTS=OFF \
-DCMAKE_BUILD_TYPE=Debug \
-DGLEW_LOCATION="/usr" \
-DBOOST_ROOT="/usr" \
-DOPENEXR_LOCATION="/usr" \
-DTBB_ROOT_DIR="/usr" \
-DOPENSUBDIV_ROOT_DIR="${HERE}/../../OpenSubdiv/inst/" \
-DPXR_BUILD_USDVIEW=ON \
-DPXR_BUILD_USD_IMAGING=ON \
-DPXR_ENABLE_PTEX_SUPPORT=OFF \
-DCMAKE_INSTALL_PREFIX="${HERE}/../inst_cmake" \
"${HERE}/../"

cmake --build . --config Debug --target install -- -j12