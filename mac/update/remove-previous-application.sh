#!/bin/sh
readonly APPLICATION_PATH=/Applications/vMPC.app
readonly SETTINGS_PATH="$HOME/Library/Application Support/vmpc.settings"
readonly DEMO_DATA_PATH="/Library/Application Support/VMPC2000XL"

# If the old application path exists, recursively remove it
[ -d $APPLICATION_PATH ] && rm -rf $APPLICATION_PATH

# If the old settings file exists, remove it
[ -f $SETTINGS_PATH ] && rm "$SETTINGS_PATH"

# If the old demo data path exists, recursively remove it
[ -d $DEMO_DATA_PATH ] && rm -rf $APPLICATION_PATH
