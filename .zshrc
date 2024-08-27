#Zshrc with 2 places
#
#Common Settings
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="crunch" # set by `omz`
source $ZSH/oh-my-zsh.sh
alias tk="tmux kill-server"
alias sym="~/.dotfiles/scripts/symlink.sh"
alias obs="nvim ~/ObsidianNotes/"
export TERM="xterm-256color"
export EDITOR="vim"
#WorkSettings
if [[ $USER == "joao-pol" ]]; then
	export PATH="$PATH:/home/joao-pol/.local/share/homebrew/bin"
	export PATH="$PATH:/home/joao-pol/"
	export PATH="$PATH:/home/joao-pol/.local/bin"
	plugins=(git)
	export MAIL=joao-pol@students.42porto.com
	export USER=joao-pol
	alias nvim="flatpak run io.neovim.nvim"
	alias nvim.="flatpak run io.neovim.nvim **/*"
	alias pu="cd ~/CommonCore/2.push_swap/"
	alias pi="cd ~/CommonCore/2.pipex/"
	alias fr="cd ~/CommonCore/2.1fract-ol/"
	alias ph="cd ~/CommonCore/3.philo/philo"
	alias zmux="~/.dotfiles/scripts/zmux.sh"
	compdef nvim=vim
	setopt complete_aliases
	export HOMEBREW_NO_AUTO_UPDATE=1
	# Raylib
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/sgoinfre/raylib-master/
fi
#Home Settings
if [[ $USER == "mrsloth" ]]; then
	alias penv="source ~/PythonEnv/bin/activate"
	export PATH="$PATH:/home/mrsloth/.cargo/bin"
	alias zmux="~/.dotfiles/scripts/zmux_home.sh"
	cowsay "Hello Sloth"
fi
