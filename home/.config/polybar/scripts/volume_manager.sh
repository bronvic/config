#!/bin/bash


# Get the microphone or audio output index based on input type
get_index() {
    case "$1" in
        "mic")
            index=$(pamixer --list-sources | grep -i 'input' | head -n 1 | awk '{print $1}')
            ;;
        "audio")
            index=$(pamixer --list-sinks | grep -i 'output' | head -n 1 | awk '{print $1}')
            ;;
        *)
            echo "Invalid input type: use 'mic' or 'audio'"
            exit 1
            ;;
    esac
    echo "$index"
}

# Toggle mute status for the microphone or audio output
toggle_mute() {
    type=$1
    index=$(get_index "$type")
    if [ "$type" == "mic" ]; then
        pamixer --source "$index" --toggle-mute
    elif [ "$type" == "audio" ]; then
        pamixer --sink "$index" --toggle-mute
    fi
}

# Adjust volume for the microphone or audio output
adjust_volume() {
    type=$1
    direction=$2
    index=$(get_index "$type")

    if [ "$type" == "mic" ]; then
        adjustment="source"
    elif [ "$type" == "audio" ]; then
        adjustment="sink"
    fi

    if [ "$direction" == "up" ]; then
        pamixer --"$adjustment" "$index" --increase 5
    elif [ "$direction" == "down" ]; then
        pamixer --"$adjustment" "$index" --decrease 5
    fi
}

# Get current volume for the microphone or audio output
get_volume() {
    type=$1
    index=$(get_index "$type")

    if [ "$type" == "mic" ]; then
        volume=$(pamixer --source "$index" --get-volume)
    elif [ "$type" == "audio" ]; then
        volume=$(pamixer --sink "$index" --get-volume)
    fi
    echo "$volume"
}

# Check if the microphone or audio output is muted
is_muted() {
    type=$1
    index=$(get_index "$type")

    if [ "$type" == "mic" ]; then
        muted=$(pamixer --source "$index" --get-mute)
    elif [ "$type" == "audio" ]; then
        muted=$(pamixer --sink "$index" --get-mute)
    fi
    echo "$muted"
}

# Display the current status for Polybar
output_status() {
    type=$1
    icon_unmuted=$2
    icon_muted=$3

    volume=$(get_volume "$type")
    bar=$(generate_bar.sh "$volume")
    muted=$(is_muted "$type")

    output="${icon_unmuted} ${bar}"
    if [ "$muted" == "true" ]; then
        output="%{F#757575}${icon_muted} ${bar}%{F-}"
    fi

    if [ "$type" == "audio" ]; then
        output="${output} "
    fi

    echo "${output}"
}

output_status() {
  type=$1
  volume=$(get_volume "$type")
  bar=$(generate_bar.sh "$volume")
  muted=$(is_muted "$type")

  if [ "$type" == "mic" ]; then
    output_status_mic "$bar" "$muted"
  elif [ "$type" == "audio" ]; then
    output_status_audio "$bar" "$muted"
  fi
}

output_status_mic() {
  bar=$1
  muted=$2

  if [ "$muted" == "true" ]; then
    output="%{F#757575}${bar} %{F-}"
  else
    output="${bar} "
  fi

  echo "$output"
}

output_status_audio() {
  bar=$1
  muted=$2

  if [ "$muted" == "true" ]; then
    output="%{F#757575}󰝟 ${bar}%{F-} "
  else
    output=" ${bar} "
  fi

  echo "$output"
}

# Handle the arguments and take action
if [ "$#" -ne 2 ]; then
    echo "Invalid arguments. Use <mic|audio> <toggle|status|increase|decrease>"
    exit 1
fi

type=$1
action=$2

case "$action" in
    "toggle")
        toggle_mute "$type"
        ;;
    "status")
        if [ "$type" == "mic" ]; then
            output_status "mic" "" ""
        elif [ "$type" == "audio" ]; then
            output_status "audio" "" "󰝟"
        fi
        ;;
    "increase")
        adjust_volume "$type" "up"
        ;;
    "decrease")
        adjust_volume "$type" "down"
        ;;
    *)
        echo "Invalid action: use 'toggle', 'status', 'increase', or 'decrease'"
        ;;
esac
