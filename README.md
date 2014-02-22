ISC DHCP to IPControl
=====================

ISC DHCP to IPControl is desinged to take info from one or more ISC DHCP files
and convert the contents into the CSV format that IPControl by BT Diamond expects.  
By default, this script outputs the data to the console. Once you are satisfied with 
the output then just pipe it to a file and then either use the Import Wizzard or one 
of the CLI tools to populate the updates into your IPControl system.

The primary home for this code is the public area of https://code.westga.edu/gitlab but 
is also available on [GitHub](https://github.com/genebean/ISC-DHCP-to-IPControl) so that 
others can easily find it and, hopefully, use and improve it.

Version
----

0.1

Installation & Usage
--------------------

```sh
git clone [git-repo-url] isc-dhcp-to-ipcontrol
cd isc-dhcp-to-ipcontrol
chmod +x converter.sh
chmod +x isc2ipcdevices.sh
./converter.sh "/etc/dhcp/dhcpd.conf"
```

License
----

This software is released under a BSD 3-clause licence which is detailed in 
the included LICENSE file.
