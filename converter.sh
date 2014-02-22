#!/bin/bash

input=$1

cat $input |./isc2ipcdevices.sh |sort -t . -k 1,1n -k 2,2n -k 3,3n -k 4,4n 
