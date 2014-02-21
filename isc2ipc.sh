#!/usr/bin/awk -f
# 
# Author: Matt Pascoe - matt@opennetadmin.com 
#
# This awk script is used to extract relavant information from a dhcpd.conf
# config file and build a csv with appropriate fields for passing into
# a dcm.pl module.  This can be used to bootstrap a new database from existing
# site data.  As usual, inspect the output for accuracy.
 
# Note that for hosts, it will try a reverse lookup on the IP address
# to determine an appropriate dns name
#
# USAGE:
# make this script executable with `chmod +x dhcpparse.awk` and then
#
#   cat dhcpd.conf|./dhcpparse.awk
 
# set the RECORD SEPARATOR, RS, to "}" ... records span multiple lines
BEGIN {RS="}"}
 
# TODO: figure out how to skip comment lines without having to use sed first
 
length($0) > 5 { total++
 
  for(i=1;i<=NF;i++) {
 
    counter[total] = total
 
    # if this field matches the word "host"
    if($i ~ /^host$/) {
      type[total] = "host"
      hostname[total]=$(i+1)
      # Remove the trailing { that might be there
      gsub(/{/, "", hostname[total])
      # Replace . with -
      gsub(/\./,"-", hostname[total])
    }
 
    # if this field matches the word "hardware"
    else if($i ~ /^hardware$/) {
 
      # get rid of the trailing semi-colon
      split($(i+2),arr,";")
 
      mac[total]=arr[1]
    }
 
    # if this field matches the word "fixed-address"
    else if($i ~ /^fixed-address$/) {
 
      # get rid of the trailing semi-colon
      split($(i+1),arr,";")
 
      ip[total]=arr[1]
    }
  }
  
 
}
 
# for every entry we captured, display its appropriate info
END { for(entry in counter) {
         if(type[entry] == "host") {
             printf("%s,%s,%s,\n",\
                 ip[entry],mac[entry],hostname[entry])
         }
    }
}
