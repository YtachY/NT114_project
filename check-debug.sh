#!/bin/bash

TARGET_PATH=$1

debuggable=$(aapt list -v -a ${TARGET_PATH} | grep debuggable)

if [ -n "$debuggable" ]; then
    echo "Debuggable"
fi
