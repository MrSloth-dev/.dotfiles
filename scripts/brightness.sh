#!/bin/bash

# Get current brightness
CURRENT_BRIGHTNESS=$(xrandr --verbose | grep -m 1 -i brightness | cut -f2 -d ' ')

# Adjust brightness
if [ "$1" == "up" ]; then
    NEW_BRIGHTNESS=$(awk "BEGIN {print ($CURRENT_BRIGHTNESS + 0.1 <= 1.0 ? $CURRENT_BRIGHTNESS + 0.1 : 1.0)}")
elif [ "$1" == "down" ]; then
    NEW_BRIGHTNESS=$(awk "BEGIN {print ($CURRENT_BRIGHTNESS - 0.1 >= 0.1 ? $CURRENT_BRIGHTNESS - 0.1 : 0.1)}")
else
    echo "Usage: $0 {up|down}"
    exit 1
fi

# Set new brightness
xrandr --output eDP-1 --brightness $NEW_BRIGHTNESS

