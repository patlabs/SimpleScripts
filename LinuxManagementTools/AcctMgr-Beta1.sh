#!/bin/bash

#Main menu needed to choose different account management functions
#needs a main menu
#needs to take input from user
#needs to have logic that uses user input as driving force to move to that specific functions
#need to check for root

###########################################################
#LAZINESS FUNCTIONS
###########################################################

ToBeImplemented (){
#Because I don't want to have to type this again 
read -p "To be implemented... Press ENTER to continue"
}

continueRead(){
#Should stop me having to retype this every time I have to
read -p "Press ENTER to continue."
}

problemResponse(){
#for every time something goes wrong
read -p "Something Went Wrong...
Please try again"
}

invalidOption(){
#for invalid option choices
read -p "That is not a valid option. Press ENTER to continue" 
}

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

read -p "Please select an option	...> " addremOption

if [ $addremOption = "1" ]; then
	echo "option 1"
	./AddUser.sh
	addRemUser
elif [ $addremOption = "2" ]; then
	echo "option 2"
	./AddSudoUser.sh
	addRemUser
elif [ $addremOption = "3" ]; then
	read -p "Enter a username to remove ...> " addremUname
	read -p "Are you certain you want to remove $addremUname? [y/n]...>" remConf
	case $remConf in
		y|Y)	userdel -r $addremUname
				read -p "$addremUname successfully removed. Press ENTER to continue. "
				;;
		n|N)	addRemUser
				;;
		*)		invalidOption
				addRemUser
				;;
	esac
elif [ $addremOption = "4" ]; then
	var1=$(cat /etc/passwd | awk -F '{print $1}')
	echo $var1
	continueRead
	addRemUser
elif [ $addremOption = [mM] ]; then
	echo "Back to main menu"
	main_menu
elif [[ $addremOption = [xX] ]]; then
	"Exiting ........."
	sleep 1s
	exit
else
	problemResponse
fi

}


defShell() {
# find the user's current default shell
# print usable shells
# change shell function

clear

echo "
Default Shell Changer
***************************************
------------------
|  bash zsh csh  |
|  xiki tcsh ksh |
------------------

1) Change Shell 

M) Main Menu
X) Exit
***************************************
"

read -p "Please select an option	...> " defShellOption

if ["$defShellOption" = "1"]; then
	read -p "Enter the username ...> " defShellUser
	read -p "Choose default Shell" defShellChoice
	currentShell = $(grep ^$defShellUser /etc/passwd | awk -F: '{print $7}')
	echo "Current Shell: " $currentShell
	sed -i '/'"$defShellUser"'/s,'"$currentShell"',\/bin/'"$defShellChoice"',' /etc/passwd
	echo "Default Shell changed from $currentShell to /bin/$defShellChoice"
	updatedShell=$(grep ^$defShellUser /etc/passwd | awk -F: '{print $1,$7}')
	echo $updatedShell
	continueRead
	defShell
elif [[ "$defShellOption" = [mM] ]]
	main_menu
elif [[ "$defShellOption" = [xX] ]]
	exit
else
	invalidOption
	defShell
fi

main_menu
}
resetPass() {
echo "Reset Password"
ToBeImplemented
main_menu
}
acctLock() {
echo "Account Lock/Unlock"
ToBeImplemented
main_menu
}
chName() {
echo "Change Username"
ToBeImplemented
main_menu
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

"

read -p "Please select an option	...> " menuOption

case $menuOption in
	1) addRemUser ;;
	2) defShell ;;
	3) resetPass ;;
	4) acctLock ;;
	5) chName ;;
	x|X) read -p "Are you sure you wish to exit? [y/n]	...> " exitOption 
		case $exitOption in
		y|Y) clear
			exit
			;;
		n|N) main_menu 
		*) invalidOption
			main_menu
			;;
		esac
		;;
	*) invalidOption
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
