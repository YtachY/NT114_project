#!/bin/bash

TARGET_PATH=$1

echo "[+] Checking ${TARGET_PATH} if it could be debuggable..."
debuggable=$(aapt list -v -a ${TARGET_PATH} | grep debuggable)

if [ -n "$debuggable" ]; then
    echo "Debuggable"
else
    echo "Not found debuggable FLAG"
fi
