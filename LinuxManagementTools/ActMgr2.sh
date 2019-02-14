#!/bin/bash

###########################
#Lazy Person Functions
###########################

chosenOption(){
#For any options which need to be chosen from a menu
read -p "Please Select an Option ...> " menuOption
}

invalidOption(){
#When a user chooses an option not in one of the menus
read -p "Sorry, that's not a valid option... Press ENTER to continue."
}

###########################
#Add/Remove Users Function
###########################
addremUser(){
#create menu for adding and removing users
#add/remove user functionality
#check if user alread exists
#jump back to main menu
#exit program
####ADD MAKE USER ROOT FUNCTION
clear

echo "
Add or Remove Users
*****************************************

1) Add User
2) Add Root User
3) Remove User
4) List Users
5) Make Existing User Root

M) Main Menu
X) Exit

*****************************************
"

chosenOption

if [ $menuOption = "1" ]; then
#	echo "Add User"
#	addremUser
	read -p "Enter First Name ...> " firstName
	read -p "Enter Surname ...> " lastName
	fullName="$firstName $lastName"
	userCheck=$(grep "fullName": /etc/passwd | awk -F: '{print $5}' | cut -d "," -f1)
	if [ "fullName" != "userCheck" ]; then
		echo "User $fullName is good to use!"
		read -p "Please enter a username for $fullName ...> " userName
		/usr/sbin/useradd "$userName" -c "$fullName" -m
		#/usr/sbin/useradd -c "$fullName" -m -s /bin/bash -d /home/$userName Not Working
		echo "User: $userName has been successfully added!"
		read -p "Press ENTER to continue"
		addremUser
	elif [ "$fullName " = "$userCheck" ]; then
		echo "$fullName alread has a user on the system: $userCheck"
		read -p "Press ENTER to continue"
		addremUser
	else
		echo "Something went wrong..."
		read -p "Press ENTER to continue"
		addremUser
	fi
#	echo $userCheck
#	echo $varfullName
elif [ $menuOption = "2" ]; then
#	echo "Add Root User"
#	addremUser
	read -p "Enter First Name ...> " firstName
        read -p "Enter Surname ...> " lastName
        fullName="$firstName $lastName"
        userCheck=$(grep "fullName": /etc/passwd | awk -F: '{print}' | cut -d "," -f1)
        if [ "fullName" != "userCheck" ]; then
                echo "User $fullName is good to use!"
                read -p "Please enter a username for $fullName ...> " userName
		/usr/sbin/useradd "$userName" -c "$fullName" -m
		#/usr/sbin/useradd -c "$fullName" -m -s /bin/bash -d /home/$userName Not Working
                echo "User: $userName has been successfully added!"
                read -p "Press ENTER to continue"
                addremUser
	elif [ "$fullName " = "$userCheck" ]; then
                echo "$fullName alread has a user on the system: $userCheck"
                read -p "Press ENTER to continue"
                addremUser
        else
                echo "Something went wrong..."
                read -p "Press ENTER to continue"
		addremUser
        fi
elif [ $menuOption = "3" ]; then
#	echo "Remove User"
#	addremUser
	read -p "Enter the username of the account you want to remove ...> " remUser
	read -p "Are you sure you wish to remove $remUser? [y/n] ...> " remConf
	case $remConf in
		y|Y) userdel -r $remUser
		read -p  "$remUser successfully removed. Press ENTER to continue"
		;;
		n|N)echo "User not removed"
		read -p "Press ENTER to continue"
		addremUser
		;;
		*) invalidOption
		addremUser
		;;
	esac
elif [ $menuOption = "4" ]; then
	echo "List Users"
	userList=$(cat /etc/passwd | awk -F: '{print $1}')
	echo $userList
	read -p "Press ENTER to continue"
	addremUser
#	addremUser
elif [ $menuOption = "5" ]; then
	echo "Make User Root"
	read -p "To be implemented... Press ENTER to continue"
	addremUser
elif [[ $menuOption = [mM] ]]; then
	echo "Back to Main Menu"
	main_menu
elif [[ $menuOption = [xX] ]]; then
	read -p "Exiting... Press Enter to quit"
	clear
	exit
