#!/bin/sh
readonly OLD_NVRAM_PATH=~/vMPC/resources/nvram.vmp

readonly NEW_CONFIG_DIR="$HOME/Library/Application Support/VMPC2000XL/config"

[ -d "$NEW_CONFIG_DIR" ] ||
	mkdir -p "$NEW_CONFIG_DIR" &&
	OWNER=$(ls -ld $OLD_NVRAM_PATH | awk '{print $3}') &&
	chown -R $OWNER "$NEW_CONFIG_DIR"

[ -f $OLD_NVRAM_PATH ] && cp -p $OLD_NVRAM_PATH "$NEW_CONFIG_DIR"
