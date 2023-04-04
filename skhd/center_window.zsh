#!/bin/zsh

WINDOW=$(yabai -m query --windows --window)
DISPLAY=$(yabai -m query --displays --display)

X_WIN_POS=$(echo $WINDOW | jq -r '.frame.w')
Y_WIN_POS=$(echo $WINDOW | jq -r '.frame.h')

X_DIS_POS=$(echo $DISPLAY | jq -r '.frame.w')
Y_DIS_POS=$(echo $DISPLAY | jq -r '.frame.h')

AVG_X_POS=$((($X_DIS_POS / 2) - ($X_WIN_POS / 2)))
AVG_Y_POS=$((($Y_DIS_POS / 2) - ($Y_WIN_POS / 2)))

echo "$X_WIN_POS $X_DIS_POS"
echo "$Y_WIN_POS $Y_DIS_POS"
echo "$AVG_X_POS $AVG_Y_POS"
yabai -m window --toggle float
yabai -m window --move abs:$AVG_X_POS:$AVG_Y_POS
