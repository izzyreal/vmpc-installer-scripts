#!/bin/sh

readonly OLD_NVRAM_PATH=~/vMPC/resources/nvram.vmp
readonly NEW_CONFIG_DIR='/Library/Application Support/VMPC2000XL/config'
readonly NEW_NVRAM_PATH=$NEW_CONFIG_DIR/nvram.vmp

mkdir -p "$NEW_CONFIG_DIR"

[ -f $OLD_NVRAM_PATH ] && cp -p $OLD_NVRAM_PATH "$NEW_NVRAM_PATH"
