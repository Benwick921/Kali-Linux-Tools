#!/bin/bash

RED='\033[0;31m'
YELLOW='\033[1;33m'
LGREEN='\033[1;32m'
NC='\033[0m'

interactive=0
all=0
username="$2"

if [[ "$1" == "-h" || "$1" == "" ]]; then
	echo "RUN AS"
	echo "./install-desktop-environment.sh [options] [username]"
 	echo ""
	echo "DESCRIPTION" 
	echo -e "\t-i\tInteractive installation"
	echo -e "\t-a\tInstall all without asking confirmation"
	echo ""
	echo "PROGRAMS"
	echo -e "\ti3-gaps\t\tTiled window manager"
	echo -e "\tFeh\t\tDesktop backgound"
	echo -e "\tCompton\t\tTerminal transparency"
	echo -e "\tDmenu\t\tPrograms launcher menu"
	echo -e "\tPolybar\t\tTaskbar"
	exit
fi
# Check for root-------------------------------------------------------------
if [ "$EUID" -ne 0 ]
  then echo -e "$RED Please run as root $NC"
  exit
fi
# check-if-user-exist------------------------------------------------------
testuser=$(grep -c "^$username:" /etc/passwd)
if [ ${testuser} -eq 0 ]
	then echo -e "${RED}User ${username} does not exist $NC"
	exit
	else echo -e "${LGREEN}User ${username} does exist $NC"
fi
# Check command line arguments-----------------------------------------------
if [ "$1" == "-a" ]; then
	all=1
else 
	if [ "$1" == "-i" ]; then
		interactive=1
	fi
fi

# Updates--------------------------------------------------------------------
if [ $interactive == 1 ]; then
	echo -en "${YELLOW}Do you wanto to update? (y/n) $NC"
	read confirm
fi
if [[ $confirm == "y" || $confirm == "yes" || $confirm == "Yes" || $all == 1 ]]; then
	apt update -y
fi
# disabling system bip------------------------------------------------------
if [ $interactive == 1 ]; then
	echo -en "${YELLOW}Do you wanto to disable system bip? (y/n) $NC"
	read confirm
fi
if [[ $confirm == "y" || $confirm == "yes" || $confirm == "Yes" || $all == 1 ]]; then
sudo -u ${username} bash <<'EOF'
xset b off
EOF
fi




# i3-gaps-------------------------------------------------------------
if [ $interactive == 1 ]; then
	echo -en "${YELLOW}Do you want to install i3-gaps? (y/n) $NC"
	read confirm
