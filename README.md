Nagios-Template-filler
======================

This script automates the construction of server templates for Nagios

To use this, 
shell into your nagios server 
su - nagios
append /home/.ssh/id_rsa.pub to nagios@remoteserver.com:/home/nagios/.ssh/authorized_keys
so the nagios server can log into the remote server without you having to enter a password.

For installing plugins
http://sourcefreedom.com/nagios-plugins-1-4-16-installation-notes/
http://sourcefreedom.com/nagios-monitor-remote-disk-free-space/

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

This script automatically puts a copy of the server.cfg file in /usr/local/nagios/etc/servers/ 
folder, so you may need to add that folder

You will need a plugin added to your remote server's plugin folder /usr/local/nagios/libexec/
check_diskfree2.sh which is in this repository.  It works with any disk partition by name, 
 i.e. '/var' rather than needing the partition number.

This will break if you do not have these server-types defined in your configuration files.
The specifics of how to configure the server definitions are a little beyond the scope of this document.


