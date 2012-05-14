#!/bin/bash
# wolf.halton@lyrasis.org
echo "Welcome to the Nagios Server-template filler, $USER" 
echo "   ^v----------------------------------------v^"
if [ "$1" ]
then
	#echo " there are 2 arguments to this script"
	moo=`echo $1 | awk -F"\." '  $1 <=255 && $2 <= 255 && $3 <= 255 && $4 <= 255 '`

	if [[ $1 = $moo ]]
	then
		echo "The IP address supplied, $1, was valid."
		echo "^v----------------------------------------v^"
		echo "$2 is the server hostname provided.  Is it correct?"
		echo "Enter 'y' or 'Y' if correct to complete mission."
		echo "Enter 'n' or 'N' if not correct to abort mission."
		read answer
		if [[ $answer = "n" ]] || [[ $answer = "N" ]]
		then 
			echo ""
			echo "Try again"
			echo ""
		else
			if [[ $answer = "y" ]] || [[ $answer = "Y" ]]
			then
				NewIP=$1
				NewHost=$2
			echo "Now set the server-group for this server"
			echo "Enter the number of the server-group and the"
			echo "Group will be added to the template you are building."
			echo "_____________________________________________________________"
			echo ""
			echo "Linux DSPACE Servers 	  <linux-dspace-servers>	01 "
			echo "Linux Evergreen Servers 	<linux-evergreen-servers>	02 "
			echo "Linux FTP Servers 		 <linux-ftp-servers>	03 "
			echo "Linux LTS Infrastructure Servers <linux-infra-servers>	04 "
			echo "Linux PostgreSQL Servers 	   <linux-pgsql-servers>	05 "
			echo "Linux Remote Servers 	  <linux-remote-servers>	06 "
			echo "Linux Storage Servers 	 <linux-storage-servers>	07 "
			echo "Linux Web Servers 		<linux-http-servers>	08 "
			echo "_____________________________________________________________"
			echo ""
			read choice
			case $choice in
				'01')
					NewGroup="linux-dspace-servers"
					NewAlias="Linux DSPACE Servers"
					;;
				'02')
					NewGroup="linux-evergreen-servers"
					NewAlias="Linux Evergreen Servers"
					;;
				'03')
					NewGroup="linux-ftp-servers"
					NewAlias="Linux FTP Servers"
					;;
				'04')
					NewGroup="linux-infra-servers"
					NewAlias="Linux LTS Infrastructure Servers"
					;;
				'05')
					NewGroup="linux-pgsql-servers"
					NewAlias="Linux PostgreSQL Servers"
					;;
				'06')
					NewGroup="linux-remote-servers"
					NewAlias="Linux Remote Servers"
					;;
				'07')
					NewGroup="linux-storage-servers"
					NewAlias="Linux Storage Servers"
					;;
				'08')
					NewGroup="linux-http-servers"
					NewAlias="Linux (Apache) Web Servers"
					;;
			esac
			
			sed -e "s/TEMPLATE-IP/$NewIP/g" -e "s/TEMPLATE-HOSTNAME/$NewHost/g"  -e "s/TEMPLATE-HOSTGROUP/$NewGroup/g" -e "s/TEMPLATE-ALIAS/$NewAlias/g" nagios-linux-server-template.cfg > $2.cfg
			echo ""
			echo "Your Customized Nagios Server template, $NewHost.cfg, has been created"; echo ""
			cp $2.cfg /usr/local/nagios/etc/servers/

			fi
		fi
	else
		echo "That is not a valid IP Address"
		echo ""
		echo "Try again"
		echo ""
		
	fi
else	
	echo "To use this script, type the ip address and the hostname of your new server after the script name"
	echo "For example: ./nagios-template-filler.sh 192.168.45.65 Super-Server"
	echo "You do not need to use commas between these elements but there must be spaces between them, and the system is case-sensitive, so please type your server's name exactly how you named it"
fi
echo "______________________________________"
echo "next the system will sanity-check your" 
echo "nagios config to make sure there are "
echo "no errors."
sleep 3
/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
