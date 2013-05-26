#!/usr/bin/env bash

FILE=$1
PREFIX=$2

TREE=$FILE
APPENDS=$(head -n25 $FILE | grep " * @append " | cut -d' ' -f4)
for APPEND in $APPENDS
do
    if [ -z $(echo "$TREE" | grep "$APPEND") ]; then
        TREE=$(printf "$TREE\n$PREFIX$APPEND")
    fi
done
echo "$TREE"
