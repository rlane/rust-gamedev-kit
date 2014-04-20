rust-gamedev-kit
================

![Build status](https://travis-ci.org/rlane/rust-gamedev-kit.png)

This is a set of git submodules that point to versions of the Rust compiler and
various libraries (mostly relevant to game development) that are known to work
together.

I (rlane) did not write any of the included libraries. See the links to the
original repositories below. A few libraries have been lightly patched.

The Rust version used is 0.10.

Libraries
=========

* [glfw](https://github.com/glfw/glfw)
* [glfw-rs](https://github.com/bjz/glfw-rs)
* [gl-rs](https://github.com/bjz/gl-rs)
* [cgmath-rs](https://github.com/bjz/cgmath-rs)
* [noise-rs](https://github.com/bjz/noise-rs)
* [hgl-rs](https://github.com/cmr/hgl-rs)
* [color-rs](https://github.com/bjz/color-rs)

Usage
=====

When you clone the repository, and after updating it, you need to run the build
script:

    ./build.sh

This installs Rust and all the libraries to the `install` directory.
You can add the `install/bin` directory to your PATH, or run rustc
directly from there when compiling your project.

Platforms
=========

Tested on OS X 10.9 and 32-bit Ubuntu 12.04.

Users
=====

* [cubeland](https://github.com/rlane/cubeland)
