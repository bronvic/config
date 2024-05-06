#!/bin/bash

load=$((100-$(vmstat 1 2|tail -1|awk '{print $15}')))
icon=$(generate_bar.sh "$load")
echo " ${icon} "