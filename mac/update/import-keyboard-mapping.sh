#!/bin/sh
readonly OLD_MAPPING_PATH=~/vMPC/resources/keys.txt

readonly NEW_CONFIG_DIR='~/Library/Application Support/VMPC2000XL/config'
readonly NEW_MAPPING_PATH=$NEW_CONFIG_DIR/keys.txt

[ -f "$NEW_MAPPING_PATH" ] && mv "$NEW_MAPPING_PATH" "$NEW_MAPPING_PATH.bk"

[ -d "$NEW_CONFIG_DIR" ] || [ 
	mkdir -p "$NEW_CONFIG_DIR" &&
  OWNER=$(ls -ld $OLD_MAPPING_PATH | awk '{print $3}') &&
  chown -R $OWNER $NEW_CONFIG_DIR
]

[ -f $OLD_MAPPING_PATH ] && cp -p $OLD_MAPPING_PATH "$NEW_MAPPING_PATH"
