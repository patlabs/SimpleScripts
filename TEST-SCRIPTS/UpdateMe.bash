#!/bin/bash

apt update
echo "Finshed Updating!"
apt upgrade -y
echo "Finished Upgrading!"
apt dist-upgrade -y
echo "Finished Dist Upgrade!"
apt autoremove
echo "Finished Cleaning Up!"


