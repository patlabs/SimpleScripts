#!/bin/bash

echo "You are about to create the Server Certificate, Key, and Encryption Files"
echo "Please enter the name of the server (Case-Sensetive)"

read svrName

./build-key-server $svrName -y

./build-dh

openvpn --genkey --secret keys/ta.key