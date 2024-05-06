#!/bin/bash

load=$(free | awk '/^Mem/ {printf("%.0f", $3/$2 * 100)}')
icon=$(generate_bar.sh "$load")
echo "${icon} "