#!/bin/sh

cabal clean
cabal build 
./dist-newstyle/build/x86_64-linux/ghc-*/enm-0.1.0.0/x/enm/build/enm/enm $1
