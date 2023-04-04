#!/bin/zsh

SPLIT_TYPE=$(yabai -m query --windows --window | jq -r '."split-type"')

if [[ $SPLIT_TYPE = "horizontal" ]]; then
    yabai -m window --resize bottom:$1:$1 2>/dev/null
    yabai -m window --resize top:$1:$1 2>/dev/null
elif [[ $SPLIT_TYPE = "vertical" ]]; then
    yabai -m window --resize left:$1:$1 2>/dev/null
    yabai -m window --resize right:$1:$1 2>/dev/null
else
    yabai -m window --resize top:$1:$1 2>/dev/null
    yabai -m window --resize bottom:$1:$1 2>/dev/null
    yabai -m window --resize right:$1:$1 2>/dev/null
    yabai -m window --resize left:$1:$1 2>/dev/null
fi