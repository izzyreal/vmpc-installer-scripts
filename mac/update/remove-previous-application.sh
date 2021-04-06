#!/bin/sh

readonly APPLICATION_PATH=/Applications/vMPC.app

# If the old application path exists, recursively remove it
[ -d $APPLICATION_PATH ] && rm -rf $APPLICATION_PATH
