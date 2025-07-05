#!/bin/bash

RED='\033[0;31m'
YELLOW='\033[1;33m'
LGREEN='\033[1;32m'
LBLUE='\033[1;34m'
NC='\033[0m'

username="$1"

echo -e "${RED}Deleting already existant ghost suggestion file $NC"
rm /home/$username/live-suggester.sh

# Donwload session management scripts and create folders----------------
echo -e "${LGREEN}Downloading ghost suggestion module $NC"
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/refs/heads/main/live-suggester.sh -P /home/$username/
chmod +x /home/$username/live-suggester.sh

echo -e "${LGREEN}Injecting config in .bashrc for current user$NC"
echo "source ~/live-suggester.sh" >> /home/$username/.bashrc
