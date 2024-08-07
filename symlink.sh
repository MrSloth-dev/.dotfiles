#!/bin/zsh

RED='\e[31m'
GREEN='\e[33m'
CYAN='\e[36m'
GREEN='\e[32m'
ENDCOLOR='\e[0m'


echo -e "${GREEN}Work or Home?${ENDCOLOR}"
read PC

# Generic Function to symlink
function symlink {
  name="$1"
  dotfile_path="$2"
  link_path="$3"
	echo -e "${CYAN}Symlink $name?[Y/n]${ENDCOLOR}"
	read answer
	if [[ $answer =~ ^(Y|y|yes|Yes|YES)$ ]]; then
		echo -e "${CYAN}Symlinking $name to $link_path${ENDCOLOR}"
		cp -sf -r "$dotfile_path" "$link_path"
		echo -e "${GREEN}Symlink $name Done!${ENDCOLOR}"
	else
		echo -e "${RED}Skipping $name${ENDCOLOR}"
  fi
}



if [[ $PC =~ ^(Work|work|WORK)$ ]]; then
	echo -e "${GREEN}Syslinking @ Work${ENDCOLOR}\n" 
	symlink "Tmux" "/home/joao-pol/.dotfiles/.tmux.conf.local" "/home/joao-pol/.tmux.conf.local"
	symlink "Nvim" "/home/joao-pol/.dotfiles/nvim/" "/home/joao-pol/.var/app/io.neovim.nvim/config/"
	symlink "Zshrc" "/home/joao-pol/.dotfiles/.zshrc" "/home/joao-pol/.zshrc"
elif [[ $PC =~ ^(Home|home|HOME)$ ]]; then
	echo -e "${GREEN}Syslinking @ Home${ENDCOLOR}\n" 
	symlink "Tmux" "/home/mrsloth/.dotfiles/.tmux.conf.local" "/home/mrsloth/.tmux.conf.local"
	symlink "Nvim" "/home/mrsloth/.dotfiles/nvim/" "/home/mrsloth/.config/"
	symlink "Zshrc" "/home/mrsloth/.dotfiles/.zshrc" "/home/mrsloth/.zshrc"
	symlink "Polybar" "/home/mrsloth/.dotfiles/polybar/" "/home/mrsloth/.config/"
	symlink "Picom" "/home/mrsloth/.dotfiles/picom/" "/home/mrsloth/.config/"
	symlink "i3" "/home/mrsloth/.dotfiles/i3/" "/home/mrsloth/.config/"
	symlink "Rofi" "/home/mrsloth/.dotfiles/rofi/" "/home/mrsloth/.config/"
	symlink "Wallpaper" "/home/mrsloth/.dotfiles/ginko.jpg" "/home/mrsloth/Downloads/ginko.jpg"
else
	echo -e"${RED}Choose Work or Home${ENDCOLOR}\n"
fi
