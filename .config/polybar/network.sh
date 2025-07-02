#!/usr/bin/bash

while true; do
	INT=$(ip link show | awk '{print $2}' | sed -n 'p;n' | sed 's/.$//' | tail -n+2)
	INT=$(echo $INT | awk '{print $1}' | head -n 1)
	echo $(ip a | grep $INT | tail -n 1 | awk '{print $2}' | cut -d '/' -f 1)
	sleep 5
done

