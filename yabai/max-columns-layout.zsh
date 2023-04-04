#!/bin/zsh
HOME_DISPLAY_UUID="FC67F57F-AFD4-9C2E-0857-D6964E3302DB"  # TODO: move this to a dedicated file and read from there

# set layout behavior, default 2 columns
# if the current display is the home display, set the layout to 3 columns
MAX_COLUMNS=2
if $(yabai -m query --displays --display | jq -re --arg var "$HOME_DISPLAY_UUID" '.uuid == $var'); then MAX_COLUMNS=3; fi;

# layout behavior
WINDOWS=$(yabai -m query --spaces --space | jq -re '.windows | length')
CURRENT_SPACE=$(yabai -m query --windows --window $YABAI_WINDOW_ID | jq -re '.space')
if yabai -m query --windows --window $YABAI_WINDOW_ID | jq -re \
    '."split-type" == "horizontal" and .space == '"$CURRENT_SPACE"' and '"$WINDOWS"' <= '"$MAX_COLUMNS"'' \
    || yabai -m query --windows --window $YABAI_WINDOW_ID | jq -re \
    '."split-type" == "vertical" and .space == '"$CURRENT_SPACE"' and '"$WINDOWS"' > '"$MAX_COLUMNS"''; then
    yabai -m window $YABAI_WINDOW_ID --toggle split
fi