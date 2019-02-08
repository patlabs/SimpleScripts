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

pressEnter(){
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

enterUser(){
#For every time I ask for username within the script
read -p "Enter the username ...> " Usname
}

chosenOption(){
#Because everything doesnt need it's own option variable
read -p "Please select an option	...> " menuOption
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

chosenOption 

if [ $menuOption = "1" ]; then
	echo "option 1"
	./AddUser.sh
	addRemUser
elif [ $menuOption = "2" ]; then
	echo "option 2"
	./AddSudoUser.sh
	addRemUser
elif [ $menuOption = "3" ]; then
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
elif [ $menuOption = "4" ]; then
	var1=$(cat /etc/passwd | awk -F '{print $1}')
	echo $var1
	pressEnter
	addRemUser
elif [ $menuOption = [mM] ]; then
	echo "Back to main menu"
	main_menu
elif [[ $menuOption = [xX] ]]; then
	read -p "Are you sure you wish to exit? [y/n]	...> " exitOption 
		case $exitOption in
		y|Y) clear
			exit
			;;
		n|N) addRemUser 
		*) invalidOption
			addRemUser
			;;
		esac
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

chosenOption

if ["$menuOption" = "1"]; then
	enterUser
	read -p "Choose default Shell" defShellChoice
	currentShell = $(grep ^Usname /etc/passwd | awk -F: '{print $7}')
	echo "Current Shell: " $currentShell
	sed -i '/'"Usname"'/s,'"$currentShell"',\/bin/'"$defShellChoice"',' /etc/passwd
	echo "Default Shell changed from $currentShell to /bin/$defShellChoice"
	updatedShell=$(grep ^Usname /etc/passwd | awk -F: '{print $1,$7}')
	echo $updatedShell
	pressEnter
	defShell
elif [[ "$menuOption" = [mM] ]]
	main_menu
elif [[ "$menuOption" = [xX] ]]
	read -p "Are you sure you wish to exit? [y/n]	...> " exitOption 
		case $exitOption in
		y|Y) clear
			exit
			;;
		n|N) defShell 
		*) invalidOption
			defShell
			;;
		esac
else
	invalidOption
	defShell
fi

#main_menu
}

resetPass() {
echo "Reset Password"
ToBeImplemented
#Change Password of a user
#Remove Password of a user
clear
echo "
Password Management Tool
***************************************

1) Check a Password Status
2) Change a Password
3) Remove a Password

M) Main Menu
X) Exit
***************************************
"
chosenOption
 
case $menuOption in
	1)		echo
			enterUser
			passwd -S $Usname
			pressEnter
			resetPass
			;;
	2)		echo
			enterUser
			passwd $Usname
			pressEnter
			resetPass
			;;
	3)		echo
			enterUser
			passwd -d $Usname
			pressEnter
			resetPass
			;;
	m|M)	main_menu
			;;
	x|X)	read -p "Are you sure you wish to exit? [y/n]	...> " exitOption 
		case $exitOption in
		y|Y) clear
			exit
			;;
		n|N) resetPass 
		*) invalidOption
			resetPass
			;;
		esac
			;;
	*)		invalidOption
			resetPass
			;;
esac
#main_menu
}

acctLock() {
#echo "Account Lock/Unlock"
#ToBeImplemented
clear
echo "
Account (un)Lock Tool
***************************************

1) Lock User Account
2) Unlock User Account
3) Check Account Lock Status

M) Main Menu
X) Exit

***************************************
"
chosenOption

case $menuOption in
	1)		echo
			enterUser 
			chage -E 0 $Usname
			pressEnter
			acctLock
			;;
	2)		echo
			enterUser
			chage -E 1 $Usname
			pressEnter
			acctLock
			;;
	3)		echo
			enterUser
			#chage -l $Usname --> Gives out all password info about the account
			chDate=$(chage -l $Usname | grep ^Account | awk -F: '{print $2}' | awk '{print $1,$2,$3}') | sed 's/,//')
			if ["chDate" = "never"] || ["chDate" = "never  "]; then
				echo "!!!!!!!!!Account UNLOCKED!!!!!!!!!!"
			else
				chDate_Convert=$(date -d "$chDate" "+%d-%m-%Y")
				chDate_Seconds=$(date -d %chDate_Convert +%s)
				tDay=$(date +%F)
				tDay_Seconds=$(date -d $tDay +%s)
				echo $chDate_Seconds
				echo $tDay_Seconds
				echo "!!!!!!!!!Account LOCKED!!!!!!!!!!"
			fi
			echo "Password expiry: " $chDate
			pressEnter
			acctLock
			;;
	x|X) read -p "Are you sure you wish to exit? [y/n]	...> " exitOption 
			case $exitOption in
				y|Y) clear
					exit
					;;
				n|N) acctLock 
				*) invalidOption
					acctLock
					;;
			esac
			;;
	m|M) main_menu ;;
	*) invalidOption 
		acctLock;;
esac
main_menu
}

chName() {
echo "Change Username"
ToBeImplemented
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
chosenOption

# read -p "Are you sure you wish to exit? [y/n]	...> " exitOption 
		# case $exitOption in
		# y|Y) clear
			# exit
			# ;;
		# n|N) chName 
		# *) invalidOption
			# chName
			# ;;
		# esac
		# ;;
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

chosenOption

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
	echo "This needs to be run as root!
	Try running the command with sudo or 
	Run sudo !! to run the previous command as root"
else 
	echo "I"
	sleep 1s
	echo "AM"
	sleep 1s
	echo "ROOT!"
	main_menu
fi
