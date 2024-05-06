#!/bin/bash


if [ "$(iwctl station wlan0 show | awk '/State/ {print $2}')" == 'connected' ]; then

  # Extract RSSI value from iwctl output
  rssi=$(iwctl station wlan0 show | awk '/AverageRSSI/ {print $2}' | tr -d 'dBm')

  # Convert RSSI to percentage
  percentage=$(awk "BEGIN {print int((($rssi + 100) / 100) * 100)}")

  icon=$(generate_bar.sh "$percentage")

  echo " ${icon}"
else
  echo "%{F#757575}󰖪 ▁%{F-}"
fi