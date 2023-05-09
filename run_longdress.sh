#!/bin/bash

OBJECTS=( "longdress" "loot" "redandblack" "soldier")
RATES=( "r1" "r3" "r5" )

for OBJECT in "${OBJECTS[@]}"
do
    echo $OBJECT
    for RATE in "${RATES[@]}"
    do
        echo $RATE
        root_dir=/home/shared2/spirit/subjective_test/raw_data/$OBJECT/$OBJECT
        for file in ${root_dir}/Ply/*
        do
            fileName="${file##*/}"
            ./build/Release/pc_error \
               --fileA=$root_dir/Ply/$fileName \
               --fileB=$root_dir/${OBJECT}-$RATE/$fileName \
               --color=1 >> ${OBJECT}_${RATE}.txt
        done
    done
done