else
	invalidOption
	addremUser
fi

}

###########################
#DEFAULT SHELL FUNCTION
###########################
defShell() {
# find user's current default shell
# print usable shells
# change shell functionality

clear

echo "
Default Shell Changer
*****************************************

-----------------
| bash zsh  csh |
| xiki tcsh ksh |
-----------------

1) Change Shell

M) Main Menu
X) Exit

*****************************************
"
chosenOption

if [ $menuOption = "1" ]; then
#	read -p "Change default shell Press ENTER to continue"
	read -p "Enter the username you want to make changes to ...> " usName
	read -p "Please choose default shell ...> " defshellChoice
	currentShell=$(grep ^usName /etc/passwd | awk -F: '{print $7}')
	echo "Current Shell $currentShell"
	sed -i '/'"usName"'/s,'"$currentShell"',\/bin/'"$defshellChoice"',' /etc/passwd
	echo "Default Shell changed from $currentShell to /bin/$defshellChoice"
	updatedShell=$(grep ^usName /etc/passwd | awk -F: '{print $1,$7}')
	echo $updatedShell
	read -p "Press ENTER to continue"
	defShell
elif [[ $menuOption = [mM] ]]; then
	main_menu
elif [[ $menuOption = [xX] ]]; then
	read -p "Are you sure you wish to exit? [y/n] ...> " exitOption
	case $exitOption in
		y|Y)
		;;
		n|N)
		;;
		*)
		;;
	esac
else
	invalidOption
fi

}

###########################
#RESET PASSWORD FUNCTION
###########################
# remove password of a user
# change password of a user

resetPass() {

#echo "Reset Password"
#read -p "To be implemented... Press ENTER to continue"

clear
echo "
Password Management Tool
*****************************************

1) Check Password Status
2) Change Password
3) Remove Password

M) Main Menu
X) Exit

*****************************************
"

chosenOption

case $menuOption in
	1) read -p "Enter username of the account you want to check the password of ...> " usName
	passwd -S $usName
	read -p "Press ENTER to continue"
	resetPass ;;
	2) read -p "Enter username of the account you want to change the password of ...> " usName
	passwd $usName
	echo "Password for $usName changed"
	read -p "Press ENTER to continue"
	resetPass ;;
	3) read -p "Enter username of the account you wish to remove the password from ...> " usName
	passwd -d $usName
	echo "Password removed"
	read -p "Press ENTER to continue"
	resetPass ;;
	m|M) main_menu ;;
	x|X) read -p "Are you sure you wish to exit? [y/n] ...> " exitOption
	case $exitOption in
		y|Y) exit ;;
		n|N) resetPass ;;
		*) invalidOption ;;
	esac
	;;
	*) invalidOption ;;
esac

}
###########################
#ACCOUNT (UN)LOCK FUNCTION
###########################

acctLock() {
# lock/unlock user accounts
# Check locked status of account

clear

echo "
Account (un)Lock Tool
*****************************************

1) Lock user account
2) Unlock user account
3) Check account lock status

M) Main Menu
X) Exit

*****************************************
"

chosenOption

case $menuOption in
	1) read -p "Enter the username of the Account you wish to lock ...> " usName
	chage -E 0 $usName
	echo "Account $usName is now locked"
	read -p "Press ENTER to continue"
	acctLock ;;
	2) read -p "Enter the username of the Account you wish to unlock ...> " usName
	chage -E 1 $usName
	echo "Account $usName is now unlocked"
	read -p "Press ENTER to continue"
	acctLock ;;
	3) read -p "Enter the username of the Account you wish to check ...> " usName
	chDate=$(chage -l $usName | grep ^Account | awk -F: '{print $2}' | awk '{print $1,$2,$3}' | sed 's/,//')
	if ["$chDate" = "never"] || ["chDate" = "never  "]; then
		echo "!!!!!!!!!!!!!!!!ACCOUNT UNLOCKED !!!!!!!!!!!!!!"
	else
		chDate_Convert=$(date -d "$chDate" "+%d-%m-%Y")
		chDate_Seconds=$(date -d $chDate_Convert +%s)
		tDay=$(date +%F)
		tDay_Seconds=$(date -d $tDay +%s)
		if ["$chDate_Seconds" -le "$tDay_Seconds"]; then
			echo "!!!!!!!!!!!!!!!!!!!!!!!!!ACCOUNT LOCKED !!!!!!!!!!!!!!!!!!!!!!"
		else
			echo "!!!!!!!!!!!!!!!!!!!!!!!! ACCOUNT UNLOCKED !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		fi
	fi
	echo "Password Expiry: " $chDate
	read -p "Press ENTER to continue"
	acctLock ;;
	m|M) main_menu ;;
	x|X) read -p "Are you sure you want to exit? [y/n] ...> " exitOption
	case $exitOption in
		y|Y) exit ;;
		n|N) acctLock ;;
		*) invalidOption ;;
	esac
	;;
	*) invalidOption ;;
