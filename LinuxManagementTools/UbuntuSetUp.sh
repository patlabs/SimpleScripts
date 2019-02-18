#!/bin/bash

#will install everything I need to use Ubuntu VM as a scripting and building environment
#install nmap
#install dos2unix
#install git
#update and upgrade I guess?

###############################
#GLOBAL VARIABLES
###############################

rooted=$(whoami)

###############################
#GLOBAL FUNCTIONS
###############################

instMSF(){

add-apt-repository pps:webupd8team/java
apt update
apt install -y build-essential git libreadline-dev libssl-dev libpq5 libpq5-dev libreadline5 libsqlite3-dev libpcap-dev git-core autoconf postgresql pgadmin3 curl zlib1g-dev libxm12-dev libxslt1-dev libyaml-dev curl zlib1g-dev gawk bison libffi-dev libgdbm-dev libncurses5-dev libtool sqlite3 libgmp-dev gnupg2 dirmgr nmap
apt update
apt upgrade -y
sleep 0.05
cd ~
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL
sleep 0.05
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
#sudo plugin so we can run metasploit as root with "rbenv sudo msfconsole"
git clone git://github.com/dcarley/rbenv-sudo.git ~/.rbenv/plugins/rbenv-sudo
exec $SHELL
RUBYVERSION=$(wget https://raw.githubusercontent.com/rapid7/metasploit-framework/master/.ruby-version -q -O - )
rbenv install $RUBYVERSION
rbenv global $RUBYVERSION
ruby -v
sleep 0.05
cd /opt
git clone https://github.com/rapid7/metasploit-framework.git
chown -R `whoami` /opt/metasploit-framework
cd metasploit-framework
gem install bundler
bundle install
sleep 0.05
cd metasploit-framework
bash -c 'for MSF in $(ls msf*); do ln -s /opt/metasploit-framework/$MSF /usr/local/bin/$MSF;done'
sleep 0.05
echo "export PATH=$PATH:/usr/lib/postgresql/10/bin" >> ~/.bashrc
. ~/.bashrc
usermod -a -G postgres `whoami`
su - `whoami`
cd /opt/metasploit-framework
./msfdb init
}

grubCustom(){

add-apt-repository ppa:danielrichter2007/grub-customizer

apt update

apt install -y grub-customizer

}

instTLP(){

add-apt-repository ppa:linuxuprising/apps

apt update

apt install -y tlp tlpui

}

instExtras(){

apt install -y ubuntu-restricted-extras vlc browser-plugin-vlc

apt purge -y totem

}

instWallpaper(){

apt install -y ubuntu-wallpapers

}

choseExit(){

read -p "Are you sure you wish to exit? [y/n] ...> " exitOption

}

invalidOption(){

read -p "Invalid Option... Press ENTER to continue"

}

choseanOption(){

read -p "Please choose an option ...> " menuOption

}

megaUpdate(){

apt update
echo "Updated"
sleep 1s
apt upgrade -y
read -p "Finished! Press ENTER to continue"

}

megaUpgrade(){

apt update
sleep 1s
apt dist-upgrade -y
read -p "Finished! Press ENTER to continue"

}

penTest(){

megaUpdate

apt install -y wireshark sqlmap john aircrack-ng wifite

instMSF

}

webDev(){

megaUpdate

apt install -y apache2 mysql-server php php7.0 phpmyadmin

}

softDev(){

echo "To be Implemented..."
installTools

}

easterEgg(){

echo "
This option will install these packages:
----------------------------------------
cowsay
fortune-mod
libaa-bin
oneko
xeyes
bb
lolcat
toilet
bsdgames
ddate
figlet
sysvbanner
xcowsay
aview
espeak
rig
-----------------------------------------
"
read -p "Are you happy with this? [y/n] ...> " menuOption

if [[ "$menuOption" = "y" ]] || [[ "$menuOption" = "Y" ]]; then
	clear
	apt install -y cowsay fortune-mod libaa-bin oneko x11-apps bb lolcat toilet bsdgames ddate figlet sysvbanner xcowsay aview espeak rig
	sleep 0.05
	clear
	figlet "Install Complete! Press ENTER to Continue!"
	read
	installTools
elif [[ "$menuOption" = "n" ]] || [[ "$menuOption" = "N" ]]; then
	installTools
else
	invalidOption
	installTools
fi

}

gameKit(){

echo "To be Implemented..."
installTools


}

uTubeKit(){

echo "To be Implemented..."
installTools


}

###############################
#TOOL INSTALLER
###############################
installTools(){
#clear
# list options of toolsets
# option to install all tools
# option to remove tools maybe?
# ************************
# TOOL LISTS
# ************************
# Pen-testing suite? (metasploit [instMSF], nmap, more to be added)
# Standard shit I use (apache, json, npm, php, more to be added)

clear

echo "
Tool Installer
****************************

1) Pen-testing Suite
2) Web-dev Kit
3) Software-dev Kit
4) Easter Eggs
5) Gaming Kit
6) YouTuber Kit

