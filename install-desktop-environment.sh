#!/bin/bash

RED='\033[0;31m'
YELLOW='\033[1;33m'
LGREEN='\033[1;32m'
NC='\033[0m'

interactive=0
all=0
username="$2"

if [[ "$1" == "-h" || "$1" == "" ]]; then
	echo "DESCRIPTION" 
	echo -e "\t-i\tInteractive installation"
	echo -e "\t-a\tInstall all without asking confirmation"
	echo ""
	echo "PROGRAMS"
	echo -e "\tRemmina\t\tRemote desktop for Linux"
	echo -e "\tPip3\t\tPython3 library installer"
	echo -e "\tImpacket\tCollection of python scripts"
	echo -e "\tBloodhound\tFor Active Directory"
	echo -e "\tNeo4j\t\tNeed for BloodHound"
	echo -e "\ti3-gaps\t\tTiled window manager"
	exit
fi

# disabling system bip------------------------------------------------------
xset b off

# Check for root-------------------------------------------------------------
if [ "$EUID" -ne 0 ]
  then echo -e "$RED Please run as root $NC"
  exit
fi

# Check command line arguments-----------------------------------------------
if [ "$1" == "-a" ]; then
	all=1
else 
	if [ "$1" == "-i" ]; then
		interactive=1
	fi
fi
# Check username------------------------------------------------------------
echo "$2"


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

# i3-gaps-------------------------------------------------------------
if [ $interactive == 1 ]; then
	echo -en "${YELLOW}Do you want to install i3-gaps? (y/n) $NC"
	read confirm
fi
if [[ $confirm == "y" || $confirm == "yes" || $confirm == "Yes" || $all == 1 ]]; then
	#echo -e "${GREEN} Adding repository ppa:regolith-linux/release $NC"
	#sudo add-apt-repository ppa:regolith-linux/release

	echo -e "${GREEN}Installing i3-gaps $NC"
	sudo apt install i3-wm

	echo -e "${GREEN}Creating config folder .config/i3 $NC"
	mkdir -p /home/${username}/.config/i3

	echo -e "${GREEN}Coping i3 config file from github (github.com/benwick921/i3gapstutorial)"

	echo -e "${GREEN}Downloading Kali Linux configuration $NC"
	wget https://raw.githubusercontent.com/Benwick921/i3gapstutorial/master/i3/config-kali -P /home/${username}/.config/i3/
	fi

	#echo "${GREEN}Removing old config file $NC"
	#rm /home/${username}/.config/i3/*

	echo "${GREEN}Renaming config file $NC"
	mv /home/${username}/.config/i3/* config
fi

# feh(background dependecy)-------------------------------------------
echo -e "${GREEN}Installing feh for background
apt install feh

# compton(dependency)---------------------------------------------------
echo -e "${GREEN}Installing compton for terminal trasparency
apt install compton

# dmenu(dependecy)-----------------------------------------------------
echo -e "${GREEN}Installing dmenu for the menu
apt install dmenu

# polybar(dependency)--------------------------------------------------
echo -e "${GREEN}Installing polybar
apt install polybar

echo -e "${GREEN}Creating polybar configuration folder
mkdir /home/${username}/.config/polybar

echo -e "${GREEN}Copying polybar configuration files
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/main/.config/polybar/config.ini -P /home/${username}/.config/polybar
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/main/.config/polybar/launch.sh -P /home/${username}/.config/polybar
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/main/.config/polybar/network.sh -P /home/${username}/.config/polybar
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/main/.config/polybar/targetip.sh -P /home/${username}/.config/polybar
echo "0.0.0.0" > /home/${username}/.config/polybar/target


# Set .bashrc-----------------------------------------------------------
if [ $interactive == 1 ]; then
	echo -en "${YELLOW}Do you want to change your .bashrc to look like Kali Linux? (y/n) $NC"
	read confirm
fi
if [[ $confirm == "y" || $confirm == "yes" || $confirm == "Yes" || $all == 1 ]]; then
	echo -e "${GREEN}Renaming .bashrc to .bashrc_old $NC"
	mv /home/${username}/.bashrc /home/${username}/.bashrc_old

	echo -e "${GREEN}Downloading a better bashrc $NC"
	wget
fi

# download-background-image----------------------------------------------------------------
