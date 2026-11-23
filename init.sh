#!/bin/bash
# Copy tmux-sessionizer to ~/.local/bin
mkdir -p ~/.local/bin
cp ~/.config/tmux/tmux-sessionizer ~/.local/bin/
ln -sf ~/.config/tmux/tmux-scrollback.sh ~/.local/bin/tmux-scrollback.sh
chmod +x ~/.config/tmux/trim-trail-lines.sh
chmod +x ~/.local/bin/tmux-sessionizer
chmod +x ~/.config/tmux/tmux-scrollback.sh

# Symlink .tmux.conf into ~/
ln -sf ~/.config/tmux/.tmux.conf ~/.tmux.conf

# Append the tmux auto-attach block to ~/.bashrc only once.
# The second grep also detects blocks added before the marker existed.
bashrc_marker='# >>> tmux auto-attach (dotfiles/config/tmux/init.sh) >>>'
if grep -qF "$bashrc_marker" ~/.bashrc 2>/dev/null \
  || grep -qF 'tmux attach-session -t "$first_session"' ~/.bashrc 2>/dev/null; then
  echo "tmux auto-attach block already in ~/.bashrc, skipping"
else
  echo "
$bashrc_marker"'
if [[ ! -z "$TMUX" && -n "$SSH_CONNECTION" ]]; then
    tmux attach
else
    first_session=$(tmux list-sessions -F "#{session_id}" | head -n 1)
    if [[ -n "$first_session" ]]; then
        tmux attach-session -t "$first_session"
    else
        tmux new-session -ds default
    fi
fi
# <<< tmux auto-attach <<<
' >> ~/.bashrc
fi

# Run tmux source-file ~/.tmux.conf
tmux source-file ~/.tmux.conf

