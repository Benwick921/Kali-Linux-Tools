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

# Add Kali repo---------------------------------------------------------------
echo -e "$YELLOW Adding Kali-Linux repo $NC"
if grep --quiet https://http.kali.org/kali /etc/apt/sources.list;
then
    echo -e "$LGREEN\0Repo already exit, not adding. $NC"
else
    echo "deb https://http.kali.org/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list
fi

# Install snap package manager------------------------------------------------
echo -e "$YELLOW\0Installing snap $NC"
apt install snap -y

echo -e "$YELLOW\0Installing snapd $NC"
apt install snapd -y

echo -e "$YELLOW\0Installing snap core $NC"
snap install core --classic

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

echo -e "$YELLOW\0Installing discord $NC"
snap install discord --classic

echo -e "$YELLOW\0Installing whatsdesk (WhatsApp) $NC"
snap install whatsdesk --classic

echo -e "$YELLOW\0Installing Telegram $NC"
snap install telegram-desktop --classic

echo -e "$YELLOW\0Installing git $NC"
apt install git -y

echo -e "$RED\0REBOOTING SYSTEM!"
sudo reboot