M) Main Menu
X) Exit

****************************
"

choseanOption
case $menuOption in
	1) penTest ;;
	2) webDev ;;
	3) softDev ;;
	4) easterEgg ;;
	5) gameKit ;;
	6) uTubeKit;;
	m|M) main_menu ;;
	x|X) choseExit
	case $exitOption in
		y|Y) exit ;;
		n|N) installTools ;;
		*) invalidOption
		installTools ;;
	esac ;;
	*) invalidOption
	installTools ;;
esac

#read -p "To be Implemented... Press ENTER to continue"
#main_menu

}

###############################
#ALTERNATE SHELLS
###############################
#list shells
#option to install specific shell
#option to install all shells

altShell(){

echo "
Alternate Shell Options
*******************************

---------------------
|   dash csh bsh    |
|   ksh tcsh zsh    |
| fish ipython mksh |
---------------------

1) Install Specific Shell
2) Install All Shells

M) Menu
X) Exit

********************************
"

choseanOption

case $menuOption in
        1) read -p "Enter desired Shell ...> " chShell
        chLower=$(echo "$chShell" | awk '{print tolower($0)}')
	apt install $chLower -y
	altShell ;;
	2) read -p "Installing All Shells... Press ENTER to continue"
	apt install -y dash csh zsh ksh tcsh fish ipython mksh bsh
	read -p "Installed All Shells!"
	altShell ;;
        m|M) main_menu ;;
        x|X) choseExit
        case $exitOption in
                y|Y) exit ;;
                n|N) altShell ;;
                *) invalidOption
                altShell ;;
        esac ;;
        *) invalidOption
        altShell ;;
esac



#read -p "To be Implemented... Press ENTER to Continue"
#cstmizr
}

###############################
#CHANGE DESKTOP ENVIRONMENT
###############################
#List available alternate Desktop environment
#install selected desktop environment
chdeskEnvi(){

echo "
Alternate Desktop Environments
*******************************

---------------------
| Unity KDE-Plasma  |
| GNOME Mate Xfce   |
| Budgie Cinnamon   |
---------------------

1) Install Alternate Desktop Environment

M) Main Menu
X) Exit

********************************
"

choseanOption

case $menuOption in
	1) read -p "Enter desired Desktop Environment ...> " chEnvi
	chLower=$(echo "$chEnvi" | awk '{print tolower($0)}')
	enviCheck=$(echo $XDG_CURRENT_DESKTOP)
	if [[ "$chLower" != "$enviCheck" ]]; then
		if [[ "$chLower" = "unity" ]]; then
			#echo "Unity"
			apt install unity-tweak-tool -y
		elif [[ "$chLower" = "xfce" ]]; then
			apt install -y xubuntu-desktop
		elif [[ "$chLower" = "kde" ]] || [[ "$chLower" = "kde-plasma" ]]; then
			apt install -y tasksel kubuntu-desktop
		elif [[ "$chLower" = "gnome" ]]; then
			add-apt-repository ppa:gnome3-team/gnome3
			apt update
			apt install -y gnome-shell ubuntu-gnome-desktop
		elif [[ "$chLower" = "mate" ]]; then
			apt install -y ubuntu-mate-desktop
		elif [[ "$chLower" = "budgie" ]]; then
			app-apt-repository ppa:budgie-remix/ppa
			apt update
			apt install -y budgie-desktop-environment
		elif [[ "$chLower" = "cinnamon" ]]; then
			add-apt-repository ppa:embrosyn/cinnamon
			apt update
			apt install -y cinnamon
		else
			invalidOption
			chdeskEnvi
		fi

		#apt install $chLower -y
		#echo "$chLower"
		read -p "Environment $chEnvi has been installed! (Restart required) Press ENTER to continue"

	else
		echo "Environment $chEnvi is already installed!"
		read -p "Press ENTER to continue"
	fi
	chdeskEnvi ;;
	m|M) main_menu ;;
	x|X) choseExit
	case $exitOption in
		y|Y) exit ;;
		n|N) chdeskEnvi ;;
		*) invalidOption
		chdeskEnvi;;
	esac ;;
	*) invalidOption
	chdeskEnvi ;;
esac

}
###############################
#VM CUSTOMISATION FUNCTION
###############################
# FOR VM INSTALLS
# *******************
# Alternate Desktops
# Custom Shells
# VMwareTools
# More to probably be added

