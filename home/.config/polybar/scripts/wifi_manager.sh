#!/bin/bash


if [ "$(iwctl station wlan0 show | awk '/State/ {print $2}')" == 'connected' ]; then

  # Extract RSSI value from iwctl output
  rssi=$(iwctl station wlan0 show | awk '/AverageRSSI/ {print $2}' | tr -d 'dBm')

  # Convert RSSI to percentage
  percentage=$(awk "BEGIN {print int((($rssi + 100) / 100) * 100)}")

  icon=$(generate_bar.sh "$percentage")

  # Run the wg command and capture stderr
  error=$(wg 2>&1 >/dev/null)

  # Check the exit code directly
  if wg 2>/dev/null; then
    # If exit code is 0, no VPN active
    echo " ${icon}"
  else
    # If exit code is not 0, VPN is active
    # Trying to get VPN country
    country=$(echo "$error" | grep -oE 'wg-[A-Za-z0-9]{2}-[A-Za-z0-9]{2}' | sed 's/wg-\([A-Za-z0-9]\{2\}\)-[A-Za-z0-9]\{2\}/\1/')
    country_lower=$(echo "${country}" | tr '[:upper:]' '[:lower:]')
    echo "%{F#cb4b16}󱛀 ${icon} ${country_lower}%{F-}"
  fi

else
  echo "%{F#757575}󰖪 ▁%{F-}"
fi

I want a bash script that runs wg command id echo one thing if there is stderr and another if not