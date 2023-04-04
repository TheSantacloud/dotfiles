#!/bin/zsh

case "$1" in
  [1-7])
    yabai -m window --space "$1"
    yabai -m space --focus "$1"
    ;;
  right)
    # shift right
    yabai -m window --swap east || yabai -m window --warp east
    if [ $? -eq 0 ];
      then exit 0;
    else
      FOCUSED_X=$(yabai -m query --windows --window | jq -r '.frame.x + .frame.w')
      yabai -m query --windows --space | jq --argjson width "${FOCUSED_X}" -re '.[] | select(.frame.x + .frame.w >= $width and ."has-focus" == false)'
      if [ $? -ne 0 ]; then exit 1; fi
      WINDOW_ID=$(yabai -m query --windows --space | jq --argjson FOCUSED_X "$FOCUSED_X" '[.[] | select(.frame and (.frame.x + .frame.w) == $FOCUSED_X and ."has-focus" == false)] | max_by(.frame.w).id')
      yabai -m window $WINDOW_ID --toggle split
      yabai -m window --warp east
      exit 0;
    fi

    # in the window is horizontal, shift it to the right side of the screen
    yabai -m query --windows --window | jq -re '."split-type" == "horizontal"' | grep -q true && yabai -m window --toggle split && exit 0; 

    # move the window to a next space
    yabai -m config window_placement first_child
    yabai -m window --space next
    yabai -m space --focus next
    yabai -m config window_placement second_child
    ;;
  left)
    # shift left
    yabai -m window --swap west || yabai -m window --warp west
    if [ $? -eq 0 ]; then
      exit 0;
    else
      FOCUSED_X=$(yabai -m query --windows --window | jq -r '.frame.x')
      yabai -m query --windows --space | jq --argjson width "${FOCUSED_X}" -re '.[] | select(.frame.x <= $width and ."has-focus" == false)'
      if [ $? -ne 0 ]; then exit 1; fi
      WINDOW_ID=$(yabai -m query --windows --space | jq --argjson FOCUSED_X "$FOCUSED_X" '[.[] | select(.frame and .frame.x == $FOCUSED_X and ."has-focus" == false)] | max_by(.frame.w).id')
      yabai -m window $WINDOW_ID --toggle split
      yabai -m window $WINDOW_ID --warp east
      exit 0;
    fi

    # in the window is horizontal, shift it to the left side of the screen
    if yabai -m query --windows --window | jq -re '."split-type" == "horizontal"'; then
      # TODO: warp window to the left position of the horizontal window that has the closest X to its own
      yabai -m window --toggle split
      exit 0
    fi

    # move to the space to the left
    # TODO: warp window to the right most part of the space to the left
    yabai -m window --space prev
    yabai -m space --focus prev
    ;;
  up)
    yabai -m window --warp north
    if [ $? -eq 0 ]; then exit 0; fi
    if yabai -m query --windows --window | jq -re '."split-type" == "vertical"'; then
      yabai -m window --toggle split
      yabai -m window --warp north
    fi
    ;;
  down)
    yabai -m window --warp south
    if [ $? -eq 0 ]; then exit 0; fi
    if yabai -m query --windows --window | jq -re '."split-type" == "vertical"'; then
      yabai -m window --toggle split
      yabai -m window --warp south
    fi
    ;;
  next)
  # move the window to a next space
  yabai -m config window_placement first_child
  yabai -m window --space next
  yabai -m space --focus next
  yabai -m config window_placement second_child
  ;;
  prev)
  # move the window to a previous space
  yabai -m window --space prev
  yabai -m space --focus prev
  ;;
  *)
    echo "Invalid argument (can only be up, down, left, right, prev, next, or a number between 1 and 7)" >&2
    exit 1
    ;;
esac