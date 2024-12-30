#!/bin/bash

RED='\033[0;31m'
YELLOW='\033[1;33m'
LGREEN='\033[1;32m'
NC='\033[0m'

interactive=0
all=0
username="$2"

if [[ "$1" == "-h" || "$1" == "" ]]; then
	echo "./install-desktop-environment.sh [username] [option]"
	echo "DESCRIPTION" 
	echo -e "\t-i\tInteractive installation"
	echo -e "\t-a\tInstall all without asking confirmation"
	echo ""
	echo "PROGRAMS"
	echo -e "\ti3-gaps\t\tTiled window manager"
	echo -e "\tFeh\t\tDesktop backgound"
	echo -e "\tCompton\t\tTerminal transparency"
	echo -e "\tDmenu\t\tPrograms launcher menu"
	echo -e "\tPolybar\t\tTaskbar"
	exit
fi
# Check for root-------------------------------------------------------------
if [ "$EUID" -ne 0 ]
  then echo -e "$RED Please run as root $NC"
  exit
fi
# check-if-user-exist------------------------------------------------------
testuser=$(grep -c "^$username:" /etc/passwd)
if [ ${testuser} -eq 0 ]
	then echo -e "${RED}User ${username} does not exist $NC"
	exit
	else echo -e "${LGREEN}User ${username} does exist $NC"
fi
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
# disabling system bip------------------------------------------------------
if [ $interactive == 1 ]; then
	echo -en "${YELLOW}Do you wanto to disable system bip? (y/n) $NC"
	read confirm
fi
if [[ $confirm == "y" || $confirm == "yes" || $confirm == "Yes" || $all == 1 ]]; then
	xset b off
fi




# i3-gaps-------------------------------------------------------------
if [ $interactive == 1 ]; then
	echo -en "${YELLOW}Do you want to install i3-gaps? (y/n) $NC"
	read confirm
fi
if [[ $confirm == "y" || $confirm == "yes" || $confirm == "Yes" || $all == 1 ]]; then
	#echo -e "${LGREEN}Adding repository ppa:regolith-linux/release $NC"
	#sudo add-apt-repository ppa:regolith-linux/release

	echo -e "${LGREEN}Installing i3-gaps $NC"
	sudo apt install i3-wm

	echo -e "${LGREEN}Creating config folder .config/i3 $NC"
	mkdir -p /home/${username}/.config/i3

	echo -e "${LGREEN}Coping i3 config file from github (github.com/benwick921/i3gapstutorial) $NC"
	
	echo -e "${LGREEN}Cleaning i3 config folder $NC"
	rm /home/${username}/.config/i3/*
	echo -e "${LGREEN}Downloading Kali Linux configuration $NC"
	wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/main/.config/i3/config -P /home/${username}/.config/i3/

	echo -e "${LGREEN}Renaming config file $NC"
	mv /home/${username}/.config/i3/* /home/${username}/.config/i3/config
fi

# feh(background dependecy)-------------------------------------------
if [ $interactive == 1 ]; then
	echo -en "${YELLOW}Do you want to install feh to have a desktop background? (y/n) $NC"
	read confirm
fi
if [[ $confirm == "y" || $confirm == "yes" || $confirm == "Yes" || $all == 1 ]]; then
	echo -e "${LGREEN}Installing feh for background $NC"
	apt install feh
fi

# compton(terminal transparency dependency)---------------------------------------------------
echo -e "${LGREEN}Installing compton for terminal trasparency $NC"
apt install compton
echo -en "${LGREEN}Copying Compton config file $NC"
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/refs/heads/main/.config/compton.conf -P /home/${username}/.config/

# dmenu(alt+d start menu dependecy)-----------------------------------------------------
echo -e "${LGREEN}Installing dmenu for the menu $NC"
apt install dmenu

# polybar(dependency)--------------------------------------------------
echo -e "${LGREEN}Installing polybar $NC"
apt install polybar

echo -e "${LGREEN}Creating polybar configuration folder $NC"
mkdir /home/${username}/.config/polybar

echo -e "${LGREEN}Cleaning polybar config folder $NC"
rm /home/${username}/.config/polybar/*

echo -e "${GREEN}Copying polybar configuration files $NC"
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/main/.config/polybar/config.ini -P /home/${username}/.config/polybar
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/main/.config/polybar/launch.sh -P /home/${username}/.config/polybar
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/main/.config/polybar/network.sh -P /home/${username}/.config/polybar
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/main/.config/polybar/targetip.sh -P /home/${username}/.config/polybar
echo "0.0.0.0" > /home/${username}/.config/polybar/target
echo -e "${GREEN}Setting file permission to 777 $NC"
chmod 777 /home/${username}/.config/polybar/*



# Set .bashrc-----------------------------------------------------------
#if [ $interactive == 1 ]; then
#	echo -en "${YELLOW}Do you want to change your .bashrc to make it look cool? (y/n) $NC"
#	read confirm
#fi
#if [[ $confirm == "y" || $confirm == "yes" || $confirm == "Yes" || $all == 1 ]]; then
	echo -e "${GREEN}Renaming .bashrc to .bashrc_old $NC"
	mv /home/${username}/.bashrc /home/${username}/.bashrc_old

	echo -e "${GREEN}Downloading a better .bashrc $NC"
	wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/main/.bashrc -P /home/${username}/
#fi

# download-background-image----------------------------------------------------------------
