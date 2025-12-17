
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
coverage_test() {
	if [[ -n $1 ]]; then
		docker exec api bash -c "coverage run --source='.' manage.py test $1" &&
			docker exec api bash -c "coverage html" && rm -fr htmlcov && docker cp api:/home/app/htmlcov . && firefox htmlcov/index.html
	else
		echo "Which app?"
	fi
	}

  fh() {
      local selected=$(history | cut -c7- | grep -vE '^#'| awk '!seen[$0]++' | fzf --tac --tiebreak=index --expect=esc)
      local key=$(echo "$selected" | head -1)
      local cmd=$(echo "$selected" | tail -n +2)

      if [ -n "$cmd" ]; then
          if [ "$key" = "esc" ]; then
              print -s "$cmd"
              print -z "$cmd"
          else
              eval "$cmd"
              print -s "$cmd"
          fi
      fi
  }

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
	addpath $HOME/.bin/nvim/bin
	cowsay "Welcome to Zmux"
fi

#Common Settings
#
export ZSH="$HOME/.oh-my-zsh"
export ZSHRC="$HOME/.zshrc"
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
export EDITOR="nvim"
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
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
alias recordStart='ffmpeg -f x11grab -video_size 1920x1080 -framerate 25 -i :0 -f pulse -i @DEFAULT_SINK@.monitor -c:v libx264 -preset fast -crf 23 -c:a aac -b:a 128k -pix_fmt yuv420p screen.mp4 > /dev/null 2>&1'
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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
