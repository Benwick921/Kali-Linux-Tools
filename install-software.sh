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
  then echo -e "$RED Please run as root $NC"
  exit
fi
pt isntall git
apt install snap
snap install core

echo -e "$YELLOW Include /snap/bin in /etc/evironment $NC"

snap install discord
snap install whatsdesk
snap install telegram-desktop


