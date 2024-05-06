#!/bin/bash

percentage="$1"

if [ "$percentage" -eq 0 ]; then
    icon="▁"
elif [ "$percentage" -lt 17 ]; then
    icon="▂"
elif [ "$percentage" -lt 33 ]; then
    icon="▃"
elif [ "$percentage" -lt 50 ]; then
    icon="▄"
elif [ "$percentage" -lt 67 ]; then
    icon="▅"
elif [ "$percentage" -lt 83 ]; then
    icon="▆"
elif [ "$percentage" -lt 99 ]; then
    icon="▇"
else
    icon="█"
fi

echo "$icon"