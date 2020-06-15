#!/bin/bash

clear_temps() {
    if [ -e $TEMP_RESULTS_FILE ]; then
        rm $TEMP_RESULTS_FILE
    fi
    
    if [ -e $TEMP_POINTS_FILE ]; then
        rm $TEMP_POINTS_FILE
    fi
}