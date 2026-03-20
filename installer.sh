#!/bin/bash
set -e 

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
			rm /usr/bin/madui
            rm /usr/bin/renderer
		fi
        exit 0
    elif [ "$1" == "-x" ] 
    then
        echo "building mad without inputs" 
	else
		echo "case not recognized"
		echo "./installer.sh [option] "
		echo ""
		echo "currently available options:"
		echo "    -u    uninstall mad"
        exit 0
	fi
fi


if [ -d $INSTALL_FOLDER ]
then
	echo "install folder \"$INSTALL_FOLDER\" already exists"
	echo "aborting installation"
	exit 2
fi


mkdir $INSTALL_FOLDER

cat markdown | sed -e "s|INSTALL_PATH_FOLDER|${INSTALL_FOLDER}|g" > ./mad.tmp
cat madui | sed -e "s|INSTALL_PATH_FOLDER|${INSTALL_FOLDER}|g" > ./madui.tmp

SS_PATH_FOLDER=/home/franava/.local/bin/
#SS_PATH_FOLDER=`which shot-scraper` 
echo "SSPF: $SS_PATH_FOLDER"
cat renderer | sed -e "s|SS_PATH_FOLDER|${SS_PATH_FOLDER}|g" > ./renderer.tmp

if [ "$1" != "-x" ]
then

    echo "# BrowserList"
    echo "0 - I dont use any common browser"
    echo "1 - firefox"
    echo "2 - opera"
    echo "3 - chromium"
    echo "4 - chrome"

    read -p 'chose your browser of choice: ' BROWSE_CHOICE; 
fi

BROWSER="firefox"

COMMAND_LINE_BROWSER=0

case $BROWSE_CHOICE in
	0)
		
        read -p 'insert your Browser of election (the shell command): ' BROWSER;
		read -p 'is it a command line browser or windowed one? [y/n]' COMMAND_LINE_BROWSER;
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

cat ./mad.tmp | sed "s|CHOSEN_BROWSER|$BROWSER|g" > ./mad2.tmp 
	

if [ "$COMMAND_LINE_BROWSER" == "y" ]
then
	cat ./mad2.tmp | sed "s|COMMAND_LINE_BROWSER|1|g" > $INSTALL_FOLDER/mad
else
	cat ./mad2.tmp | sed "s|COMMAND_LINE_BROWSER|0|g" > $INSTALL_FOLDER/mad
fi

cp ./madui.tmp $INSTALL_FOLDER/madui 
cp ./renderer.tmp $INSTALL_FOLDER/renderer

mkdir $INSTALL_FOLDER/tmp
touch $INSTALL_FOLDER/tmp/tracker

mkdir $INSTALL_FOLDER/formats/

cp $CURRENT_FOLDER/formats/* $INSTALL_FOLDER/formats/ 

chmod +x $INSTALL_FOLDER/mad
chmod +x $INSTALL_FOLDER/renderer
chmod +x $INSTALL_FOLDER/madui

chown -R $SUDO_UID:$SUDO_GID $INSTALL_FOLDER/

rm ./mad.tmp ./mad2.tmp ./madui.tmp ./renderer.tmp -f

ln -s $INSTALL_FOLDER/mad /usr/bin/mad
ln -s $INSTALL_FOLDER/madui /usr/bin/madui
ln -s $INSTALL_FOLDER/renderer /usr/bin/renderer

chown -h $SUDO_UID:$SUDO_GID /usr/bin/mad 
chown -h $SUDO_UID:$SUDO_GID /usr/bin/madui 
chown -h $SUDO_UID:$SUDO_GID /usr/bin/renderer 

