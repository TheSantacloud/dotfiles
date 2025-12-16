#!/bin/bash
dir=$1

navigate_to_edge() {
  focused_app=$(yabai -m query --windows --window | jq -r '.app')
  if [[ "$focused_app" == "Ghostty" ]]; then
    case $dir in
      west)  tmux select-pane -t "{right}" 2>/dev/null ;;
      east)  tmux select-pane -t "{left}" 2>/dev/null ;;
      north) tmux select-pane -t "{bottom}" 2>/dev/null ;;
      south) tmux select-pane -t "{top}" 2>/dev/null ;;
    esac
    if tmux display-message -p '#{pane_current_command}' | grep -qiE 'vim'; then
      case $dir in
        west|south) tmux send-keys "C-w" "b" ;;
        east|north) tmux send-keys "C-w" "t" ;;
      esac
    fi
  fi
}

if yabai -m window --focus $dir 2>/dev/null; then
  navigate_to_edge
  exit 0
fi

case $dir in
  west)  jq_query='[.[] | select(.["is-visible"])] | sort_by(.frame.x) | last | .id' ;;
  east)  jq_query='[.[] | select(.["is-visible"])] | sort_by(.frame.x) | first | .id' ;;
  north) jq_query='[.[] | select(.["is-visible"])] | sort_by(.frame.y) | last | .id' ;;
  south) jq_query='[.[] | select(.["is-visible"])] | sort_by(.frame.y) | first | .id' ;;
esac

wrap_id=$(yabai -m query --windows --space | jq "$jq_query")
yabai -m window --focus $wrap_id 2>/dev/null
navigate_to_edge
