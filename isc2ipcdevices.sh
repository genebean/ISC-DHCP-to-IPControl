#!/usr/bin/awk -f
# 
# Author: GeneBean
#
# The original version of this script was written by 
# Matt Pascoe - matt@opennetadmin.com  and was for a different use.
#
# This awk script is used to extract relavant information from a dhcpd.conf
# config file and build a csv with appropriate fields for importing into
# IPControl.  As usual, inspect the output for accuracy.
#
#
# USAGE:
# make this script executable with `chmod +x isc2ipcdevices.sh` and then
#
#   cat dhcpd.conf|./isc2ipcdevices.sh
 
# set the RECORD SEPARATOR, RS, to "}" ... records span multiple lines
BEGIN {RS="}"}

length($0) > 18 { total++
 
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
      # Replace _ with -
      gsub(/_/,"-", hostname[total])
    }
 
    # if this field matches the word "hardware"
    else if($i ~ /^hardware$/) {
 
      # get rid of the trailing semi-colon
      split($(i+2),arr,";")
 
      mac[total]=tolower(arr[1])
    }
 
    # if this field matches the word "fixed-address"
    else if($i ~ /^fixed-address$/) {
 
      # get rid of the trailing semi-colon
      split($(i+1),arr,";")
 
      ip[total]=arr[1]
    }
  }

  if( length(hostname[total]) > 0 ) {  
    addressType[total] = "Manual DHCP"
    deviceType[total] = "Unspecified"
    hwType[total] = "ethernet"
    resourceRecordFlag[total] = "FALSE"
    domainName[total] = ""
    container[total] = ""
    domainTyp[total] = "Default"
    description[total] = ""
    userDefinedFields[total] = ""
    aliases[total] = ""
    dupWarning[total] = ""
    interfaces[total] = "Default"
    excludeFromDiscovery[total] = "FALSE"
    virtual[total] = "FALSE"
    DUID[total] = ""
  }
 
}
 
END { 
      # print the csv header
      print "^ipaddress,addressType,hostname,deviceType,hwType,MACAddress,resourceRecordFlag,domainName,container,domainTyp,description,userDefinedFields,aliases,dupWarning,interfaces,excludeFromDiscovery,virtual,DUID"

      # for every entry we captured, display its appropriate info
      for(entry in counter) {
         if(type[entry] == "host") {
             printf("%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,\n",\
                 ip[entry],addressType[entry],hostname[entry],deviceType[entry],hwType[entry],mac[entry],resourceRecordFlag[entry],domainName[entry],container[entry],domainTyp[entry],description[entry],userDefinedFields[entry],aliases[entry],dupWarning[entry],interfaces[entry],excludeFromDiscovery[entry],virtual[entry],DUID[entry])
         }
    }
}
