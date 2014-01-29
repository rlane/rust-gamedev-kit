#!/bin/bash -eux
RUST_GAMEDEV_KIT_ROOT=$(dirname $(readlink -f $0))
cd $RUST_GAMEDEV_KIT_ROOT

git submodule update --init

rm -rf install

(
    cd rust
    ./configure --prefix=$RUST_GAMEDEV_KIT_ROOT/install
    make
    make install
)

(
    cd install/lib
    ln -sf rustlib/i686-unknown-linux-gnu/lib/libnative-* .
)

PATH=$RUST_GAMEDEV_KIT_ROOT/install/bin:$PATH
export RUST_PATH=$RUST_GAMEDEV_KIT_ROOT/install/lib

which rustpkg

(
    rm -rf glfw/build
    mkdir glfw/build
    cd glfw/build
    cmake -DCMAKE_INSTALL_PREFIX:PATH=$RUST_GAMEDEV_KIT_ROOT/install \
        -DBUILD_SHARED_LIBS:BOOL=ON \
        -DGLFW_BUILD_EXAMPLES:BOOL=OFF \
        -DGLFW_BUILD_TESTS:BOOL=OFF \
        -DGLFW_BUILD_DOCS:BOOL=OFF \
        ..
    make all install
)

(cd glfw-rs && rustpkg clean glfw && rustpkg install --opt-level=3 glfw)
(cd cgmath-rs && rustpkg clean cgmath && rustpkg install --opt-level=3 cgmath)
(cd noise-rs && rustpkg clean noise && rustpkg install --opt-level=3 noise)
(cd gl-rs && rustpkg clean gl && rustpkg install --opt-level=3 gl)

cat > $RUST_GAMEDEV_KIT_ROOT/env.sh <<EOS
export LD_LIBRARY_PATH=$RUST_GAMEDEV_KIT_ROOT/install/lib:\$LD_LIBRARY_PATH
export PATH=$RUST_GAMEDEV_KIT_ROOT/install/bin:\$PATH
export RUST_PATH=$RUST_GAMEDEV_KIT_ROOT/glfw-rs:$RUST_GAMEDEV_KIT_ROOT/cgmath-rs:$RUST_GAMEDEV_KIT_ROOT/noise-rs:$RUST_GAMEDEV_KIT_ROOT/gl-rs:$RUST_GAMEDEV_KIT_ROOT/install/lib
EOS
