#!/bin/bash

cd ~/openvpn-ca

source vars

echo "Do you want to start from a clean environment? (Y/N)"

read answer

if $answer = "Y"
then
	./clean-all
else
	echo "Not running clean-all"
fi

./build-all


