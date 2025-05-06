#!/bin/bash

# Move tmux-sessionizer to ~/.local/bin
mkdir -p ~/.local/bin
mv ~/.config/tmux/tmux-sessionizer ~/.local/bin/
chmod +x ~/.local/bin/tmux-sessionizer

# Move .tmux.conf to ~/
mv ~/.config/tmux/.tmux.conf ~/

echo '
if [[ ! -z "$TMUX" && -n "$SSH_CONNECTION" ]]; then
    tmux attach
else
    first_session=$(tmux list-sessions -F "#{session_id}" | head -n 1)
    if [[ -n "$first_session" ]]; then
        tmux attach-session -t "$first_session"
    else
        tmux new-session -s default
    fi
fi
' >> ~/.bashrc

# Run tmux source-file ~/.tmux.conf
tmux source-file ~/.tmux.conf
