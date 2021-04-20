#!/bin/sh
readonly APPLICATION_PATH=/Applications/vMPC.app
readonly SETTINGS_PATH='~/Library/Application Support/vmpc.settings'

# If the old application path exists, recursively remove it
[ -d $APPLICATION_PATH ] && rm -rf $APPLICATION_PATH

# If the old settings file exists, remove it
[ -f $SETTINGS_PATH ] && rm $SETTINGS_PATH