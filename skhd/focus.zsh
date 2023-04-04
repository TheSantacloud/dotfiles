#!/bin/zsh

FOCUS_THRESHOLD=0.66
FOCUS_RATIO=$((1+$FOCUS_THRESHOLD))

HOME_DISPLAY_UUID="FC67F57F-AFD4-9C2E-0857-D6964E3302DB" # TODO: move this to a dedicated file and read from there

state=$(yabai -m query --windows --space)
window_count=$(echo "$state" | jq -r 'length')
display_size=$(yabai -m query --displays --display | jq -r '.frame')
focus_width=$(echo $display_size | jq -r --argjson ratio "$FOCUS_RATIO" '.w / $ratio | floor')
unfocused_block_width=$(echo $display_size | jq -r --argjson ratio "$focus_width" '(.w - $ratio) / 2 | floor')

# TODO: fix this to be dynamic according to display size, and take padding into account
FOCUSED_STATE_X=726
FOCUSED_STATE_Y=26
FOCUSED_STATE_W=2388
FOCUSED_STATE_H=2132

case "$window_count" in
    0)
        exit 1;
    ;;
    1)
        exit 0;
    ;;
    2)
        other_window=$(echo "$state" | jq -re '.[] | select(."has-focus" != true) | .id')
        yabai -m window $other_window --warp east
        yabai -m config split_ratio $FOCUS_THRESHOLD
        yabai -m config layout float
        yabai -m config layout bsp
        yabai -m config split_ratio 0.5
    ;;
    *)
        # if a window takes more than 60% screen real-estate that's not he current focused with, swap with it
        display_area=$(echo $display_size | jq -r '.w * .h')
        other_window=$(echo "$state" | jq -re --argjson display_area "$display_area" --argjson threshold "$FOCUS_THRESHOLD" '.[] | select(."has-focus" != true and .frame.w * .frame.h > $display_area * $threshold) | .id')
        if [ -n "$other_window" ]; then
            yabai -m window --swap $other_window
            exit 0;
        fi

        # if the main window is not on the home display, exit
        if yabai -m query --displays --display | jq -re --arg display "$HOME_DISPLAY_UUID" '.uuid != $display'; then
            # TODO: change to 2/3 and layer other windows on top of one another
            yabai -m window --toggle zoom-fullscreen
            exit 1;
        fi

        # if there's already a window in the focused state, simply swap it with the focused window
        currently_focused_window=$(yabai -m query --windows --space | jq -re --arg x "{$FOCUSED_STATE_X}" --arg y "{$FOCUSED_STATE_Y}" --arg w "{$FOCUSED_STATE_W}" --arg h "{$FOCUSED_STATE_H}" '.[] | select(.frame.x == $x and .frame.y == $y and .frame.w == $w and .frame.h == $h) | .id')
        if [ -n "$currently_focused_window" ]; then
            yabai -m window --swap $currently_focused_window
            exit 0;
        fi

        # get the windows to go on the sides
        rightmost=$(yabai -m query --windows --space | jq -r '[.[] | select(."has-focus" != true)] | max_by(.frame.x).id')
        leftmost=$(yabai -m query --windows --space | jq -r '[.[] | select(."has-focus" != true)] | min_by(.frame.x).id')

        # warp rightmost to the east side of the main window (insert, float, float)
        yabai -m window --insert east
        yabai -m window $rightmost --toggle float
        yabai -m window $rightmost --toggle float

        # warp leftmost to the west side of the main window (insert, float, float)
        yabai -m window --insert west
        yabai -m window $leftmost --toggle float
        yabai -m window $leftmost --toggle float

        # distribute windows between the two sides
        remaining_windows=$(yabai -m query --windows --space | jq -r --argjson leftmost "$leftmost" --argjson rightmost "$rightmost" '[.[] | select(."has-focus" != true and .id != $leftmost and .id != $rightmost).id]')
        wins_len=$(echo "$remaining_windows" | jq '. | length')
        slice_len=$(($wins_len / 2))
        slice_len2=$(($wins_len - $slice_len))
        wins1=$(echo "$remaining_windows" | jq -r ".[:$slice_len] | .[]")
        wins2=$(echo "$remaining_windows" | jq -r ".[-$slice_len2:] | .[]")

        for win in $wins1; do
            yabai -m window $rightmost --insert south
            yabai -m window $win --toggle float
            yabai -m window $win --toggle float
        done

        for win in $wins2; do
            yabai -m window $leftmost --insert south
            yabai -m window $win --toggle float
            yabai -m window $win --toggle float
        done

        # resize rightmost (get current width, calc diff from block_size to w, resize)
        yabai -m space --balance
        window_size=$(yabai -m query --windows --window $rightmost | jq -r '.frame.w')
        delta=$((window_size - $unfocused_block_width))
        yabai -m window $rightmost --resize left:$delta:0

        # resize leftmost (get current width, calc diff from block_size to w, resize)
        window_size=$(yabai -m query --windows --window $leftmost | jq -r '.frame.w')
        delta=$((window_size - $unfocused_block_width))
        yabai -m window $leftmost --resize right:-$delta:0
    ;;
esac