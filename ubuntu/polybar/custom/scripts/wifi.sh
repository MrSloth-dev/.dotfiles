#!/bin/bash

# Get current SSID - try multiple methods
ssid=""

# Method 1: NetworkManager (most common)
if command -v nmcli &> /dev/null; then
    ssid=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
fi

# Method 2: iwd (if nmcli didn't work)
if [ -z "$ssid" ] && command -v iwctl &> /dev/null; then
    ssid=$(iwctl station wlan0 show | grep "Connected network" | awk '{print $3}')
fi

# Method 3: iw (fallback)
if [ -z "$ssid" ] && command -v iw &> /dev/null; then
    ssid=$(iw dev wlan0 info | grep ssid | awk '{print $2}')
fi

# Get signal strength (0-100)
signal=$(awk 'NR==3 {printf("%.0f\n", $3*10/7)}' /proc/net/wireless)

# Choose icon
if [ -z "$ssid" ]; then
    icon="󰤮"
else
    if (( signal > 85 )); then
        icon="󰤨"
    elif (( signal > 50 )); then
        icon="󰤥"
    elif (( signal > 25 )); then
        icon="󰤟"
    else
        icon="󰤯"
    fi
fi

echo "$icon $ssid $signal%"
