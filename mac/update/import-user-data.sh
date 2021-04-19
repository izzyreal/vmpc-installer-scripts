#!/bin/sh

readonly OLD_DATA_PATH=~/vMPC/Stores/MPC2000XL
readonly NEW_DOC_PATH=~/Documents/VMPC2000XL
readonly NEW_DATA_PARENT_PATH=~/Documents/VMPC2000XL/Volumes
readonly NEW_DATA_PATH=~/Documents/VMPC2000XL/Volumes/MPC2000XL

BK_UUID=$(cat /dev/urandom | LC_CTYPE=C tr -dc 'a-zA-Z0-9' | fold -w 6 | head -n 1)

[ -d $NEW_DATA_PATH ] && mv $NEW_DATA_PATH $NEW_DATA_PATH-$BK_UUID

[ -D $NEW_DATA_PARENT_PATH ] || [
	mkdir -p $NEW_DATA_PARENT_PATH &&
	OWNER=$(ls -ld $OLD_DATA_PATH | awk '{print $3}') &&
	chown -R $OWNER $NEW_DOC_PATH
]

[ -d $OLD_DATA_PATH ] && cp -rp $OLD_DATA_PATH $NEW_DATA_PARENT_PATH
