#!/bin/bash

#these variables are defined at install time
INSTALL_PATH="INSTALL_PATH_FOLDER"
BROWSER="CHOSEN_BROWSER"



TMP_FOLDER="$INSTALL_PATH/tmp"
TRACKER="$TMP_FOLDER/tracker"

if [ "$1" == "--reset" ]
then
	rm -fr $TMP_FOLDER/*
	exit 0
fi

if [ "$1" == "--files" ]
then
	ls $TMP_FOLDER/*.html 2>&1 | grep -v cannot 
	exit 0
fi

VAL=0
AM_I_FIRST=1

if [ -f "$TRACKER" ]
then
	PAST=$(cat $TRACKER)
	VAL=$(expr $PAST + 1)
	rm -fr $TRACKER
	AM_I_FIRST=0
fi

echo $VAL > $TRACKER

NAME="$(basename $1)"_"$VAL".html

pandoc $1 >> $TMP_FOLDER/$NAME 

firefox $TMP_FOLDER/$NAME

if [ "$AM_I_FIRST" == "1" ]
then
	rm -fr $TMP_FOLDER/* 
fi

