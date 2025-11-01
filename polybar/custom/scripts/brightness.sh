#!/bin/bash

# Brightness script with redshift toggle
BRIGHTNESS_FILE="/sys/class/backlight/intel_backlight/brightness"
MAX_BRIGHTNESS_FILE="/sys/class/backlight/intel_backlight/max_brightness"

get_brightness() {
    if [ -f "$BRIGHTNESS_FILE" ]; then
        current=$(cat "$BRIGHTNESS_FILE")
        max=$(cat "$MAX_BRIGHTNESS_FILE")
        percentage=$((current * 100 / max))
        echo "$percentage"
    else
        echo "N/A"
    fi
}

get_icon() {
    brightness=$(get_brightness)
    if [ "$brightness" = "N/A" ]; then
        echo "󰃞"
    elif [ "$brightness" -ge 80 ]; then
        echo "󰃞"
    elif [ "$brightness" -ge 60 ]; then
        echo "󰃟"
    elif [ "$brightness" -ge 40 ]; then
        echo "󰃝"
    elif [ "$brightness" -ge 20 ]; then
        echo "󰃚"
    else
        echo "󰃛"
    fi
}

STATE_FILE=/tmp/state_redshift
is_redshift_active() {
    if [ -f $STATE_FILE ]; then
        return 0
    else
        return 1
    fi
}

case "$1" in
    toggle)
        # Toggle redshift (night light)
        if is_redshift_active; then
            redshift -x
            killall redshift
            rm -fr $STATE_FILE
        else
            redshift -o -t 6700:2000 -l 41.13:-8.6
            echo hello > $STATE_FILE
        fi
        ;;
    up)
        # Increase brightness
        brightnessctl set +5%
        ;;
    down)
        # Decrease brightness
        brightnessctl set 5%-
        ;;
    *)
        # Display the module
        icon=$(get_icon)
        brightness=$(get_brightness)

        if is_redshift_active; then
            # Show with night light indicator
            echo "$icon $brightness% 󰌵"
        else
            # Show without night light
            echo "$icon $brightness%"
        fi
        ;;
esac
