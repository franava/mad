#!/bin/bash

#these variables are defined at install time
INSTALL_PATH="INSTALL_PATH_FOLDER"
BROWSER="CHOSEN_BROWSER"
CLB="COMMAND_LINE_BROWSER"

TMP_FOLDER="$INSTALL_PATH/tmp"
TRACKER="$TMP_FOLDER/tracker"

if [ "$1" == "--reset" ]
then
	rm -fr $TMP_FOLDER/*
	echo 0 >> $TRACKER
	exit 0
fi

if [ "$1" == "--list" ]
then
	ls $TMP_FOLDER/*.html 2>&1 | grep -v cannot 
	exit 0
fi

if [ "$1" == "--files" ]
then
	ls $TMP_FOLDER/*.html 2>&1 | grep -v cannot | wc -l
	exit 0
fi

VAL=0

if [ -f "$TRACKER" ]
then
	PAST=$(cat $TRACKER)
	VAL=$(expr $PAST + 1)
	rm -fr $TRACKER
fi

echo $VAL > $TRACKER

NAME="$(basename $1)"_"$VAL".html

pandoc --standalone -f markdown+raw_html -t html5 -o $TMP_FOLDER/$NAME $1 -c $INSTALL_PATH/format.css
if [ "$CLB" == "1" ]
then
	$BROWSER $TMP_FOLDER/$NAME
else
	$BROWSER $TMP_FOLDER/$NAME & 
fi
