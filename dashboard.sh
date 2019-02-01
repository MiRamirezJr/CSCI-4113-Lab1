#!/bin/bash

#Mario Ramirez
#CSCI 4113 Lab 1 System Display Script

#variables to grab various system states
freeRam=$(free -h | awk 'NR==2{print $4}' | sed 's/[^0-9]*//g')
loadAve=$(uptime | awk '{print $7" "$8" "$9" "$10" "$11}')
totUsrs=$(cat /etc/passwd | wc -l)
actUsrs=$(who | wc -l)
totShells=$(cat /etc/passwd | awk -F ":" '{print $7}' | awk '{for(i = 1; i <= NF; i++) {a[$i":"]++}} END {for(k in a) {print k, a[k]}}')
totFiles=$(find ~ -type f | wc -l)
totDir=$(find ~ -type d | wc -l)
enpTran=$(awk -v OFS=, '/enp0s3:/ { print $10 }' /proc/net/dev)
enpRec=$(awk -v OFS=, '/enp0s3:/ { print $2 }' /proc/net/dev)
loTran=$(awk -v OFS=, '/lo:/ { print $10 }' /proc/net/dev)
loRec=$(awk -v OFS=, '/lo:/ { print $2 }' /proc/net/dev)

printf "CPU AND MEMORY RESOURCES: \n"
printf "CPU $loadAve   Free RAM: $freeRam MB\n\n"

printf "NETWORK CONNECTIONS: \n"
printf "lo Bytes Recieved: $loRec   Bytes Transmitted: $loTran\n"
printf "enp0s3 Bytes Recieved: $enpRec   Bytes Transmitted: $enpTran\n"
#check internet connection
wget -q --spider http://google.com
if [ $? -eq 0 ]; then
	printf "Internet Connectivity: Yes\n\n"
else
	printf "Internet Connectivity: No\n\n"
fi

printf "ACCOUNT INFORMATION: \n"
printf "Total Users: $totUsrs   Number Active: $actUsrs\n"
printf "Shells: \n$totShells\n\n"

printf "FILESYSTEM INFORMATION: \n"
printf "Total Number of Files: $totFiles\nTotal Number of Directories: $totDir\n"
