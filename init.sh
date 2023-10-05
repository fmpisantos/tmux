#!/bin/bash

# Move tmux-sessionizer to ~/.local/bin
mkdir -p ~/.local/bin
mv tmux-sessionizer ~/.local/bin/
chmod +x ~/.local/bin/tmux-sessionizer

# Move .tmux.conf to ~/
mv .tmux.conf ~/

# Run tmux source-file ~/.tmux.conf
tmux source-file ~/.tmux.conf
