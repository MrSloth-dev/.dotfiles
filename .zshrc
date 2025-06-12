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
	export USER=joao-pol
	export HOMEBREW_NO_AUTO_UPDATE=1
	addpath $HOME/miniconda3/bin
elif [[ $USER == "mrsloth" ]]; then
	alias penv="source .venv/bin/activate"
	addpath $HOME/.cargo/bin
	addpath $HOME/go/bin
	addpath $HOME/miniconda3/bin
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


eval "$(zoxide init zsh)"


source $ZSH/oh-my-zsh.sh
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
alias lzd=lazydocker
# include ~/.local/bin in PATH
[[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && export PATH="$HOME/.local/bin:$PATH"
export LD_LIBRARY_PATH=/usr/lib:/usr/lib:
export MANPAGER='nvim +Man! '
alias pls="sudo pacman -S"
alias screenKey='screenkey -t 0.5 -s small --no-whitespace --persist &'
alias recordStart='ffmpeg -f x11grab -video_size 1920x1080 -framerate 25 -i :0 -f alsa -i default -c:v libx264 -preset ultrafast -c:a aac screen.mp4 > /dev/null'
alias recordStop='kill screenkey ffmpeg'
alias sman='man -k . | fzf | cut -d" " -f1 | xargs man'
export XDG_CACHE_HOME="$HOME/goinfre/.cache"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/mrsloth/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/mrsloth/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/mrsloth/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/mrsloth/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search
