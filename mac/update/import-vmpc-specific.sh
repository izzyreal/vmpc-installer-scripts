#!/bin/sh

readonly OLD_VMPC_SPECIFIC_PATH=~/vMPC/resources/vmpc-specific.ini
readonly NEW_CONFIG_DIR='/Library/Application Support/VMPC2000XL/config'
readonly NEW_VMPC_SPECIFIC_PATH=$NEW_CONFIG_DIR/vmpc-specific.ini

mkdir -p "$NEW_CONFIG_DIR"

[ -f $OLD_VMPC_SPECIFIC_PATH ] && cp -p $OLD_VMPC_SPECIFIC_PATH "$NEW_VMPC_SPECIFIC_PATH"