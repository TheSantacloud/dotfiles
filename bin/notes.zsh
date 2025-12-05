#!/bin/zsh

SESSION="notes"
DIR="$HOME/Documents/obsidian-vault/notes"

tmux has-session -t "$SESSION" 2>/dev/null || tmux new-session -d -s "$SESSION" -c "$DIR" nvim

open -a "Ghostty"

CLIENT=$(tmux list-clients -F '#{client_tty}' 2>/dev/null | head -1)
[[ -n "$CLIENT" ]] && tmux switch-client -c "$CLIENT" -t "$SESSION"
