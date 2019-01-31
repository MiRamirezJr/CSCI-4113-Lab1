#!/bin/sh

#Mario Ramirez
#CSCI 4113 Lab 1 Monitor Script

#variable to hold the utilization percentage of / and /boot filesystem
home=$(df | grep -w '/' | awk '{print $5}' | sed 's/[^0-9]*//g')

boot=$(df | grep -w '/boot' | awk '{print $5}' | sed 's/[^0-9]*//g')

#check if both filesystems utilization grater then 80 or if only one of them is
#then sends emial to root through mailx
if [ $home -gt 80 ] && [ $boot -gt 80 ]; then
	echo "the / and /boot filesystems have exceeded 80% threshold at $home% and $boot%, respectively, utilization" | mailx -s "filesystem utilization" root
elif [ $home -gt 80 ]; then
	echo "the / filesystem has exceeded 80% threshold at $home% utilization" | mailx -s "filesystem utilization" root
elif [ $boot -gt 80 ]; then
	echo "the /boot filesystem has exceeded 80% threshold at $boot% utilization" | mailx -s "filesystem utilization" root
#this is to test mailx is working correctly if utilization is not above 80% for either filesystem
#uncomment to send test email when utilization is below threshold
#else
#	echo "utilization is fine" | mailx -s "filesystem utilization" root
fi
