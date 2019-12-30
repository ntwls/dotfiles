#!/bin/bash

for DOTFILE in $(find . -maxdepth 1 -name "dot.*" -type f  -printf "%f\n" | sed 's/^dot//g'); do
    echo "Backing up ~/${DOTFILE} to ~/${DOTFILE}.bak..."
    cp ~/${DOTFILE} ~/${DOTFILE}.bak
    echo "Installing new file to  ~/${DOTFILE}..."
    cp dot${DOTFILE} ~/${DOTFILE}
done
