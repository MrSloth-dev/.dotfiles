  #!/usr/bin/env bash

  # Resolution configuration
  EDEP_1_RES="1920x1200"
  DP_1_RES="2560x1440"
  HDMI_1_RES="2560x1440"

  # Calculate positions based on resolutions
  DP_1_WIDTH=2560
  HDMI_1_WIDTH=2560

  if [[ ! $(command -v xrandr) ]]; then
      echo "cannot run without xrandr"
      exit 1
  fi

  run_xrandr_dual() {
      # Detect which external monitor is connected
      if xrandr | grep "HDMI-1 connected" &> /dev/null; then
          xrandr --output HDMI-1 --mode "$HDMI_1_RES" --primary --pos ${DP_1_WIDTH}x0 \
                 --output eDP-1 --mode "$EDEP_1_RES" --pos $((DP_1_WIDTH + HDMI_1_WIDTH))x0 --auto &> /dev/null
      elif xrandr | grep "DP-1 connected" &> /dev/null; then
          xrandr --output DP-1 --mode "$DP_1_RES" --primary --pos 0x0 \
                 --output eDP-1 --mode "$EDEP_1_RES" --pos ${DP_1_WIDTH}x0 --auto &> /dev/null
      else
          return 1
      fi
  }

  run_xrandr_triple() {
      # When both external monitors are connected
      if xrandr | grep "HDMI-1 connected" &> /dev/null && xrandr | grep "DP-1 connected" &> /dev/null; then
          # HDMI-1 is primary, DP-1 on left, eDP-1 (laptop) on right
          xrandr --output DP-1 --mode "$DP_1_RES" --pos 0x0 \
                 --output HDMI-1 --mode "$HDMI_1_RES" --primary --pos ${DP_1_WIDTH}x0 \
                 --output eDP-1 --mode "$EDEP_1_RES" --pos $((DP_1_WIDTH + HDMI_1_WIDTH))x0 --auto &> /dev/null
      else
          return 1
      fi
  }

  if run_xrandr_triple; then
      echo "setup complete with triple screen"
  elif run_xrandr_dual; then
      echo "setup complete with dual screen"
  else
      xrandr --auto
      echo "setup complete with single screen"
  fi

  i3-msg restart
