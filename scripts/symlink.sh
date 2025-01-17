#!/usr/bin/env bash

RED='\e[31m'
GREEN='\e[33m'
CYAN='\e[36m'
GREEN='\e[32m'
ENDCOLOR='\e[0m'


# echo -e "${GREEN}Work or Home?${ENDCOLOR}"
# read PC
if [[ $USER == "joao-pol" ]]; then
	PC="Work"
	HOME_DIR="/home/joao-pol/"
	DOT_DIR="/home/joao-pol/.dotfiles"
elif [[ $USER == "mrsloth" ]]; then
	PC="Home"
	HOME_DIR="/home/mrsloth/"
	DOT_DIR="/home/mrsloth/.dotfiles"
fi

# Generic Function to symlink
function symlink {
  name="$1"
  dotfile_path="$2"
  link_path="$3"
  echo -e "${CYAN}Symlinking $name to $link_path${ENDCOLOR}"
  cp -sf -r "$dotfile_path" "$link_path"
}



if [[ $PC =~ ^(Work|work|WORK)$ ]]; then
	echo -e "${GREEN}Syslinking @ Work${ENDCOLOR}\n" 
	symlink "Tmux" "/home/joao-pol/.dotfiles/.tmux.conf.local" "/home/joao-pol/.tmux.conf.local"
	symlink "Nvim" "/home/joao-pol/.dotfiles/nvim/" "/home/joao-pol/.config/"
	symlink "Kitty" "/home/mrsloth/.dotfiles/kitty/" "/home/mrsloth/.config/"
	symlink "Zshrc" "/home/joao-pol/.dotfiles/.zshrc" "/home/joao-pol/.zshrc"
	symlink "p10k" "/home/joao-pol/.dotfiles/.p10k.zsh" "/home/joao-pol/.p10k.zsh"
elif [[ $PC =~ ^(Home|home|HOME)$ ]]; then
	echo -e "${GREEN}Syslinking @ Home${ENDCOLOR}\n" 
	symlink "Tmux" "/home/mrsloth/.dotfiles/.tmux.conf.local" "/home/mrsloth/.tmux.conf.local"
	symlink "Nvim" "/home/mrsloth/.dotfiles/nvim/" "/home/mrsloth/.config/"
	symlink "Zshrc" "/home/mrsloth/.dotfiles/.zshrc" "/home/mrsloth/.zshrc"
	symlink "p10k" "/home/mrsloth/.dotfiles/.p10k.zsh" "/home/mrsloth/.p10k.zsh"
	symlink "Polybar" "/home/mrsloth/.dotfiles/polybar/" "/home/mrsloth/.config/"
	symlink "i3" "/home/mrsloth/.dotfiles/i3/" "/home/mrsloth/.config/"
	symlink "Rofi" "/home/mrsloth/.dotfiles/rofi/" "/home/mrsloth/.config/"
	symlink "Kitty" "/home/mrsloth/.dotfiles/kitty/" "/home/mrsloth/.config/"
else
	echo -e"${RED}Choose Work or Home${ENDCOLOR}\n"
fi
