# Usage:
## Script
    ```bash
    chmod +x init.sh && ./init.sh
    ```
## Manual
    - Move .tmux.conf to ~/
    - Create ~/local/bin if it doesnt exist
    - Move tmux-sessionizer.sh to ~/local/bin
    - ```bash
    chmod +x tmux-sessionizer.sh
    ```
    - tmux source-file ~/.tmux.conf

## Profile
```bash
setxkbmap -option caps:escape
if [[ ! -z "$TMUX" && -n "$SSH_CONNECTION" ]]; then
    tmux attach
else
    tmux new-session -A -s default
fi
```
