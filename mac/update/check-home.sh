#!/bin/sh
readonly TO_CHECK=$1

[ -d ~/$TO_CHECK ] && exit 0 || [ -f ~/$TO_CHECK ] && exit 0 || exit 1