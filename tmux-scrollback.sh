#!/usr/bin/env bash
set -euo pipefail

tmpfile=$(mktemp /tmp/scrollback.XXXXXX)

# -e keeps colour/attribute escape sequences
tmux capture-pane -e -p -S - -E - > "$tmpfile"

# Clean trailing blank lines (lines containing only escape codes count as blank)
awk '{ s = $0; gsub(/\033\[[0-9;:]*m/, "", s) }
     s ~ /^[[:space:]]*$/ { blank++; next }
     { for (i = 0; i < blank; i++) print ""; blank = 0; print }' "$tmpfile" > "${tmpfile}.clean"
mv "${tmpfile}.clean" "$tmpfile"

tmux new-window -n "Scrollback" "FROM_WEZTERM=1 SCROLLBACK_FILE='$tmpfile' nvim; rm -f '$tmpfile'"
