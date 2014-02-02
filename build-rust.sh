#!/bin/bash -eux
cd $(dirname $0)
RUST_GAMEDEV_KIT_ROOT=$(pwd -P)

cd rust
./configure --prefix=$RUST_GAMEDEV_KIT_ROOT/install
make clean
make all
make install
