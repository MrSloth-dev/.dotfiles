# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

#Zshrc with 2 places
#
addpath () {
	if [[ ! "${PATH}"  =~ "${1}" ]]; then
		export PATH=$PATH:$1;
	fi

}

#WorkSettings
if [[ $USER == "joao-pol" ]]; then
	addpath $HOME/sgoinfre/homebrew/bin
	addpath /usr/local/bin
	export MAIL=joao-pol@students.42porto.com
	export USER=joao-pol
	export HOMEBREW_NO_AUTO_UPDATE=1
elif [[ $USER == "mrsloth" ]]; then
	alias penv="source ~/.pythonenv/bin/activate"
	addpath $HOME/.cargo/bin
	addpath $HOME/.zig
	addpath $HOME/go/bin
	cowsay "Welcome to Zmux"
fi

#Common Settings
#
export ZSH="$HOME/.oh-my-zsh"
export ZSHRC="$HOME/.zshrc"
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
export EDITOR="nvim"
alias so="source $ZSHRC"
ZSH_THEME="crunch" # set by `omz`
alias tk="~/.dotfiles/scripts/tmux_kill.sh"
alias lg="lazygit"
alias sym="~/.dotfiles/scripts/symlink.sh"
alias obs="nvim ~/ObsidianNotes/"
alias upup=" cd ~/.dotfiles/ && git add . && git commit -m 'update' && git push && cd -"

#similar to arrow keys
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

plugins=(git)

addpath $HOME/.local/bin

eval "$(zoxide init zsh)"


source ~/.powerlevel10k/powerlevel10k.zsh-theme
source $ZSH/oh-my-zsh.sh
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
