#!/bin/zsh

BEARER=$(security find-generic-password -a todoist-next-actions -D bearer -s todoist -w)
if [ -z "$BEARER" ]; then
    echo "No bearer token saved as 'todoist-next-actions' (type 'bearer', service 'todoist')"
    exit 1
fi

arguments=()

for arg in "$@"; do
    arguments+=("$arg")
done

if ! test -t 0; then
    while IFS= read -r line; do
        arguments+=("$line")
    done
fi

if [ ${#arguments[@]} -eq 0 ]; then
    arguments=$(next | tail -n+2 | fzf -m | awk '{print $1}')
    arguments_array=()
    while IFS= read -r line; do
        arguments_array+=("$line")
    done <<< "$arguments"
fi

for var in "$arguments"; do
    response=$(curl -XPOST --write-out '%{http_code}' --silent --output /dev/null "https://api.todoist.com/rest/v2/tasks/$var/close" -H "Authorization: Bearer $BEARER")
    case $response in
            "204")
                    echo $var
                    ;;
            "400")
                    echo "$var not a valid task ID"
                    ;;
            *)
                    echo "$var not found"
                    ;;
    esac
done
