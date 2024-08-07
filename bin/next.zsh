#!/bin/bash

CACHE_DIR=/tmp
PROJECTS_CACHE_FILE="$CACHE_DIR/.next_projects_cache.json"

BEARER=$(security find-generic-password -a todoist-next-actions -D bearer -s todoist -w)
if [ -z "$BEARER" ]; then
    echo "No bearer token saved as 'todoist-next-actions' (type 'bearer', service 'todoist')"
    exit 1
fi

PROJECT_MAP=$(if [ -f "$PROJECTS_CACHE_FILE" ]; then cat $PROJECTS_CACHE_FILE; else echo "{}"; fi)
TASKS=$(curl -XGET -s https://api.todoist.com/rest/v2/tasks?filter=%28%40next%20%7C%20today%20%7C%20overdue%29%20%26%20%28%21due%20after%3A%20today%29%20%26%20%21%40someday_maybe%20%7C%20%28p1%20%26%20no%20date%29 -H "Authorization: Bearer $BEARER")

TASK_PROJECT_IDS=$(echo "$TASKS" | jq -r '.[].project_id' | sort -u)
PROJECT_IDS=$(echo "$PROJECT_MAP" | jq -r 'keys.[]' | sort -u)
MISSING_IDS=$(comm -23 <(echo "$TASK_PROJECT_IDS") <(echo "$PROJECT_IDS"))

if [ -n "$MISSING_IDS" ]; then
    PROJECTS=$(curl -XGET -s https://api.todoist.com/rest/v2/projects -H "Authorization: Bearer $BEARER")
    PROJECT_MAP=$(echo "$PROJECTS" | jq -r '[.[] | {(.id): .name}] | add')
    echo $PROJECT_MAP > $PROJECTS_CACHE_FILE
fi

TOTAL=`echo $TASKS | jq length`

echo "total $TOTAL"
echo -e $TASKS | jq --argjson project_map "$PROJECT_MAP" -r 'sort_by(.project_id) | .[] | "\(.id)\t\($project_map[.project_id] // "Unknown")\tp\(.priority)\(if .due.is_recurring then "r" else "t" end)\t\(.created_at | sub("\\.[0-9]+Z$"; "Z") | fromdate | strftime("%b %d %H:%M"))  \(.content)"' | column -ts $'\t'
