#!/usr/bin/env bash

if [[ ! $(command xrandr) ]]; then
    echo "cannot run without xrandr"
    exit 1
fi
run_xrandr_dual() {
    xrandr --output eDP-1 --mode 1920x1200 --primary --pos 1920x0 --output DP-1 --mode 1920x1080 --pos 0x0 --auto &> /dev/null
}

if run_xrandr_dual; then
    echo "setup complete with dual screen"
else
    xrandr --auto
    echo "setup complete with single screen"
fi
i3 restart


