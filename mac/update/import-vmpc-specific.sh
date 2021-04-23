#!/bin/sh
readonly OLD_VMPC_SPECIFIC_PATH=~/vMPC/resources/vmpc-specific.ini

readonly NEW_CONFIG_DIR="$HOME/Library/Application Support/VMPC2000XL/config"

[ -d "$NEW_CONFIG_DIR" ] ||
		mkdir -p "$NEW_CONFIG_DIR" &&
		OWNER=$(ls -ld $OLD_VMPC_SPECIFIC_PATH | awk '{print $3}') &&
		chown -R $OWNER "$NEW_CONFIG_DIR";

[ -f $OLD_VMPC_SPECIFIC_PATH ] && cp -p $OLD_VMPC_SPECIFIC_PATH "$NEW_CONFIG_DIR"
