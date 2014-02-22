#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "To use this script just pass the path to your dhcpd.conf file"
    echo "or files as an argument wrapped in quotes"
    echo "Ex: ./converter.sh \"/etc/dhcp/1*\""
else
    input=$1
    cat $input |./isc2ipcdevices.sh |sort -t . -k 1,1n -k 2,2n -k 3,3n -k 4,4n 
fi
