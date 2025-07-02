#!/bin/bash

RED='\033[0;31m'
YELLOW='\033[1;33m'
LGREEN='\033[1;32m'
NC='\033[0m'

username="$1"

echo -e "${RED}Removing current compton.conf $NC"
rm /home/${username}/.config/compton.conf 2>/dev/null
echo -e "${LGREEN}Downloading compton config file $NC"
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/refs/heads/main/.config/compton.conf -P /home/${username}/.config/

echo -e "${RED}Removing current config $NC"
rm /home/${username}/.config/i3/config 2>/dev/null
echo -e "${LGREEN}Downloading i3 config file $NC"
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/main/.config/i3/config -P /home/${username}/.config/i3/
echo -e "${LGREEN}Injecting custom configs $NC"
echo "exec_always --no-startup-id /home/${username}/.config/polybar/launch.sh" >> /home/${username}/.config/i3/config
echo "exec_always feh --bg-scale /home/${username}/Downloads/w.jpg" >> /home/${username}/.config/i3/config

echo -e "${RED}Removing current config.ini $NC"
rm /home/${username}/.config/polybar/config.ini 2>/dev/null
echo -e "${LGREEN}Downloading compton polybar file $NC"
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/main/.config/polybar/config.ini -P /home/${username}/.config/polybar

echo -e "${RED}Removing current launch.sh $NC"
rm /home/${username}/.config/polybar/launch.sh 2>/dev/null
echo -e "${LGREEN}Downloading compton module launch.sh $NC"
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/main/.config/polybar/launch.sh -P /home/${username}/.config/polybar

echo -e "${RED}Removing current network.sh $NC"
rm /home/${username}/.config/polybar/network.sh 2>/dev/null
echo -e "${LGREEN}Downloading compton module network.sh $NC"
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/main/.config/polybar/network.sh -P /home/${username}/.config/polybar

echo -e "${RED}Removing current targetip.sh $NC"
rm /home/${username}/.config/polybar/targetip.sh 2>/dev/null
echo -e "${LGREEN}Downloading compton module targetip.sh $NC"
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/main/.config/polybar/targetip.sh -P /home/${username}/.config/polybar

echo -e "${RED}Removing target file $NC"
rm /home/${username}/.config/polybar/target 2>/dev/null
echo -e "${LGREEN}Recreating target file $NC"
echo "0.0.0.0" > /home/${username}/.config/polybar/target

echo
echo -e "${RED} !! =============================================================== !! $NC"
echo -e "${RED} !! Setting full permissions (777) to polybar modules bash scripts. !! $NC"
echo -e "${RED} !! But this is your PC right? Nothing to worrie about it right?    !! $NC"
echo -e "${RED} !! You are not installing it on critical or company devices right? !! $NC"
echo -e "${RED} !! ============================  ծ_Ô  ============================ !! $NC"
chmod 777 /home/${username}/.config/polybar/*
