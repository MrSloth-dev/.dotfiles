#!/bin/zsh

# Check number of args
if [ $# -eq 0 ]; then
	echo "Usage ./zmux <session_name>"
	echo "Sessions Possible :\n config\n philo\n push\n pipex\nobs"
	exit 1
fi

SESSION_NAME=$1

# Simple function to check is session exists throught redirection of error output to discard return 0 if no error
session_exists() 
{
	tmux has-session -t "$1" 2>/dev/null
}
# Switch Case for arguments. Cycle through the arguments and for each case, opens a session in tmux
for SESSION_NAME in "$@"; do
	case "$SESSION_NAME" in
		config)
			if ! session_exists "config_session"; then
				# First tmux session: editing configuration files
				tmux new-session -d -s config_session

				INDEX=1

				# Create Windows
				tmux new-window -t config_session:$INDEX
				tmux rename-window -t config_session:$INDEX 'Tmux_Config_Local'
				tmux send-keys -t config_session:$INDEX 'nvim ~/.dotfiles/.tmux.conf.local' C-m
				(( INDEX++ ))

				tmux new-window -t config_session:$INDEX -n Nvim_init_lua
				tmux send-keys -t config_session:$INDEX 'nvim ~/.dotfiles/nvim/init.lua' C-m
				(( INDEX++ ))

				tmux new-window -t config_session:$INDEX -n Zmux_Script
				tmux send-keys -t config_session:$INDEX 'nvim ~/.dotfiles/scripts/zmux.sh' C-m
				(( INDEX++ ))

				tmux new-window -t config_session:$INDEX -n Symlink_Script
				tmux send-keys -t config_session:$INDEX 'nvim ~/.dotfiles/scripts/symlink.sh' C-m
				(( INDEX++ ))
			fi
			;;
		philo)
			if [[ $USER == "joao-pol" ]] && ! session_exists "philo_session"; then
				# Create Session for Project Philosophers
				tmux new-session -d -s philo_session -c ~/CommonCore/3.philo/philo/
				
				INDEX=1

				tmux new-window -t philo_session:$INDEX -n MainCode
				tmux rename-window -t philo_session:$INDEX 'MainCode'
				tmux send-keys -t philo_session:$INDEX 'nvim -O ~/CommonCore/3.philo/philo/src/main.c ~/CommonCore/3.philo/philo/includes/philo.h' C-m
				(( INDEX++ ))

				tmux new-window -t philo_session:$INDEX -n Testing
				tmux send-keys -t philo_session:$INDEX 'cd ~/CommonCore/3.philo/philo/' C-m
				(( INDEX++ ))

				tmux attach-session -t philo_session:1
			fi
			;;
		pipex)
			if  ! session_exists "pipex_session"; then
				# Create Session for Project Pipex
				tmux new-session -d -s pipex_session -c ~/CommonCore/2.pipex/

				INDEX=1

				tmux new-window -t pipex_session:$INDEX -n MainCode
				tmux rename-window -t pipex_session:$INDEX 'MainCode'
				tmux send-keys -t pipex_session:$INDEX 'nvim -O ~/CommonCore/2.pipex/src/main.c ~/CommonCore/2.pipex/includes/pipex.h' C-m
				(( INDEX++ ))

				tmux new-window -t pipex_session:$INDEX -n Testing
				tmux send-keys -t pipex_session:$INDEX '~/CommonCore/2.pipex/' C-m
				(( INDEX++ ))

				tmux attach-session -t pipex_session:1
			fi
			;;
		push)
			if  [$USER == "joao-pol"] && ! session_exists "push_session"; then
				# Create Session for Project Push_Swap
				tmux new-session -d -s push_session -c ~/CommonCore/2.push_swap/
				INDEX=1

				tmux new-window -t push_session:$INDEX -n MainCode
				tmux rename-window -t push_session:$INDEX 'MainCode'
				tmux send-keys -t push_session:$INDEX 'nvim -O ~/CommonCore/2.push_swap/src/main.c ~/CommonCore/2.push_swap/src/push_swap.h' C-m
				(( INDEX++ ))

				tmux new-window -t push_session:$INDEX -n Testing
				tmux send-keys -t push_session:$INDEX '~/CommonCore/2.push_swap/' C-m
				(( INDEX++ ))

				tmux attach-session -t push_session:1
			fi
			;;
		obs)
			if  ! session_exists "obsidian_session"; then
				# Create Session for ObsidianNotes
				tmux new-session -d -s obsidian_session -c ~/ObsidianNotes/

				INDEX=1

				tmux new-window -t obsidian_session:$INDEX -n MainNotes
				tmux rename-window -t obsidian_session:$INDEX 'MainNotes'
				tmux send-keys -t obsidian_session:$INDEX 'nvim -O ~/ObsidianNotes/' C-m
				(( INDEX++ ))

				tmux attach-session -t obsidian_session:1
			fi
			;;
		*)
			echo "Unknown Session: $SESSION_NAME"
			echo "Sessions Possible :\nconfig\nphilo\npush\npipex\nobs"
			;;
	esac
done

# Attach to the first session created
if [ $# -gt 0 ]; then
    FIRST_SESSION=$1
    if session_exists "$FIRST_SESSION"; then
        tmux attach-session -t "$FIRST_SESSION"
    else
        echo "Session '$FIRST_SESSION' does not exist."
    fi
fi