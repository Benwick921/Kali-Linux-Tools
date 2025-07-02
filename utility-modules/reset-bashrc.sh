#!/bin/bash

RED='\033[0;31m'
YELLOW='\033[1;33m'
LGREEN='\033[1;32m'
NC='\033[0m'

username="$1"

echo -e "${RED}Removing current .bashrc $NC"
rm /home/${username}/.bashrc 2>/dev/null
echo -e "${LGREEN}Downloading default bash config $NC"
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/main/.bashrc -P /home/${username}/
