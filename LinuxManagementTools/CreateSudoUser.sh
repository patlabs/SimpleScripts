#!/bin/bash

#Asks for Username Input

read -p "Enter First Name ...> " firstName
read -r "Enter Surname ...> " lastName

fullName = "$firstName $lastName"

userCheck=$(grep "$fullName" /etc/passwd | awk -F: '{print $5}' | cut -d "," -f1)

if [ "$fullName" != "$userCheck" ]; then
	echo "User $fullName is good to use"

	echo "Please Enter a new Username for the user"

	read -p "this user WILL have root privileges ...> " CrUser

	/usr/sbin/useradd -c "$fullName" -m -s /bin/bash -d /home/$CrUser

	usermod -aG sudo $CrUser

	echo "User $CrUser Has been Successfully Added"
	
	read -p "Press ENTER to continue"

elif ["$fullName" = "$userCheck"]; then

	echo "$fullName already exists in the system"
	
	read -p "Press ENTER to continue"

else
	
	echo "Something went wrong"
	
fi

