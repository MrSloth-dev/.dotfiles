#!/bin/bash


save_neovim() {
    local session=$1
    local window=$2
    local pane=$3
    tmux send-keys -t "$session:$window.$pane" Escape ":wa" Enter
    sleep 1
}

is_neovim_running() {
    local session=$1
    local window=$2
    local pane=$3
    local pane_pid=$(tmux list-panes -t "$session:$window.$pane" -F "#{pane_pid}")
    if pgrep -P "$pane_pid" -f "[n]vim" > /dev/null; then
        ((count++))
        return 0  # Neovim is running
    else
        return 1  # Neovim is not running
    fi
}
if [[ $(pgrep tmux) ]] &>/dev/null ;   then
    for session in $(tmux list-sessions -F "#{session_name}"); do
        for window in $(tmux list-windows -t "$session" -F "#{window_index}"); do
            for pane in $(tmux list-panes -t "$session:$window" -F "#{pane_index}"); do
                # Check if Neovim is running in this pane
                if is_neovim_running "$session" "$window" "$pane"; then
                    echo "Neovim instance found in session $session, window $window, pane $pane. Saving..."
                    save_neovim "$session" "$window" "$pane"
                fi
            done
        done
    done

    if [[ count -ne 0 ]]; then 
        echo "All Neovim instances saved. Killing tmux server..."
    else
        echo "No Neovim instances Found. Killing tmux server..."
    fi

    tmux kill-server
else
  echo "Tmux is not running."
  exit 1;
fi
