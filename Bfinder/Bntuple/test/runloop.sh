#!/bin/bash

set -x
g++ loop.C $(root-config --libs --cflags) -g -o loop.exe && { ./loop.exe HiForestAOD_20.root ntuple.root 0 0 -1; }
rm loop.exe
set +x