fi
if [[ $confirm == "y" || $confirm == "yes" || $confirm == "Yes" || $all == 1 ]]; then
	#echo -e "${LGREEN}Adding repository ppa:regolith-linux/release $NC"
	#sudo add-apt-repository ppa:regolith-linux/release

	echo -e "${LGREEN}Installing i3-gaps $NC"
	sudo apt install i3-wm -y

	echo -e "${LGREEN}Creating config folder .config/i3 $NC"
	mkdir -p /home/${username}/.config/i3
	chown $username /home/${username}/.config/i3

	echo -e "${LGREEN}Coping i3 config file from github (github.com/benwick921/i3gapstutorial) $NC"
	
	echo -e "${LGREEN}Cleaning i3 config folder $NC"
	rm /home/${username}/.config/i3/*
	
	echo -e "${LGREEN}Downloading Kali Linux configuration $NC"
	wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/main/.config/i3/config -P /home/${username}/.config/i3/

	echo -e "${LGREEN}Renaming config file $NC"
	mv /home/${username}/.config/i3/* /home/${username}/.config/i3/config
	chown $username /home/${username}/.config/i3/
fi
echo -e "${LGREEN}Injecting custom setting for current user"
echo "exec_always --no-startup-id /home/${username}/.config/polybar/launch.sh" >> /home/${username}/.config/i3/config
echo "exec_always feh --bg-scale /home/${username}/Downloads/w.jpg" >> /home/${username}/.config/i3/config

# feh(background dependecy)-------------------------------------------
if [ $interactive == 1 ]; then
	echo -en "${LGREEN}Do you want to install feh to have a desktop background? (y/n) $NC"
	read confirm
fi
if [[ $confirm == "y" || $confirm == "yes" || $confirm == "Yes" || $all == 1 ]]; then
	echo -e "${LGREEN}Installing feh for background $NC"
	apt install feh -y
fi

# compton(terminal transparency dependency)---------------------------------------------------
echo -e "${LGREEN}Installing compton for terminal trasparency $NC"
apt install compton -y
echo -en "${LGREEN}Copying Compton config file $NC"
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/refs/heads/main/.config/compton.conf -P /home/${username}/.config/
chown $username

# dmenu(alt+d start menu dependecy)-----------------------------------------------------
echo -e "${LGREEN}Installing dmenu for the menu $NC"
apt install dmenu -y

# polybar(dependency)--------------------------------------------------
echo -e "${LGREEN}Installing polybar $NC"
apt install polybar -y

echo -e "${LGREEN}Creating polybar configuration folder $NC"
mkdir /home/${username}/.config/polybar

echo -e "${LGREEN}Cleaning polybar config folder $NC"
rm /home/${username}/.config/polybar/*

echo -e "${GREEN}Copying polybar configuration files $NC"
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/main/.config/polybar/config.ini -P /home/${username}/.config/polybar
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/main/.config/polybar/launch.sh -P /home/${username}/.config/polybar
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/main/.config/polybar/network.sh -P /home/${username}/.config/polybar
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/main/.config/polybar/targetip.sh -P /home/${username}/.config/polybar
echo "0.0.0.0" > /home/${username}/.config/polybar/target

echo -e "${RED} !! Setting full permissions (777) to polybar modules bash scripts!! $NC"
echo -e "${RED} !! Buti this is your PC right? Nothing to worrie about it right? !! $NC"
echo -e "${RED} !! You are not installing it on critical or company devices right? !! $NC"
echo -e "${RED} !! ծ_Ô !! $NC"
chmod 777 /home/${username}/.config/polybar/*


# Donwload session management scripts and create folders----------------
mkdir /opt/isession
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/refs/heads/main/opt/isession/loader.sh -P /opt/isession/
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/refs/heads/main/opt/isession/session_management.sh -P /opt/isession/

chown $username:$username /opt/isession/loader.sh
chown $username:$username /opt/isession/session_management.sh

# download-target-script-------------------------------------------------------------------
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/refs/heads/main/usr/bin/target -P /usr/bin/
sudo chmod 777 /usr/bin/target
echo -e "${LGREEN}Check .config/i3/config if the paths contains your username at the end of the file $NC"

# download-background-image----------------------------------------------------------------
sudo -u "${username}" bash << EOF
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/refs/heads/main/Downloads/w.jpg -P /home/${username}/Downloads/
chown $username:$username /home/${username}/Downloads/w.jpg
EOF

# Update .bashrc-----------------------------------------------------------
echo -e "${GREEN}Renaming .bashrc to .bashrc_old $NC"
sudo -u "${username}" bash << EOF
mv /home/${username}/.bashrc /home/${username}/.bashrc_old
EOF

echo -e "${GREEN}Downloading a better .bashrc $NC"
sudo -u "${username}" bash << EOF
wget https://raw.githubusercontent.com/Benwick921/Kali-Linux-Tools/main/.bashrc -P /home/${username}/
chown $username:$username home/${username}/.bashrc
EOF

# IMPORTANT: I need to drop the privilege for the running user to be able to set the bash terminal!
echo -e "${LGREEN}Dropping the sudo privilege $NC"
sudo -u "${username}" bash << EOF
echo -e "${YELLOW}Running as $(whoami) $NC"
# Change Shell to Bash ------------------------------------------------------------------
chsh -s /usr/bin/bash

# Install fonts --------------------------------------------------------------------
echo -e "${YELLOW}Installing NerdFont for icons"
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.zip -P /tmp
unzip /tmp/NerdFontsSymbolsOnly.zip -d ~/.local/share/fonts/
fc-cache -fv
EOF

echo -e "Please run 'chsh -s /usr/bin/bash'"

echo -e "${YELLOW}Please reboot your system... $NC"


