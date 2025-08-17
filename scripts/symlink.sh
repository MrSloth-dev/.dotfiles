#!/usr/bin/env bash

RED='\e[31m'
GREEN='\e[33m'
CYAN='\e[36m'
GREEN='\e[32m'
ENDCOLOR='\e[0m'


# echo -e "${GREEN}Work or Home?${ENDCOLOR}"
# read PC
if [[ $USER == "jab" ]]; then
	PC="Work"
	HOME_DIR="/home/jab/"
	DOT_DIR="/home/jab/.dotfiles"
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
	symlink "Tmux" "/home/jab/.dotfiles/.tmux.conf.local" "/home/jab/.tmux.conf.local"
	symlink "Nvim" "/home/jab/.dotfiles/nvim/" "/home/jab/.config/"
	symlink "Kitty" "/home/jab/.dotfiles/kitty/" "/home/jab/.config/"
	symlink "Ghostty" "/home/jab/.dotfiles/ghostty/" "/home/jab/.config/"
	symlink "Zshrc" "/home/jab/.dotfiles/.zshrc" "/home/jab/.zshrc"
	symlink "i3" "/home/jab/.dotfiles/i3/" "/home/jab/.config/"
	symlink "Rofi" "/home/jab/.dotfiles/rofi/" "/home/jab/.config/"
	symlink "Polybar" "/home/jab/.dotfiles/polybar/" "/home/jab/.config/"
	# symlink "p10k" "/home/jab/.dotfiles/.p10k.zsh" "/home/jab/.p10k.zsh"
	# symlink "Zmux" "/home/jab/.dotfiles/zmux/" "/home/jab/.config/"
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
	symlink "Zmux" "/home/mrsloth/.dotfiles/zmux/" "/home/mrsloth/.config/"
else
	echo -e"${RED}Choose Work or Home${ENDCOLOR}\n"
fi
