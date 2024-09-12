#!/bin/bash

RED='\033[0;31m'
YELLOW='\033[1;33m'
LGREEN='\033[1;32m'
NC='\033[0m'

interactive=0
all=0
username="$2"


# Check command line arguments-----------------------------------------------
if [ "$1" == "-a" ]; then
	all=1
else 
	if [ "$1" == "-i" ]; then
		interactive=1
	fi
fi

# Updates--------------------------------------------------------------------
if [ $interactive == 1 ]; then
	echo -en "${YELLOW}Do you wanto to update? (y/n) $NC"
	read confirm
fi
if [[ $confirm == "y" || $confirm == "yes" || $confirm == "Yes" || $all == 1 ]]; then
	apt update
fi

# Install Remmina-----------------------------------------------------------
if [ $interactive == 1 ]; then
	echo -en "${YELLOW}Do you want to install Remmina? (y/n) $NC"
	read confirm
fi
if [[ $confirm == "y" || $confirm == "yes" || $confirm == "Yes" || $all == 1 ]]; then 
	apt install remmina
fi

# Install pip3-------------------------------------------------------------
if [ $interactive == 1 ]; then
	echo -en "${YELLOW}DO you want to install pip3? (y/n) $NC"
	read confirm
fi
if [[ $confirm == "y" || $confirm == "yes" || $confirm == "Yes" || $all == 1 ]]; then
	apt install python3-pip
fi

# Install impacket--------------------------------------------------------
if [ $interactive == 1 ]; then
	echo -en "${YELLOW}Do you want to install impacket? (y/n) $NC"
	read confirm
fi
if [[ $confirm == "y" || $confirm == "yes" || $confirm == "Yes" || $all == 1 ]]; then
	echo -e "${LGREEN}Cloning repo... $NC"
	git clone https://github.com/SecureAuthCorp/impacket.git /opt/impacket
	echo -e "${LGREEN}Installing requerements... $NC"
	pip3 install -r /opt/impacket/requirements.txt
	echo -e "${LGREEN}Installing impacket... $NC"
	cd /opt/impacket/ && python3 ./setup.py install
fi

# Install bloodhound----------------------------------------------------
if [ $interactive == 1 ]; then
	echo -en "${YELLOW}Do you want to install bloodhound? (y/n) $NC"
	read confirm
fi
if [[ $confirm == "y" || $confirm == "yes" || $confirm == "Yes" || $all == 1 ]]; then
	apt install bloodhound
fi

# Install neo4j--------------------------------------------------------
if [ $interactive == 1 ]; then
	echo -en "${YELLOW}Do you wanto to install neo4j? (y/n) $NC"
	read confirm
fi
if [[ $confirm == "y" || $confirm == "yes" || $confirm == "Yes" || $all == 1 ]]; then
	apt install neo4j
fi
