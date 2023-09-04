#!/bin/sh

# make clean
for size in MINI SMALL MEDIUM LARGE
do
    export DATASET_SIZE=${size}
    make
done