#!/usr/bin/env bash

RED='\e[31m'
GREEN='\e[33m'
CYAN='\e[36m'
GREEN='\e[32m'
ENDCOLOR='\e[0m'
HOSTNAME=$(cat /etc/hostname)


# echo -e "${GREEN}Work or Home?${ENDCOLOR}"
# read PC
if [[ $USER == "$USER" ]]; then
	PC="Work"
	HOME_DIR="/home/$USER/"
	DOT_DIR="/home/$USER/.dotfiles"
elif [[ $USER == "joao-pol" ]]; then
	PC="Work"
	HOME_DIR="/home/joao-pol/"
	DOT_DIR="/home/joao-pol/.dotfiles"
elif [[ $USER == "mrsloth" ]]; then
	PC="Home"
	HOME_DIR="/home/mrsloth/"
	DOT_DIR="/home/mrsloth/.dotfiles"
elif [[ $USER == "mrsloth" || $HOST == "SlothPi" ]]; then
	PC="Pi"
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
	symlink "Tmux" "/home/$USER/.dotfiles/.tmux.conf.local" "/home/$USER/.tmux.conf.local"
	symlink "Nvim" "/home/$USER/.dotfiles/nvim/" "/home/$USER/.config/"
	symlink "Kitty" "/home/$USER/.dotfiles/kitty/" "/home/$USER/.config/"
	symlink "Ghostty" "/home/$USER/.dotfiles/ghostty/" "/home/$USER/.config/"
	symlink "Zshrc" "/home/$USER/.dotfiles/.zshrc" "/home/$USER/.zshrc"
	symlink "i3" "/home/$USER/.dotfiles/i3/" "/home/$USER/.config/"
	symlink "Rofi" "/home/$USER/.dotfiles/rofi/" "/home/$USER/.config/"
	symlink "Polybar" "/home/$USER/.dotfiles/polybar/" "/home/$USER/.config/"
	# symlink "p10k" "/home/$USER/.dotfiles/.p10k.zsh" "/home/$USER/.p10k.zsh"
	# symlink "Zmux" "/home/$USER/.dotfiles/zmux/" "/home/$USER/.config/"
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
elif [[ $PC =~ ^(Pi)$ ]]; then
	echo -e "${GREEN}Syslinking @ Pi${ENDCOLOR}\n" 
	symlink "Zshrc" "/home/mrsloth/.dotfiles/.zshrc" "/home/mrsloth/.zshrc"
else
	echo -e"${RED}Choose Work or Home${ENDCOLOR}\n"
fi
