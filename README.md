# mad
A simple command to open a markdown locally using your favorite browser

## What is mad?

As previously stated, **mad** is an easy command to view a markdown file using your browser.
The script uses [pandoc](https://github.com/jgm/pandoc) to convert the markdown file in an html file, stores it in a temporary folder and opens it using the previously selected browser (the default is set to firefox).
The **mad** script also allows for opening multiple files in the same browser instance while keeping track of each file opened.

## Why should I use mad?

Well, in principle you should not. Expecially if u are an IDE user, you might never had the need for such a tool. 
But in the remote chance that you are a "command line" type of guy, this might actually come in hand.

Imagine you are browsing the git repository of a project you found on the development platform you are currently using at work.
Chances are you dont have many tool insisting on said platform; chances are you are using vim/less or whatever built-in tool to just inspect whatever you find. In this case, **mad** is the script that you were looking for.


## How shall I use mad

Izipizi: in your command line simply type

```bash
$ mad <filename>
```

and the script will convert your markdown file in and html file, then open it.

As I'm writing this README.md file using vim, I'm using **mad** to check how the file progresses.
And, as a small plus, being into vim I can easly run it by using the following command

```vim
:!mad <filename>
```

## How can I install mad

First of all, install [pandoc](https://github.com/jgm/pandoc): this can be achieved in various ways. You can find a very useful guide on how to install it [here](https://github.com/jgm/pandoc/blob/master/INSTALL.md).

Then clone this repo in the installing folder and enter the folder by running:

```bash
$ cd <my-install-folder> 
$ git clone git@github.com:franava/mad.git
$ cd mad
```

Inside this folder, among with this *README.md* and a *LICENCE* file, you'll find the raw *markdown* script and an install script.
Run the install script either by being root:

```bash
$ su -
# ./install.sh
```

or by using sudo

```bash
$ sudo ./install.sh
```

And, as easy as this, **mad** will be installed; you will be asked your browser of election, to which the default value is 'firefox'.
To check if the installation has gone as expected, simply run:

```bash
$ mad README.md
```

in the *mad* folder.
Please note that after running the **install.sh** script, the folder state will be as following:

```bash
<my-install-folder>-
		   |
		   |___ mad
		   |___ mad_installation
```

## Is this it

Well, kind of. This is what the script was originally written. But given the fact that **pandocs** provides a huge amount of functionalities, this is just the first step. 

- How will this repo progress forward? *I have no idea*

- What will the next feature be? *That's a nice question. I don't have an answere, but is indeed a nice question*

- Am I allowed to do progress with it? *Please, be my guest. And in the meanwhile keep me posted*


