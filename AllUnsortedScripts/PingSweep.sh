#!/bin/bash

read -p "Please enter address range without last octect [192.168.1.] ...> " ipRange


for ip in {1..254}
	do
		sleep 1s
		ping -c $ipRange.$ip | grep ^"64" | cut -d " " -f 4 &
	done
