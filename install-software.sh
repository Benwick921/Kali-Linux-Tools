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
read var
if grep --quiet https://http.kali.org/kali /etc/apt/sources.list;
then
    echo -e "$LGREEN\0Repo already exit, not adding. $NC"
else
    echo "deb https://http.kali.org/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list
fi

echo -e "$YELLOW\0Installing git $NC"
read var
apt install git -y

echo -e "$YELLOW\0Installing snap $NC"
read var
apt install snap -y

echo -e "$YELLOW\0Installing snapd $NC"
read var
apt install snapd -y

echo -e "$YELLOW\0Installing snap core $NC"
read var
snap install core


echo -e "$YELLOW\0Includeing /snap/bin path in ~/.profile $NC"
if grep --quiet /snap/bin ~/.profile ; then
	echo -e "$GREEN\0Path already present. $NC"
else
	echo " " >> ~/.profile
	echo "# set PATH so it includes nap bin if it exists" >> ~/.profile
	echo "if [ -d \"/snap/bin\" ] ; then" >> ~/.profile
	echo -e "\t PATH=\"/snap/bin\"" >> ~/.profile
	echo "fi" >> ~/.profile
fi 

echo -e "$YELLOW\0Installing discord $NC"
read var
snap install discord
echo -e "$YELLOW\0Installing whatsdesk (WhatsApp) $NC"
read var
snap install whatsdesk
echo -e "$YELLOW\0Installing Telegram $NC"
read var
snap install telegram-desktop




