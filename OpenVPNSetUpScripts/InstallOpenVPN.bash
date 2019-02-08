#!/bin/bash

##This Script will auto install and hopefully set up the CA Directory

apt update
apt install openvpn easy-rsa

make-cadir ~/openvpn-ca

cd ~/openvpn-ca