installVM(){

clear

echo "
Virtual Machine Customisation Tool
***********************************

1) Change Desktop Environment
2) Install Alternate Shell(s)
3) Install Ubuntu Wallpapers

M) Main Menu
x) Exit

************************************
"

choseanOption

case $menuOption in
        1) chdeskEnvi ;;
        2) altShell ;;
        3) instWallpaper ;;
        m|M) main_menu ;;
        x|X) choseExit
        case $exitOption in
                y|Y) exit ;;
                n|N) installVM ;;
                *) invalidOption
                installVM ;;
        esac ;;
        *) invalidOption
        installVM ;;
esac


#read -p "To be Implemented... Press ENTER to continue"
#cstmizr

}
###############################
#PC CUSTOMISATION FUNCTION
###############################
# Choose an alternate Shell
# Alternate Desktop Environment
# Restricted Extras
# VLC
# TLP
# Install GRUB Customizer
# Menu for all this shit

installPC(){

clear

echo "
PC Install Customisation Tool
********************************

1) Change Desktop Environment
2) Install Alternate Shell(s)
3) Install Restricted Extras
4) Install GRUB Customizer
5) Install TLP Power Saving Tool
6) Install Ubuntu Wallpapers

M) Main Menu
x) Exit

*********************************
"

choseanOption

case $menuOption in
	1) chdeskEnvi ;;
	2) altShell ;;
	3) instExtras ;;
	4) grubCustom ;;
	5) instTLP ;;
	6) instWallpaper ;;
	m|M) main_menu ;;
	x|X) choseExit
	case $exitOption in
		y|Y) exit ;;
		n|N) installPC ;;
		*) invalidOption
		installPC ;;
	esac ;;
	*) invalidOption
	installPC ;;
esac

#read -p "To be Implemented... Press ENTER to continue"
#cstmizr

}

###############################
#UBUNTU CUSTOMIZER
###############################
# mostly un-needed for VM's
# I will add a VM customisation option
# install customisations, these will be listed below
# *******************
# FOR PC INSTALLS
# *******************
# GRUB customizer
# Options for alternate Desktops: GNOME, KDE Plasma, Mate, Budgie, Xfce, Xubuntu, Cinnamon, Unity (+TweakTool)
# Install Custom Shells
# Install Restricted Extras
# Replace Totem Video Player with VLC
# Install TLP
# *******************
# FOR VM INSTALLS
# *******************
# Alternate Desktops
# Custom Shells
# VMwareTools
# More to probably be added
# **************************
# build menu graphic

cstmizr(){

clear

echo "
Ubuntu Customisation Tool
*******************************

1) PC Installs
2) VM Installs

M) Main Menu
X) Exit

*******************************
"

choseanOption

case $menuOption in
	1) installPC ;;
	2) installVM ;;
	m|M) main_menu ;;
	x|X) choseExit
	case $exitOption in
		y|Y) exit ;;
		n|N) cstmizr ;;
		*) invalidOption
		cstmizr ;;
	esac ;;
	*) invalidOption
	cstmizr ;;
esac

}

###############################
#UPDATE/UPGRADE FUNCTION
###############################
#Use megaUpdate
#Use megaUpgrade
# Build menu graphic
updateUpgrade(){

clear

echo "
Updated/Upgrade Tool
*********************************

1) Update System and Packages
2) Upgrade Distribution

M) Main Menu
X) Exit

**********************************
"

choseanOption

case $menuOption in
	1) megaUpdate
	updateUpgrade ;;
	2) megaUpgrade
	updateUpgrade ;;
	m|M) main_menu ;;
	x|X) choseExit
	case $exitOption in
		y|Y) exit ;;
		n|N) updateUpgrade ;;
		*) invalidOption
		updateUpgrade ;;
	esac ;;
	*) invalidOption
	updateUpgrade ;;
esac
}
###############################
#MAIN MENU FUNCTION
###############################

main_menu(){

clear

echo "
Ubuntu Post Set Up Tool
**********************************

1) Update/Upgrade Ubuntu
2) Install Tools
3) Install Customisations

X) Exit

***********************************
"

choseanOption

case $menuOption in
	1) updateUpgrade ;;
	2) installTools ;;
	3) cstmizr ;;
	x|X) choseExit
	case $exitOption in
		y|Y) exit ;;
		n|N) main_menu ;;
		*) invalidOption
		main_menu ;;
	esac ;;
	*) invalidOption
	main_menu ;;
esac


}

###############################
#CHECK ROOT FUNCTION
###############################

if [[ $rooted = "root" ]]; then
	main_menu
else
	echo "This tool needs to be run as root!"
        echo "Try running this script using sudo"
        echo "Or try using 'sudo !!' to run the previous command as root"
fi
