#!/usr/bin/bash

while true; do
	TUN0=$(ip a | grep tun0 | tail -n 1 | awk '{print $2}' | cut -d '/' -f 1)
	ETH0=$(ip a | grep eth0 | tail -n 1 | awk '{print $2}' | cut -d '/' -f 1)

	if [[ -z $TUN0 ]]; then
		echo "$ETH0"
	else
		echo "$TUN0"
	fi
	sleep 5
done

