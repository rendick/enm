#!/bin/sh

cabal build 
./dist-newstyle/build/x86_64-linux/ghc-9.2.8/enm-0.1.0.0/x/enm/build/enm/enm $1
