#!/bin/bash -eux
cd $(dirname $0)
RUST_GAMEDEV_KIT_ROOT=$(pwd -P)

TARGET=$(rustc -v | grep '^host:' | cut -d ' ' -f 2)
LIBDIR=$RUST_GAMEDEV_KIT_ROOT/install/lib/rustlib/$TARGET/lib
mkdir -p $LIBDIR

(
    set -eux
    rm -rf glfw/build
    mkdir glfw/build
    cd glfw/build
    cmake -DCMAKE_INSTALL_PREFIX:PATH=$RUST_GAMEDEV_KIT_ROOT/install \
        -DBUILD_SHARED_LIBS:BOOL=ON \
        -DGLFW_BUILD_EXAMPLES:BOOL=OFF \
        -DGLFW_BUILD_TESTS:BOOL=OFF \
        -DGLFW_BUILD_DOCS:BOOL=OFF \
        ..
    make all
    make install
)

(
    set -eux
    cd glfw-rs
    rm -rf build
    export PKG_CONFIG_PATH=$RUST_GAMEDEV_KIT_ROOT/install/lib/pkgconfig 
    LINK_ARGS=$(pkg-config --libs glfw3)
    make lib LINK_ARGS="$LINK_ARGS"
    cp lib/* $LIBDIR
)

rustc --out-dir $LIBDIR -L $LIBDIR --crate-type dylib --opt-level 3 gl-rs/src/gl/lib.rs
rustc --out-dir $LIBDIR -L $LIBDIR --crate-type dylib --opt-level 3 noise-rs/src/noise/lib.rs
rustc --out-dir $LIBDIR -L $LIBDIR --crate-type dylib --opt-level 3 cgmath-rs/src/cgmath/lib.rs
rustc --out-dir $LIBDIR -L $LIBDIR --crate-type dylib --opt-level 3 hgl-rs/src/lib.rs
rustc --out-dir $LIBDIR -L $LIBDIR --crate-type dylib --opt-level 3 color-rs/src/lib.rs
