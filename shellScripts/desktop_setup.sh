#!/bin/bash
# Add option to say yes to everything, or only decide for categories rather than everything
clear
echo "MIKHA'S UBUNTU SETUP SCRIPT OVERVIEW"
echo "This script was created by MikhaD to do the following:"
echo ""
echo "1)  Update and upgrade repositories"
echo ""
echo "2)  Install git"
echo "3)  Install vim"
echo "4)  Install Visual Studio Code"
echo "5)  Install the Java JDK"
echo "6)  Replace firefox developer edition"
echo "7)  Replace python with python 3.8.2"
echo "8)  Install gnome-tweaks"
echo "    •  Install dash to panel"
echo "    •  Change the desktop theme to Yaru-dark"
echo "    •  Make icons less cartoon like"
echo "    •  Remove Home icon from desktop"
echo "    •  Remove Trash icon from desktop"
echo "    •  Move dock to bottom"
echo "    •  Add week numbers to the calendar"
echo "    •  Make dock icons smaller and closer together"
echo "    •  Show battery percentage"
echo ""
echo "9)  Set the taskbar to Files, Firefox, Terminal & VS Code"
echo "10) Make the terminal run on startup"
echo "11) Configure 2 workspaces (virtual desktops)"
echo "12) Add WIN+I as settings shortcut"
echo "13) Add WIN+E as file explorer shortcut"
echo "14) Change retain usage history to 30 days"
echo "15) Enable purge trash and temp files after 30 days"
echo "16) Change desktop background"
echo ""
read -p "Press ENTER to get started"

# 1
sudo apt-get update
sudo apt-get upgrade
clear
# 2
read -p "Install git [Y/n]: "
if [ ${REPLY:-y} = y ]
then
	sudo apt-get install git
	clear
	read -p "Enter your git user name (can be changed later with git config --global user.name <name>): "
	if [ ${REPLY:-/} != / ]
	then
		git config --global user.name $REPLY
	fi
	read -p "Enter your git email (can be changed later with git config --global user.email <email>): "
	if [ ${REPLY:-/} != / ]
	then
		git config --global user.email $REPLY
	fi
fi
clear
# 3
read -p "Install vim [Y/n]: "
if [ ${REPLY:-y} = y ]
then
	sudo apt-get install vim
fi
clear
# 4
read -p "Install Visual Studio Code [Y/n]: "
if [ ${REPLY:-y} = y ]
then
	sudo snap install code
	vscIn=true
else
	vscIn=false
fi
clear
# 5
read -p "Install Java Development Kit [Y/n]: "
if [ ${REPLY:-y} = y ]
then
	sudo apt-get install defualt-jdk
fi
clear
# 6
read -p "Install Firefox Dev Edition [Y/n]: "
if [ ${REPLY:-y} = y ]
then
	wget https://github.com/MikhaD/wget/raw/master/shellScripts/install_firefox_dev.sh
	sudo bash install_firefox_dev.sh
	ffIn=true
else
	ffIn=false
fi
clear
# 7
read -p "Install python 3.8.x [Y/n]: "
if [ ${REPLY:-y} = y ]
then
	wget https://github.com/MikhaD/wget/raw/master/shellScripts/install_python3.8.sh
	sudo bash install_python3.8.sh
fi
clear
# 8
read -p "Install gnome tweaks and make listed changes [Y/n]: "
if [ ${REPLY:-y} = y ]
then
	sudo apt-get install gnome-tweaks
	sudo apt-get install gnome-shell-extension-dash-to-panel
	busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s 'Meta.restart("Restarting Gnome…")'
	gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-dark'
	gsettings set org.gnome.desktop.interface icon-theme 'ubuntu-mono-dark'
	gsettings set org.gnome.shell.extensions.desktop-icons show-home false
	gsettings set org.gnome.shell.extensions.desktop-icons show-trash false
	gsettings set org.gnome.shell enabled-extensions "['ubuntu-dock@ubuntu.com', 'dash-to-panel@jderose9.github.com']"
	gsettings set org.gnome.shell.extensions.dash-to-panel location-clock 'STATUSRIGHT'
	gsettings set org.gnome.desktop.calendar show-weekdate true
	gsettings set org.gnome.shell.extensions.dash-to-panel appicon-margin 2
	gsettings set org.gnome.shell.extensions.dash-to-panel appicon-padding 6
	gsettings set org.gnome.desktop.interface show-battery-percentage true
fi
clear
# 9
if [ ffIn == true ] && [ vscIn == true ]
then
	read -p "Set the taskbar to Files, Firefox, Terminal & VS Code [Y/n]: "
	if [ ${REPLY:-y} = y ]
	then
		gsettings set org.gnome.shell favorite-apps "['org.gnome.Nautilus.desktop', 'firefox_dev.desktop', 'org.gnome.Terminal.desktop', 'code_code.desktop']"
	fi
fi
clear
# 10
read -p "Set terminal to run on startup [Y/n]: "
if [ ${REPLY:-y} = y ]
then
	cp /usr/share/applications/org.gnome.Terminal.desktop ~/.config/autostart/
fi
clear
# 11
read -p "Configure 2 workspaces (virtual desktops) [Y/n]: "
if [ ${REPLY:-y} = y ]
then
	gsettings set org.gnome.mutter dynamic-workspaces false
	gsettings set org.gnome.desktop.wm.preferences num-workspaces 2
fi
clear
# 12
read -p "Add WIN+I as settings shortcut [Y/n]: "
if [ ${REPLY:-y} = y ]
then
	gsettings set org.gnome.settings-daemon.plugins.media-keys control-center "['<Super>i']"
fi
clear
# 13
read -p "Add WIN+E as file explorer shortcut [Y/n]: "
if [ ${REPLY:-y} = y ]
then
	gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>e']"
fi
clear
# 14
read -p "Change retain usage history to 30 days [Y/n]: "
if [ ${REPLY:-y} = y ]
then
	gsettings set org.gnome.desktop.privacy recent-files-max-age 30
fi
clear
# 15
read -p "Enable purge trash and temp files after 30 days [Y/n]: "
if [ ${REPLY:-y} = y ]
then
	gsettings set org.gnome.desktop.privacy remove-old-trash-files true
	gsettings set org.gnome.desktop.privacy remove-old-temp-files true
fi
clear
# 16
read -p "Change desktop background [Y/n]: "
if [ ${REPLY:-y} = y ]
then
	cd ~/.local/share/backgrounds
	wget https://wallpapercave.com/wp/WbXooCc.png
	if [ $? = 0 ]
	then
		mv WbXooCc.png Ubuntu_Logo_Background.png

		gsettings set org.gnome.desktop.background picture-uri "file:///home/${USER}/.local/share/backgrounds/Ubuntu_Logo_Background.png"
		gsettings set org.gnome.desktop.screensaver picture-uri "file:///home/${USER}/.local/share/backgrounds/Ubuntu_Logo_Background.png"
	else
		echo "Failed to download background image"
	fi
fi

sudo apt autoremove
clear
echo "Setup complete"