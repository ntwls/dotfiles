#!/bin/bash
##Installation for Debian
##Version 2019.12.30.1

##Variables
DTE=$(date +%Y%m%d%H%M%S)


##Functions

check_vim-tools(){
# Install VIM Tools if necessary

dpkg -l | grep vim-scripts > /dev/null #Check to see if vim-scripts is installed
if [ $? == 0 ]; then
    echo "vim-addon (vim-scripts) installed" > /dev/null
else
    echo "vim-addon (vim-scripts) not installed, installing"
    sudo apt update && sudo apt -y install vim-scripts
fi
}

check_tmux(){
# Install TMUX if necessary
dpkg -l | grep tmux > /dev/null #Check to see if tmux is installed
if [ $? == 0 ]; then
    echo "tmux installed" > /dev/null
else
    echo "tmux not installed, installing"
    sudo apt update && sudo apt -y install tmux
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

printf "\n\nPlease type \e[1;31msource ~/.bashrc\e[0m to immediately activate new .bashrc settings.\n\n\n"

}

##Execute
check_vim-tools
check_tmux
install
