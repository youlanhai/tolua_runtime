#!/usr/bin/env bash

cd luajit-2.1
make clean

make BUILDMODE=static CC="gcc -m32 -O3"
cp src/libluajit.a ../macjit/x86/libluajit.a
make clean

make BUILDMODE=static CC="gcc -m64 -O2" XCFLAGS=-DLUAJIT_ENABLE_GC64
cp src/libluajit.a ../macjit/x86_64/libluajit.a
make clean

cd ..

cd macjit/

lipo -create x86/libluajit.a x86_64/libluajit.a -output libluajit.a
ranlib libluajit.a

xcodebuild clean
xcodebuild -configuration=Release
cp -rf build/Release/tolua.bundle ../Plugins/
