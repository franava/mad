#!/bin/bash
set -e 

AMISUDO=$(echo $SUDO_COMMAND)

if [ "$SUDO_COMMAND" == "" ]
then
	echo "This script has to be executed as sudo"
	exit 1
fi

CURRENT_FOLDER=`pwd`

get_prev_folder () {
	cd ..
	echo `pwd`
	cd - > /dev/null
}

UPPER_FOLDER=`get_prev_folder`
INSTALL_FOLDER="$UPPER_FOLDER/mad_installation"

if test "$#" -eq 1 
then
	if [ "$1" == "-u" ] 
	then
		if [ -d "$INSTALL_FOLDER" ]
		then
			rm -fr $INSTALL_FOLDER
		else	
			echo "mad is not currently installed on this machine"
		fi

		if [ -L /usr/bin/mad ]
		then	
			rm /usr/bin/mad
		else
			echo "mad was not linked in '/usr/bin/' folder"
		fi
	else
		echo "case not recognized"
		echo "./installer.sh [option] "
		echo ""
		echo "currently available options:"
		echo "    -u    uninstall mad"
	fi
	exit 0
fi


if [ -d $INSTALL_FOLDER ]
then
	echo "install folder \"$INSTALL_FOLDER\" already exists"
	echo "aborting installation"
	exit 1
fi


mkdir $INSTALL_FOLDER

cat markdown | sed -e "s|INSTALL_PATH_FOLDER|${INSTALL_FOLDER}|g" > ./mad.tmp

echo "# BrowserList"
echo "0 - I dont use any common browser"
echo "1 - firefox"
echo "2 - opera"
echo "3 - chromium"
echo "4 - chrome"

read -p 'chose your browser of choice: ' BROWSE_CHOICE; 


BROWSER="firefox"

case $BROWSE_CHOICE in
	0)
		print "insert your Browser of election (the shell command): "
	       	read BROWSER
		;;
	1)
		;;
	2)
		BROWSER="opera"
		;;
	3)
		BROWSER="chromium-browser"
		;;
	4)
		BROWSER="google-chrome"
		;;
	*)
		echo "your pick was not an allowed one: the installation will default to firefox"
		echo "you can always change the choice by editing the \"mad\" script"
		echo "the variable you'll be interested in is \"BROWSER\""
		;;
esac

echo "Browser: $BROWSER"
cat ./mad.tmp | sed "s|CHOSEN_BROWSER|$BROWSER|g" > $INSTALL_FOLDER/mad

mkdir $INSTALL_FOLDER/tmp
touch $INSTALL_FOLDER/tmp/tracker

chmod +x $INSTALL_FOLDER/mad

chown -R $SUDO_UID.$SUDO_GID $INSTALL_FOLDER/

rm ./mad.tmp

ln -s $INSTALL_FOLDER/mad /usr/bin/mad
chown -h $SUDO_UID.$SUDO_GID /usr/bin/mad 


