#!/bin/bash

TEMP_POINTS_FILE="../temp_points.txt"

@point() {
    echo $1 >> $TEMP_POINTS_FILE
}
