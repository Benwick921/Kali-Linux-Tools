#!/bin/bash

RED='\033[0;31m'
YELLOW='\033[1;33m'
LGREEN='\033[1;32m'
NC='\033[0m'

interactive=0
all=0
username=""


# Check for root-------------------------------------------------------------
if [ "$EUID" -ne 0 ]
  then echo -e "$RED\0Please run as root $NC"
  exit
fi
echo -e "$YELLOW Adding Kali-Linux repo $NC"

if grep --quiet https://http.kali.org/kali /etc/apt/sources.list;
then
    echo -e "$LGREEN\0Repo already exit, not adding. $NC"
else
    echo "deb https://http.kali.org/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list
fi

echo -e "$YELLOW\0Installing git $NC"
apt install git -y

echo -e "$YELLOW\0Installing snap $NC"
apt install snap -y

echo -e "$YELLOW\0Installing snapd $NC"
apt install snapd -y

echo -e "$YELLOW\0Installing snap core $NC"
snap install core


echo -e "$YELLOW\0Including /snap/bin path in ~/.profile $NC"
if grep --quiet /snap/bin ~/.profile ; then
	echo -e "$GREEN\0Path already present. $NC"
else
	echo " " >> ~/.profile
	echo "# set PATH so it includes snap bin if it exists" >> ~/.profile
	echo 'if [ -d "/snap/bin" ] ; then' >> ~/.profile
	echo '\t PATH="/snap/bin:$PATH"' >> ~/.profile
	echo "fi" >> ~/.profile
fi 

echo -e "$YELLOW\0Installing discord $NC"
snap install discord

echo -e "$YELLOW\0Installing whatsdesk (WhatsApp) $NC"
read var
snap install whatsdesk
echo -e "$YELLOW\0Installing Telegram $NC"
read var
snap install telegram-desktop
exit
echo -e "$RED\0REBOOTING THE SYSTEM!"
reboot




