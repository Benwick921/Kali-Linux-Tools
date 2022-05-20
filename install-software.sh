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
echo -e "$RED It doesent check if it already exist! $NC"
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


echo -e "$YELLOW\0Include /snap/bin in /etc/evironment $NC"

echo -e "$YELLOW\0Installing discord $NC"
read var
snap install discord
echo -e "$YELLOW\0Installing whatsdesk (WhatsApp) $NC"
read var
snap install whatsdesk
echo -e "$YELLOW\0Installing Telegram $NC"
read var
snap install telegram-desktop


