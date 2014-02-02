#!/bin/bash -eux
cd $(dirname $0)
RUST_GAMEDEV_KIT_ROOT=$(pwd -P)

git submodule update --init
rm -rf install

./build-rust.sh

PATH=$RUST_GAMEDEV_KIT_ROOT/install/bin:$PATH
which rustc

./build-libraries.sh
