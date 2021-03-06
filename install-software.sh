#!/bin/bash

RED='\033[0;31m'
YELLOW='\033[1;33m'
LGREEN='\033[1;32m'
NC='\033[0m'

interactive=0
all=0
username="$1"


# Check username-------------------------------------------------------------
if [ "$username" == "" ] ; then
	echo "Usage"
	echo -e "\t./install-software.sh [username]"
	exit
fi

# Check for root-------------------------------------------------------------
if [ "$EUID" -ne 0 ]
  then echo -e "$RED\0Please run as root $NC"
  exit
fi

echo -e "$YELLOW\0Install wget$NC"
apt install wget -y

echo -e "$YELLOW\0Installing gnome-terminal$NC"
apt install gnome-terminal -y

echo -e "$YELLOW\0Installing htop$NC"
apt install htop -y

echo -e "$YELLOW\0Installing vim$NC"
apt install vim -y

echo -e "$YELLOW\0Installing google-chrome-stable$NC"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb
sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb

apt --fix-broken install -y

echo -e "$YELLOW\0Installing tuxguitar$NC"
apt install tuxguitar -y	

#echo -e "$YELOW\0Installing joplin$NC"
#wget -O joplin.sh https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh
#chmod +x joplin.sh
#./joplin.sh --allow-root

# Add Kali repo---------------------------------------------------------------
echo -e "$YELLOW\0Adding Kali-Linux repo $NC"
if grep --quiet https://http.kali.org/kali /etc/apt/sources.list;
then
    echo -e "$LGREEN\0Repo already exit, not adding. $NC"
else
    echo "deb https://http.kali.org/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list
    echo -e "$YELLOW\0Updating Kali public key ED444FF07D8D0BF6 $RED\0(not sure if the key is fixed)$NC"
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys ED444FF07D8D0BF6
fi
echo -e "$YELLOW\0Updating repository$NC"
apt update

# to remove duplicate
echo -e "$YELLOW\0Installing git $NC"
apt install git -y

echo -e "$YELLOW\0Installing i3-gaps"
# Installing i3-gaps------------------------------------------------------------
apt install i3-gaps -y

# Getconfig files---------------------------------------------------------------
if [ ! -d "/home/$username/.cofig/i3" ] ; then
	mkdir /home/$username/.config/i3
fi
wget https://raw.githubusercontent.com/Benwick921/i3gapstutorial/master/i3/config-kali -O /home/$username/.config/i3/config

# Install snap package manager------------------------------------------------
echo -e "$YELLOW\0Installing snap $NC"
apt install snap -y

echo -e "$YELLOW\0Installing snapd $NC"
apt install snapd -y

# Add snap to $PATH------------------------------------------------------------
echo -e "$YELLOW\0Including /snap/bin path in ~/.profile $NC"
PATH="/snap/bin:$PATH"
if grep --quiet /snap/bin /home/$username/.profile ; then
	echo -e "$GREEN\0Path already present. $NC"
else
	echo " " >> /home/$username/.profile
	echo "# set PATH so it includes snap bin if it exists" >> /home/$username/.profile
	echo 'if [ -d "/snap/bin" ] ; then' >> /home/$username/.profile
	echo -e '\t PATH="/snap/bin:$PATH"' >> /home/$username/.profile
	echo "fi" >> /home/$username/.profile
fi 

echo -e "$YELLOW\0Installing snap core $NC"
snap install core

echo -e "$YELLOW\0Installing discord $NC"
snap install discord

echo -e "$YELLOW\0Installing whatsdesk (WhatsApp) $NC"
snap install whatsdesk

echo -e "$YELLOW\0Installing Telegram $NC"
snap install telegram-desktop

echo -e "$YELLOW\0Installing git $NC"
apt install git -y

echo -e "$YELLOW\0Installing vscode"
snap install --classic code



echo -e "$RED\0REBOOTING SYSTEM!"
sleep 3
sudo reboot




