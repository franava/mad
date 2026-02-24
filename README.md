---
title: "Mad: a comprehensive guide"
author: "Francesco Avanzi"
...
# mad 
A quick method to perform markdown conversions from your command line
## What is mad?

As previously stated, **mad** is an easy command to view a markdown file using your browser.
The script uses [pandoc](https://github.com/jgm/pandoc) to convert the markdown file in an html file, stores it in a temporary folder and opens it using a previously selected browser (the default is set to firefox).
The **mad** script also allows you to open multiple files in the same browser instance while keeping track of each file opened.

## Why should I use mad?

Well, in principle you should not. Expecially if you are an IDE user, you might never have the need for such a tool. 
But in the remote chance you are a "command line" type of guy, this might actually come in handy.

Imagine you are browsing a git repository you found on the development platform you are currently using at work.
Chances are you dont have many tool insisting on said platform; chances are you are using vim/less or whatever built-in tool to just inspect whichever type of file you find. In this case, **mad** is the script that you were looking for.

## How shall I use mad

Izipizi: in your command line simply type

```bash
mad <filename>
```

and the script will convert your markdown file in an html file, eventually opening it.

As I'm writing this README.md file using vim, I'm using **mad** to check the file's layout.
And, as a small plus, being into vim I can easly run it by using the following command

```vim
:!mad <filename>
```

Also, a new feature __--noexec__ has been implemented. 

Running mad as it follows will allow to directly create a pdf file out of the markdown.

```bash
mad <file> --noexec
```

> **_NOTE:_** in order to use --noexec you must have installed weasyprint.
There is a way to use a different pdf engine, such as pdf-latex, with pandoc, but I must admit I have not found it easly configurable with css files etc, so i kept it simple.

## How can I install mad

First of all, install [pandoc](https://github.com/jgm/pandoc): this can be achieved in a number of ways. You can find a thorough guide on how to install it [here](https://github.com/jgm/pandoc/blob/master/INSTALL.md).
On ubuntu or more in general on debian systems, you can easly run:

```bash
sudo apt update
sudo apt install pandoc
``` 

and it will work.

Second step is to install [weasyprint](https://weasyprint.org/): as for pandoc, there are [several ways to install it](https://doc.courtbouillon.org/weasyprint/stable/first_steps.html#installation), but in general under linux systems is properly handled by package managers.
On ubuntu or more in general on debian systems, you can easly run:

```bash
sudo apt update
sudo apt install weasyprint
```

Then clone this repo in your installing folder and enter the repo by typing:

```bash
cd <my-install-folder> 
git clone git@github.com:franava/mad.git
cd mad
```

Inside this folder, along with this *README.md* and a *LICENSE* file, you'll find the raw *markdown* script and an install script.
Run the install script using sudo:

```bash
sudo ./installer.sh
```

And, as easy as this, **mad** will be installed; during the install process you will be asked your browser of election [if the process fails, the default will be 'firefox'].
To check if the installation has gone as expected, simply run:

```bash
mad README.md
```

in the *mad* folder.
Please note that after running the **install.sh** script, the folder state will be as following:

```bash
<install-folder>
		|___ mad
		|___ mad_installation
```

Also, a new feature for unattended installation has been added. 
In fact, now it is possible to run the installer as so:

```bash
sudo ./installer.sh -x
```

and this will default install to firefox.
This was made necessair for docker installation, but it might come in handy in any situation such as ansible playbook installation.
In the future, a third parameter might be introduced to not default to firefox, but rather to type in the browser.

## Styles

Currently, only two stiles are implemented: a "git" style and a "pdf" style, but changing the whole thing is quite easy.
in your **mad_installation** folder, open the **mad** script and by the end, in the pandoc command line, change the value **FMT_FOLDER** to your new CSS file location, followed by the name of the css file.
Or else, you can put your css file iside */mad_installation/formats* and simply change the format file name in the script: you do you.

You will notice that there are two differnt pandoc command lines, one for the default use, and another for the --noexec option. 
1. running mad with --noexec will directly convert the markdown in pdf using one specific css (by default *format_pdf.css*)
1. running mad with no options will create an html page and then open it with the setup browser. this option will be peformed using *format_git.css* file by default

Any of the files can be changed/modified/replaced, but then **mad&** will run in accord with the latest configurations set.


## And what about uninstalling

Easy as pie: just run the command:
```bash 
sudo ./installer.sh -u
```
and just like this you'll get rid of it.


## Is this it

Well, kind of. This is what the script was originally written for. But given the fact that **pandocs** provides a huge amount of functionalities, this is just the first step. 

- How will this repo progress? *I have no idea*

- What will the next feature be? *That's a nice question. I don't have an answere, but is indeed a nice question*

- Am I allowed to progress with it? *Please, be my guest. And in the meanwhile keep me posted*


## Current Features: implemented vs desired


[x] Generate a git-like html for README files
[x] hands-on installer
[x] unattended installer (-x)
[ ] set-up the unattended installer chosing the browser
[x] --noexec mode, generating a PDF file
[x] uninstall feature (-u) 
[ ] procedure to add/modify/remove formats
