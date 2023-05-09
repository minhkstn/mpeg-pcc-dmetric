#!/bin/bash

OBJECTS=( "loot" )
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
            refFileName="${file##*/}"
	    IFS='_' read -ra nameParts <<< "$refFileName"
	    fileName=${nameParts[0]}_${nameParts[1]}_${RATE}_${nameParts[2]}
	    echo $fileName
            ./build/Release/pc_error \
               --fileA=$root_dir/Ply/$refFileName \
               --fileB=$root_dir/${OBJECT}-$RATE/$fileName \
	       --nbThreads=10 \
               --color=1 >> ${OBJECT}_${RATE}_single.txt
        done
    done
done