esac

}

###########################
#CHANGE USERNAME FUNCTION
###########################

chName() {
# Change Username
# change Full Name
# menu function
# exit program function

#read -p "To be implemented... Press ENTER to continue"
#main_menu

clear

echo "
Name Changing Utility
*************************************

1) Change Username
2) Change Full Name

M) Main Menu
X) Exit

*************************************
"
chosenOption

case $menuOption in
	1) read -p "Please Enter username" usName
	read -p "Please Enter Desired username ...> " chUsName
	usermod -l $chUsName $usName
	read -p "Press ENTER to continue"
	chName ;;
	2) read -p "Please Enter username ...> " usName
	fullName=$(grep "$usName": /etc/passwd | awk -F: '{print $5}' | cut -d "," -f1) 
	echo "The Current Full name of $usName is: $fullName"
	firstName=$(echo $fullName | awk '{print $1}')
	lastName=$(echo $fullName | awk '{print $2}')
	read -p "Change Fist Name [1] Change Last Name [2] Cancel [X] ...> " menuOption
	case $menuOption in
		1) read -p "Enter New FIRST name ...> " newfirstName
		sed -i '/'"$usName"'/s,'"$firstName"','"$newfirstName"',' /etc/passwd
		vrfyName=$(grep "$usName": /etc/passwd | awk -F: '{print $5}' | cut -d "," -f1)
		echo "Name changed from $fullName to $vrfyName"
		read -p "Press ENTER to continue"
		chName ;;
		2) read -p "Enter New LAST name ...> " newlastName
		sed -i '/'"$usName"'/s,'"$lastName"','"$newlastName"',' /etc/passwd
		vrfyName=$(grep "$usName": /etc/passwd | awk -F: '{print $5}' | cut -d "," -f1)
		echo "Name changed from $fullName to $vrfyName"
		read -p "Press ENTER to continue"
		chName ;;
		x|X) chName
		;;
		*) invalidOption
		chName;;
	esac
	;;
	m|M) main_menu ;;
	x|X) read -p "Are you sure you want to exit? [y/n] ...>" exitOption
	case $exitOption in
		y|Y) exit ;;
		n|N) chName ;;
		*) invalidOption
		chName ;;
	esac ;;
	*) invalidOption
	chName ;;
esac

}

###########################
#MAIN MENU FUNCTION
###########################

main_menu(){
#create menu graphic
#create menu logic
clear
echo "
Welcome to the Linux User Admin Toolkit
****************************************

1) Add/Remove Users
2) Change User's Default Shell
3) Reset Password
4) Lock/Unlock User Account
5) Change Username

X) Exit

*****************************************
"

chosenOption

case $menuOption in
	1) addremUser ;;
	2) defShell ;;
	3) resetPass ;;
	4) acctLock ;;
	5) chName ;;
	x|X) read -p "Are you sure you with to exit? [y/n] ...> " exitOption
		case $exitOption in
		y|Y)clear
		exit ;;
		n|N) main_menu ;;
		*) invalidOption
		main_menu ;;
		esac
		;;
	*) invalidOption
	main_menu ;;
esac
}


if [ $EUID -ne 0 ]; then
	echo "this needs to be run as root! Try running this using sudo"
	exit
else
	main_menu
fi
