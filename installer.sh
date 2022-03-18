#!/bin/bash

CURRENT_FOLDER=`pwd`
set -e 

get_prev_folder () {
	cd ..
	echo `pwd`
	cd - > /dev/null
}



UPPER_FOLDER=`get_prev_folder`
INSTALL_FOLDER="$UPPER_FOLDER/mad_installation"

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
echo "3 - chrome"

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
rm ./mad.tmp

ln -s $INSTALL_FOLDER/mad /usr/bin/mad


