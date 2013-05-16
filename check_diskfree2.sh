#!/bin/bash
# 
# Plugin to check free disk space
# using check_by_ssh
# by Markus Walther (voltshock@gmx.de)
#   small contribution by Wolf Halton <wolf@sourcefreedom.com> to get it to look for directories rather than disk partitions
# The script needs a working check_by_ssh connection and needs to run on the client to check it
# 
# Command-Line for check_by_ssh
# command_line    $USER1$/check_by_ssh -H $HOSTNAME$ -p $ARG1$ -C "$ARG2$ $ARG3$ $ARG4$ $ARG5$ $ARG6$"
# 
# Command-Line for service (example)
# check_by_ssh!82!/nagios/check_diskfree2.sh!hda1!75!90
#
##########################################################

case $1 in
  --help | -h )
         echo "Usage: check_diskfree [path_to_mount_point] [warn] [crit]"
         echo " [warn] and [crit] as int"
         echo " Example: check_diskfree hda1 70 90"
         exit 3
         ;;
  * )
    ;;
esac

if [ ! "$1" -o ! "$2" -o ! "$3" ]; then
        echo "Usage: check_diskfree [dev] [warn] [crit]"
        echo " [warn] and [crit] as int"
        echo " Example: check_diskfree hda1 70 90"
        echo "Unknown: Options missing"
        exit 3
fi

used=`df $1 | tail -n1 | sed -r 's/\ +/\ /g' | cut -d \  -f3`
free=`df $1 | tail -n1 | sed -r 's/\ +/\ /g' | cut -d \  -f4`
full=`echo $(($used+$free))`
percent=`echo $((( $free * 100 ) / $full))`
warn=`echo $((( $full * $2 ) / 100 ))`
crit=`echo $((( $full * $3 ) / 100 ))`

if [ "$warn" -gt "$crit" -o "$warn" -eq "$crit" ]; then
   echo "Unknown: [crit] must be larger than [warn]"
        exit 3
fi

if [ "$used" -lt "$warn" -o "$used" -eq "$warn" ]; then
        echo "OK. Free Space: `df -h $1 | tail -n1 | sed -r 's/\ +/\ /g' | cut -d \  -f4`B, $percent%"
        exit 0
 elif [ "$used" -gt "$warn" -a "$used" -lt "$crit" ]; then
        echo "Warning. Free Space: `df -h $1 | tail -n1 | sed -r 's/\ +/\ /g' | cut -d \  -f4`B, $percent%"
        exit 1
 elif [ "$used" -gt "$crit" ]; then
        echo "Critical. Free Space: `df -h $1 | tail -n1 | sed -r 's/\ +/\ /g' | cut -d \  -f4`B, $percent%"
        exit 2
 else
   echo "Unknown"
   exit 3
fi
