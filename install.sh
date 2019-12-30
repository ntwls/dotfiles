#!/bin/bash

# Check if vim-addon installed, if not, install it automatically
dpkg -l | grep vim-scripts > /dev/null
if [ $? == 0 ]; then
    echo "vim-addon (vim-scripts) installed" > /dev/null
else
    echo "vim-addon (vim-scripts) not installed, installing"
    sudo apt update && sudo apt -y install vim-scripts
fi

# Begin installation of dot files
for DOTFILE in $(find . -maxdepth 1 -name "dot.*" -type f  -printf "%f\n" | sed 's/^dot//g'); do
    echo "Backing up ~/${DOTFILE} to ~/${DOTFILE}.bak..."
    cp ~/${DOTFILE} ~/${DOTFILE}.bak
    echo "Installing new file to  ~/${DOTFILE}..."
    cp dot${DOTFILE} ~/${DOTFILE}
done
