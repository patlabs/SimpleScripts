#!/bin/bash

apt update

apt -y install squid; echo $?

wait 1s

systemctl start squid

systemctl enable squid


systemctl status squid