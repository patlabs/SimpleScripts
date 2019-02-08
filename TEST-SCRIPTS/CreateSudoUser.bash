#!/bin/bash

#Asks for Username Input
echo "Please Enter Name for New User, this user will get root privileges"

read CrUser

adduser $CrUser

usermod -aG sudo $CrUser