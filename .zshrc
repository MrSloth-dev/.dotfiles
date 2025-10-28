
## Functions
addpath () {
	if [[ ! "${PATH}"  =~ "${1}" ]]; then
		export PATH=$PATH:$1;
	fi

}
mkcdir() {
	mkdir -p $1 && 
	cd -P $1
}

bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

#Settings based on user
if [[ $USER == "joao-pol" ]]; then
	addpath $HOME/sgoinfre/homebrew/bin
	addpath /usr/.local/bin
	export MAIL=joao-pol@students.42porto.com
	# export USER=joao-pol
	export HOMEBREW_NO_AUTO_UPDATE=1
	addpath $HOME/miniconda3/bin
elif [[ $USER == "jab" ]]; then
	addpath /usr/.local/bin
	addpath ~/yazi
	export MAIL=joao-pol@students.42porto.com
	# export USER=joao-pol
	addpath /opt/nvim-linux-x86_64/bin
	cowsay "Hi here!"
elif [[ $USER == "mrsloth" ]]; then
	alias penv="source .venv/bin/activate"
	addpath $HOME/.cargo/bin
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
ZSH_THEME="powerlevel10k/powerlevel10k" # set by `omz`
alias tk="~/.dotfiles/scripts/tmux_kill.sh"
alias lg="lazygit"
alias sym="~/.dotfiles/scripts/symlink.sh"
alias obs="nvim ~/ObsidianNotes/"
alias upup=" cd ~/.dotfiles/ && git add . && git commit -m 'update' && git push && cd -"

plugins=(git)
addpath $HOME/.local/bin
addpath $HOME/.zig
addpath /usr/local/go/bin


eval "$(zoxide init zsh)"


source $ZSH/oh-my-zsh.sh
alias lzd=lazydocker
# include ~/.local/bin in PATH
[[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && export PATH="$HOME/.local/bin:$PATH"
export LD_LIBRARY_PATH=/usr/lib:/usr/lib:
export MANPAGER='nvim +Man! '
alias screenKey='screenkey -t 0.5 -s small --no-whitespace --persist &'
alias recordStart='ffmpeg -f x11grab -video_size 1920x1080 -framerate 25 -i :0 -f alsa -i default -c:v libx264 -preset ultrafast -c:a aac screen.mp4 > /dev/null'
alias recordStop='kill screenkey ffmpeg'
alias sman='man -k . | fzf | cut -d" " -f1 | xargs man'
alias setupscreen='bash ~/.dotfiles/scripts/setupscreen.sh'
alias vim=nvim
alias python=python3
alias venv='source .venv/bin/activate'


bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
