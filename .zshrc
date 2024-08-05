#Zshrc with 2 places
#
#Common Settings
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="crunch" # set by `omz`
source $ZSH/oh-my-zsh.sh
alias zmux="~/.dotfiles/zmux.sh"
export TERM="xterm-256color"
export EDITOR="vim"
#WorkSettings
if [[ $USER == "joao-pol" ]]; then
	export PATH="$PATH:/home/joao-pol/.local/share/homebrew/bin"
	export PATH="$PATH:/home/joao-pol/"
	plugins=(git)
	export MAIL=joao-pol@students.42porto.com
	export USER=joao-pol
	alias nvim="flatpak run io.neovim.nvim"
	alias nvim.="flatpak run io.neovim.nvim **/*"
	alias pu="cd ~/CommonCore/2.push_swap/"
	alias pi="cd ~/CommonCore/2.pipex/"
	alias fr="cd ~/CommonCore/2.1fract-ol/"
	alias ph="cd ~/CommonCore/3.philo/philo"
	alias zmux="~/.dotfiles/zmux.sh"
	compdef nvim=vim
	setopt complete_aliases
	source <(fzf --zsh)
	export HOMEBREW_NO_AUTO_UPDATE=1
fi
#Home Settings
if [[ $USER == "mrsloth" ]]; then
	export PATH="$PATH:/home/mrsloth/.cargo/bin"
	alias zmux="~/.dotfiles/zmux_home.sh"
	cowsay "Hello Sloth"
fi
