#!/bin/bash

##Version 2019.12.30.1

##Variables
DTE=$(date +%Y%m%d%H%M%S)


##Functions

check_vim-tools(){
# Install VIM Tools if necessary
which dpkg > /dev/null #Check to see if DPKG is installed, indicating Debian
if [ $? == 0 ]; then
    dpkg -l | grep vim-scripts > /dev/null #Check to see if vim-scripts is installed
    if [ $? == 0 ]; then
        echo "vim-addon (vim-scripts) installed" > /dev/null
    else
        echo "vim-addon (vim-scripts) not installed, installing"
        sudo apt update && sudo apt -y install vim-scripts
    fi
else    echo "DPKG not installed, indicating Cent/RHEL system" > /dev/null
fi

}

check_tmux(){
# Install TMUX if necessary
which dpkg > /dev/null #Check to see if DPKG is installed, indicating Debian
if [ $? == 0 ]; then
    dpkg -l | grep tmux > /dev/null #Check to see if tmux is installed
    if [ $? == 0 ]; then
        echo "tmux installed" > /dev/null
    else
        echo "tmux not installed, installing"
        sudo apt update && sudo apt -y install tmux
    fi
else    echo "DPKG not installed, indicating Cent/RHEL system" > /dev/null
fi

which yum > /dev/null #Check to see if YUM is installed, indicating Cent/RHEL
if [ $? == 0 ]; then
    which tmux > /dev/null #Check to see if tmux is installed
    if [ $? == 0 ]; then
        echo "tmux installed" > /dev/null
    else
        echo "tmux not installed, installing"
        sudo yum install -y tmux
    fi
else    echo "YUM not installed, indicating Ubuntu system" > /dev/null
fi

}


install(){
# Begin installation of dot files
mkdir -p ~/.dotbackup
for DOTFILE in $(find . -maxdepth 1 -name "dot.*" -type f  -printf "%f\n" | sed 's/^dot//g'); do
    echo "Backing up ~/${DOTFILE} to ~/.dotbackup/${DOTFILE}.${DTE}.bak..."
    cp ~/${DOTFILE} ~/.dotbackup/${DOTFILE}.${DTE}.bak
    echo "Installing new file to  ~/${DOTFILE}..."
    cp dot${DOTFILE} ~/${DOTFILE}
done
}



##Execute
check_vim-tools
check_tmux
#install
