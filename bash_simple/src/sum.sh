#!/bin/bash

function sum() {
    local RESULT=0
    nums=("$@")

    for i in "${nums[@]}"; do 
        RESULT=$(($RESULT+$i)); 
    done

    return $RESULT
}

sum "$@"
echo "Sum is $?."