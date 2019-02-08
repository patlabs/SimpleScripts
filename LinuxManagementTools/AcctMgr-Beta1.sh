#!/bin/bash

#Main menu needed to choose different account management functions
#needs a main menu
#needs to take input from user
#needs to have logic that uses user input as driving force to move to that specific functions
#need to check for root

###########################################################
#FUNCTIONS
###########################################################

addRemUser() {
echo "Add/Remove User"
#Create menu for add or remove user
#Add and remove user functionality
#check if user already exists
#Jump back to main menu
#exit program

clear

echo "
Add or Remove Users
***************************************

1) Add Non-Root User
2) Add Root User
3) Remove User
4) List Users

M) Main Menu
X) Exit
***************************************
"

read -p "Please select an option	...>" addremOption

if [ $addremOption = "1" ]; then
	echo "option 1"
	./AddUser.sh
	addRemUser
elif [ $addremOption = "2" ]; then
	echo "option 2"
	./AddSudoUser.sh
	addRemUser
elif [ $addremOption = "3" ]; then
	echo "option 3"
	addRemUser
elif [ $addremOption = "4" ]; then
	echo "option 4"
	addRemUser
elif [ $addremOption = [mM] ]; then
	echo "Back to main menu"
	main_menu
elif [[ $addremOption = [xX] ]]; then
	"Exiting ........."
	sleep 1s
	exit
else
	echo "Something went wrong...
	Please try again"
fi


# case $addremOption in
	# 1) ./CreateUser.sh
	# 2) ./CreateSudoUser.sh
	# 3) 
	# 4) 
	# m|M)
	# x|X)
# esac


}


defShell() {
echo "Default Shell"
}
resetPass() {
echo "Reset Password"
}
acctLock() {
echo "Account Lock/Unlock"
}
chName() {
echo "Change Username"
}

###########################################################
#MAIN MENU FUNCTION
###########################################################
main_menu() {
#create menu graphic
#create menu logic
clear
echo "
Welcome to the Linux User Admin Toolkit
***************************************

1) Add/Remove Users
2) Change User's Default Shell
3) Reset Password
4) Lock/Unlock User Account
5) Change Username

X) Exit
***************************************
"

read -p "Please select an option	...>" menuOption

case $menuOption in
	1) addRemUser ;;
	2) defShell ;;
	3) resetPass ;;
	4) acctLock ;;
	5) chName ;;
	x|X) read -p "Are you sure you wish to exit? [y/n]	...>" exitOption 
		case $exitOption in
		y|Y) clear
			exit
			;;
		n|N) main_menu 
		*) read -p "That is not a valid option. Press ENTER to continue" 
			main_menu
			;;
		esac
		;;
	*) read -p "That is not a valid option. Press ENTER to continue" 
		main_menu ;;
esac


}


amiroot=$(whoami)
if [["$amiroot" != "root"]]; then
	echo "This needs to be run as root!"
	echo "Try running the command with sudo or"
	echo "Run sudo !! to run the previous command as root"
else 
	echo "I"
	sleep 1s
	echo "AM"
	sleep 1s
	echo "ROOT!"
	main_menu
fi
