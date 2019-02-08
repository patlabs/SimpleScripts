#!/bin/bash

#Asks for Username Input

read -p "Enter First Name ...> " firstName
read -r "Enter Surname ...> " lastName

fullName = "$firstName $lastName"

userCheck=$(grep "$fullName" /etc/passwd | awk -F: '{print $5}' | cut -d "," -f1)

if [ $fullName != $userCheck ]; then
	echo "User $fullName is good to use"

	read -p "Please Enter a new Username for the user ...>" CrUser

	/usr/sbin/useradd -c "$fullName" -m -s /bin/bash -d /home/$CrUser

	alert="User $CrUser Has been Successfully Added"
	
	read -p "Press Enter to Continue"
else

fi

