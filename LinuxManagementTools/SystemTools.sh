#!/bin/bash


########################
#MAIN MENU
########################
# menu graphic
# Options for:
	#Updating/Upgrading system
	#Installing alternate Packaged (Shells within that)
	#Access Account Manager
	#Post install configurator

clear
echo "
Linux System Administrator Toolkit
***********************************

1) Update/Upgrade System
2) Install Alternate Packages
3) Post Install Configurator
4) User Admin Toolkit

X) Exit

***********************************
"

read -p "Please Choose an Option ...> " menuOption

case $menuOption in

esac

########################
#CHECK FOR ROOT
########################

if [ $EUID -ne 0 ]; then
	echo "This needs to be run as Root!"
	echo "Try 'sudo ./SystemTools.sh' or use 'sudo !!'"
else
	main_menu
fi
