!/bin/zsh

# Check number of args
if [ $# -eq 0 ]; then
	echo "Usage ./zmux <session_name>"
	echo "Sessions Possible :\nconfig\nphilo\npush\npipex"
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

				# Create Windows
				tmux new-window -t config_session:1
				tmux rename-window -t config_session:1 'Tmux_Config_Local'
				tmux send-keys -t config_session:1 'nvim ~/.tmux.conf.local' C-m

				tmux new-window -t config_session:2 -n Nvim_init_lua
				tmux send-keys -t config_session:2 'nvim ~/.var/app/io.neovim.nvim/config/nvim/init.lua' C-m

				tmux new-window -t config_session:3 -n Zmux_Script
				tmux send-keys -t config_session:3 'nvim ~/.dotfiles/tmux.sh' C-m

				tmux new-window -t config_session:4 -n Symlink_Script
				tmux send-keys -t config_session:4 'nvim ~/.dotfiles/symlink.sh' C-m
			fi
			;;
		philo)
			if ! session_exists "philo_session"; then
				# Create Session for Project Philosophers
				tmux new-session -d -s philo_session -c ~/CommonCore/2.philo/philo

				tmux new-window -t philo_session:1 -n MainCode
				tmux rename-window -t philo_session:1 'MainCode'
				tmux send-keys -t philo_session:1 'nvim -O ~/CommonCore/3.philo/philo/src/main.c ~/CommonCore/3.philo/philo/includes/philo.h' C-m

				tmux new-window -t philo_session:2 -n Testing
				tmux send-keys -t philo_session:2 '~/CommonCore/3.philo/philo/' C-m

				tmux attach-session -t philo_session
			fi
			;;
		pipex)
			if ! session_exists "pipex_session"; then
				# Create Session for Project Philosophers
				tmux new-session -d -s pipex_session -c ~/CommonCore/2.pipex/

				tmux new-window -t pipex_session:1 -n MainCode
				tmux rename-window -t pipex_session:1 'MainCode'
				tmux send-keys -t pipex_session:1 'nvim -O ~/CommonCore/2.pipex/src/main.c ~/CommonCore/2.pipex/includes/pipex.h' C-m

				tmux new-window -t pipex_session:2 -n Testing
				tmux send-keys -t pipex_session:2 '~/CommonCore/2.pipex/'

				tmux attach-session -t pipex_session
			fi
			;;
		push)
			if ! session_exists "push_session"; then
				# Create Session for Project Philosophers
				tmux new-session -d -s push_session -c ~/CommonCore/2.push_swap/

				tmux new-window -t push_session:1 -n MainCode
				tmux rename-window -t push_session:1 'MainCode'
				tmux send-keys -t push_session:1 'nvim -O ~/CommonCore/2.push_swap/src/main.c ~/CommonCore/2.push_swap/src/push_swap.h' C-m

				tmux new-window -t push_session:2 -n Testing
				tmux send-keys -t push_session:2 '~/CommonCore/2.push_swap/'

				tmux attach-session -t push_session
			fi
			;;
		*)
			echo "Unknown Session: $SESSION_NAME"
			echo "Sessions Possible :\nconfig\nphilo\npush\npipex"
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
