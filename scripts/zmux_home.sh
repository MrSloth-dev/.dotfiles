#!/bin/zsh

# Check number of args
if [ $# -eq 0 ]; then
	echo "Usage ./zmux <session_name>"
	echo "Sessions Possible :\n config\n particle\n obs"
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
				tmux send-keys -t config_session:$INDEX 'nvim ~/.dotfiles/scripts/zmux.sh' C-m Escape
				(( INDEX++ ))

				tmux new-window -t config_session:$INDEX -n Symlink_Script
				tmux send-keys -t config_session:$INDEX 'nvim ~/.dotfiles/scripts/symlink.sh' C-m
				(( INDEX++ ))
			fi
			;;
		particle)
			if [[ $USER == "mrsloth" ]] && ! session_exists "particle_session"; then
				# Create Session for Project ParticleSimulator
				tmux new-session -d -s particle_session -c ~/Projects/ParticleSimulator/
				
				INDEX=1

				tmux new-window -t particle_session:$INDEX -n MainCode
				tmux rename-window -t particle_session:$INDEX 'MainCode'
				tmux send-keys -t particle_session:$INDEX 'nvim -O ~/Projects/ParticleSimulator/main.c ~/Projects/ParticleSimulator/particles.c' C-m
				(( INDEX++ ))

				tmux new-window -t particle_session:$INDEX -n Testing
				tmux send-keys -t particle_session:$INDEX 'cd ~/Projects/ParticleSimulator/' C-m
				tmux send-keys -t config_session:$INDEX 'clear' C-m
				(( INDEX++ ))

				tmux attach-session -t particle_session
			fi
			;;
		obs)
			if [[ $USER == "mrsloth" ]] && ! session_exists "obsidian_session"; then
				# Create Session for Obsidian Notes!
				tmux new-session -d -s obsidian_session -c ~/ObsidianNotes/
				INDEX=1

				tmux new-window -t obsidian_session:$INDEX -n MainNotes
				tmux rename-window -t obsidian_session:$INDEX 'MainNotes'
				tmux send-keys -t obsidian_session:$INDEX 'nvim ~/ObsidianNotes/' C-m
				(( INDEX++ ))

				tmux attach-session -t obsidian_session:1
			fi
			;;
		*)
			echo "Unknown Session: $SESSION_NAME"
			echo "Sessions Possible :\nconfig\nparticle\nobs"
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
