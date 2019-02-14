#!/bin/bash

# add Sudo/root checker
# backup Files/directories
# restore files/directories
# add -b for backup functionality
# add -r for restore functionality
# $2 is the name to save the archive
# $3 is the file or dir you wish to backup
# Add -h to list functional parameters

#######################################
#GLOBAL VARIABLES
#######################################

rooted=$(whoami)

tDate=$(date +%H%M-%d%m%y)

bakDir="/backup"

#######################################
#START CHECKER
#######################################

if [[ $rooted = "root" ]] && [[ $1 = "-b" ]] && [[ -e $3 ]]; then
	read -p "Backup is good to start! Press ENTER to begin!"
	tar -cxvf $2.backup.$tDate $3
	zippy=$2.backup.$tDate
	echo "Checking if $zippy exitst in $bakDir"
	if [ ! -e $bakDir/$zippy ]; then
		echo "Nope! We're Good!"
		sleep 2s
		mv $zippy $backdir
		chmod u=rw,go= $bakDir/$zippy
		echo "Backup Complete!"
		ls -lh $bakDir/$zippy
		read -p "Press ENTER to continue"
	else
		read -p "File $bakDir/$zippy Already exists... Overwrite? [y/n] ...> " overwriteResponse
		case $overwriteResponse in
			y|Y) mv $zippy $bakDir
			echo "Backup Complete!"
			ls -lh $bakDir/$zippy
			read -p "Press ENTER to continue"
			;;
			n|N) echo "Backup Cancelled. Cleaning Files..."
			rm -rf $zippy
			echo "$zippy removed"
			;;
			*) echo "Invalid Option"
			exit
			;;
		esac
	fi
elif [[ $rooted = "root" ]] && [[ $1 = "-r" ]] && [[ -e $2 ]] && [[ -e $3 ]]; then

	tar -zxv -f $2 -C $3
	echo "Items restored from backup!"

elif [[ $rooted = "root" ]] && [[ $1 = "-r" ]] && [[ -e $2 ]]; then

	tar -zxv -f $2

	echo "Items restored from backup!"

elif [[ $rooted = "root" ]] && [[ $1 = "-h" ]] || [[ -e $1 ]]; then
	echo "
	Parameters
	***********
	-h	Lists available parameters

	-b	Performs Backup to $bakDir/ARCHIVE_NAME
		Use in the way of: ./BackerUpper.sh -b ARCHIVE_NAME FILE/DIRECTORY NAME

	-r	Restores a backed up archive (full path required)
		Use in the way of: ./BackerUpper.sh -r ARCHIVE_NAME(FULL PATH REQUIRED) RESTORE_DIR(optional)

	More parameters will be implemented in the future

	"
else
	echo "This tool needs to be run as root!"
	echo "Try running this script using sudo"
	echo "Or try using 'sudo !!' to run the previous command as root"

#	echo "To BACKUP: use -b archive_name file/dir name"
#	echo "To RESTORE: use -r archive_name(FULL PATH REQUIRED) restore_dir(optional)"

fi



