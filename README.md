rust-gamedev-kit
================

This is a set of git submodules that point to versions of the Rust compiler and
various libraries (mostly relevant to game development) that are known to work
together.

I (rlane) did not write any of the included libraries. See the links to the
original repositories below. A few libraries have been lightly patched.

The Rust version used is 0.9.

Libraries
=========

* [glfw](https://github.com/glfw/glfw)
* [glfw-rs](https://github.com/bjz/glfw-rs)
* [gl-rs](https://github.com/bjz/gl-rs)
* [cgmath-rs](https://github.com/bjz/cgmath-rs)
* [noise-rs](https://github.com/bjz/noise-rs)

Usage
=====

When you clone the repository, and after updating it, you need to run the build
script:

    ./build.sh

This installs Rust and all the libraries to the `install` directory. It also
creates a `env.sh` script that defines environment variables telling Rust where
the installed libraries are.

To get ready to build a project that uses these libraries:

    source env.sh

This sets up PATH and RUST_PATH. Now you can cd to your project's directory and
run `rustpkg install`.

Platforms
=========

Tested on OS X 10.9 and 32-bit Ubuntu 12.04.
