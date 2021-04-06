#!/bin/sh

readonly OLD_DATA_PATH=~/vMPC/Stores/MPC2000XL
readonly NEW_DATA_DIR=~/Documents/VMPC2000XL/Volumes
readonly NEW_DATA_PATH=$NEW_DATA_DIR/MPC2000XL

BK_UUID=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 6 | head -n 1)

[ -d $NEW_DATA_PATH ] && mv $NEW_DATA_PATH $NEW_DATA_PATH-$BK_UUID

mkdir -p $NEW_DATA_DIR

[ -d $OLD_DATA_PATH ] && cp -rp $OLD_DATA_PATH $NEW_DATA_DIR
