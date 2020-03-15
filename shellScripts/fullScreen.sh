#!/bin/bash

if [ $1 = 0 ]
then
	sudo apt update
	sudo apt upgrade
	reboot
elif [ $1 = 1 ]
then
	sudo apt install build-essential dkms linux-headers-$(uname -r)
	clear
	echo "Click on 'Devices' at the top of the virtual machine window"
	echo "Click the 'Insert Guest Additions CD Image' option at the bottom"
	echo "Click run on the box that pops up, enter your password and click Authenticate"
elif [ $1 = -h ]
then
	clear
	echo "PARAMETER HELP"
	echo "This script requires a single parameter when run"
	echo "(sudo ./fullScreen.sh <parameter>)"
	echo "The parameters are:"
	echo "0 - Entering 0 will update your repository and upgrade everything that's needs upgrading. This is required before running the script with 1"
	echo "1 - Entering 1 will install dependancies required for guest editions"
	echo "-h - Entering -h will bring up this parameter help screen"
else
	clear
	echo "INSTRUCTIONS FOR USING THIS SCRIPT"
	echo ""
	echo "Run the following command and wait for the system to reboot:"
	echo "sudo ./fullScreen.sh 0"
	echo "Once the system has rebooted run the following command and follow the instructions:"
	echo "sudo ./fullScreen.sh 1"
	echo ""
	echo "run ./fullScreen.sh -h for help understand the script parameters"
fi
