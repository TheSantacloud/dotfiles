#!/bin/zsh

client=$(tmux list-clients -F '#{client_tty}' | head -1)
session=$(tmux display-message -t "$client" -p '#S' 2>/dev/null)

if [[ $(yabai -m query --windows --window | jq -r '.app') != "Ghostty" ]]; then
    open -a "Ghostty"
fi

if [[ "$session" == "notes" ]]; then
    tmux switch-client -t "$client" -l
fi
