#Zshrc with 2 places
#
#Common Settings
export ZSH="$HOME/.oh-my-zsh"
export ZSHRC="$HOME/.zshrc"
alias so="source $ZSHRC"
ZSH_THEME="crunch" # set by `omz`
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
source $ZSH/oh-my-zsh.sh
alias tk="~/.dotfiles/scripts/tmux_kill.sh"
alias lg="lazygit"
alias zig="~/.local/bin/zig/zig"
alias sym="~/.dotfiles/scripts/symlink.sh"
alias obs="nvim ~/ObsidianNotes/"
export EDITOR="nvim"
alias upup="git add . && git commit -m 'update' && git push"

#WorkSettings
if [[ $USER == "joao-pol" ]]; then
	export PATH="$PATH:/home/joao-pol/sgoinfre/homebrew/bin"
	export PATH="$PATH:/usr/local/bin"
	export PATH="$PATH:/home/joao-pol/"
	export PATH="$PATH:/home/joao-pol/.local/bin"
	plugins=(git)
	export MAIL=joao-pol@students.42porto.com
	export USER=joao-pol
	export HOMEBREW_NO_AUTO_UPDATE=1
	eval "$(zoxide init zsh)"
fi
#Home Settings
if [[ $USER == "mrsloth" ]]; then
	alias penv="source ~/.pythonenv/bin/activate"
	export PATH="$PATH:/home/mrsloth/.cargo/bin"
	export PATH="$PATH:/usr/local/zig"
	export PATH="$PATH:$HOME/go/bin"
	export PATH="$PATH:/home/mrsloth/.local/bin"
	cowsay "Hello Sloth"
	eval "$(zoxide init zsh)"
fi

