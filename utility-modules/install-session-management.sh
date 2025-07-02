#!/bin/bash

RED='\033[0;31m'
YELLOW='\033[1;33m'
LGREEN='\033[1;32m'
LBLUE='\033[1;34m'
NC='\033[0m'

username="$1"

echo -e "${RED}Deleting already existant files and folder $NC"
rm -r /opt/isession/

# Donwload session management scripts and create folders----------------
echo -e "${LGREEN}Creating session folder $NC"
mkdir /opt/isession 2>/dev/null

echo -e "${LGREEN}Downloading session scripts$NC"
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/refs/heads/main/opt/isession/loader.sh -P /opt/isession/
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/refs/heads/main/opt/isession/session_management.sh -P /opt/isession/
