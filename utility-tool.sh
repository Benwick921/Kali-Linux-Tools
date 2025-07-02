#!/bin/bash

RED='\033[0;31m'
YELLOW='\033[1;33m'
LGREEN='\033[1;32m'
LBLUE='\033[1;34m'
NC='\033[0m'

username="$1"

# Check for root-------------------------------------------------------------
if [ "$EUID" -ne 0 ]
  then echo -e "${RED}Please run as root $NC"
  echo "sudo ./iutility-tools.sh username"
  exit
fi

# check-if-user-exist------------------------------------------------------
testuser=$(grep -c "^$username:" /etc/passwd)
if [ ${testuser} -eq 0 ]
	then 
		echo -e "${RED}User ${username} does not exist $NC"
		echo "sudo ./utility-tools.sh username"
		exit
	else echo -e "${LGREEN}User ${username} does exist $NC"
fi

echo -e "1 - Install desktop environment (default - automatic)"	
echo "2 - Reset/Import all config files (polybar + i3wm + compton)"
echo "3 - Install session (share variable between terminals)"
echo "4 - Reset .bashrc"
echo 

read -p "> " OPT
if [[ $OPT -eq 1 ]] then
	wget -qO- https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/refs/heads/main/install-desktop-environment.sh | bash -s -- -a ${username}
elif [[ $OPT -eq 2 ]] then
	wget -qO- https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/refs/heads/main/utility-modules/reset-configs.sh | bash -s -- $username
elif [[ $OPT -eq 3 ]] then
	echo 3
elif [[ $OPT -eq 4 ]] then
	wget -qO- https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/refs/heads/main/utility-modules/reset-bashrc.sh | bash -s -- $username1
fi
