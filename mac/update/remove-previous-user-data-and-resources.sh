#!/bin/sh

readonly DATA_AND_RESOURCES_PATH=~/vMPC

# If the old data and resources path exists, recursively remove it
[ -d $DATA_AND_RESOURCES_PATH ] && rm -rf $DATA_AND_RESOURCES_PATH
