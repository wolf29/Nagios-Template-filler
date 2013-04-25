Nagios-Template-filler
======================

This script automates the construction of server templates for Nagios

To use this, 
shell into your nagios server 
su - nagios
append nagios@remoteserver.com:/home/.ssh/id_rsa.pub to ~/.ssh/authorized_keys
cd bin
nagios-template-filler_1.0.sh 192.168.1.123 remoteserver.com

This will then tell you if the ip address is valid and check name and IP for you to approve
if you don't approve type "n" and if it is ok, type "y"

Then it asks for your use-case.

Now set the server-group for this server
Enter the number of the server-group and the
Group will be added to the template you are building.
_____________________________________________________________
""
Linux DSPACE Servers <linux-dspace-servers> 01 
Linux Evergreen Servers <linux-evergreen-servers> 02 
Linux FTP Servers <linux-ftp-servers> 03 
Linux LTS Infrastructure Servers <linux-infra-servers> 04 
Linux PostgreSQL Servers <linux-pgsql-servers> 05 
Linux Remote Servers <linux-remote-servers> 06 
Linux Storage Servers <linux-storage-servers> 07 
Linux Web Servers <linux-http-servers> 08 
_____________________________________________________________
""
This will break if you do not have these server-types defined in your configuration files.
The specifics of how to configure the server definitions are a little beyond the scope of this document.


