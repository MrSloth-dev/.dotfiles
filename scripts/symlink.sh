#!/usr/bin/env bash

RED='\e[31m'
GREEN='\e[33m'
CYAN='\e[36m'
GREEN='\e[32m'
ENDCOLOR='\e[0m'
HOSTNAME=$(cat /etc/hostname)


# echo -e "${GREEN}Work or Home?${ENDCOLOR}"
# read PC
if [[ $HOSTNAME == "Levelho" ]]; then
	PC="Home"
	HOME_DIR="/home/$USER/"
	DOT_DIR="/home/$USER/.dotfiles"
fi

# Generic Function to symlink
function symlink {
  name="$1"
  dotfile_path="$2"
  link_path="$3"
  echo -e "${CYAN}Symlinking $name to $link_path${ENDCOLOR}"
  ln -sfn "$dotfile_path" "$link_path"
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
	symlink "better-commits" "/home/$USER/.dotfiles/.better-commits.json" "/home/$USER/.better-commits.json"
	# symlink "p10k" "/home/$USER/.dotfiles/.p10k.zsh" "/home/$USER/.p10k.zsh"
	# symlink "Zmux" "/home/$USER/.dotfiles/zmux/" "/home/$USER/.config/"
elif [[ $PC =~ ^(Home|home|HOME)$ ]]; then
	echo -e "${GREEN}Syslinking @ Home${ENDCOLOR}\n"
	symlink "Fontconfig" "$DOT_DIR/fontconfig/" "$HOME_DIR.config/"
	symlink "Git" "$DOT_DIR/git/" "$HOME_DIR.config/"
	symlink "Hypr" "$DOT_DIR/hypr/" "$HOME_DIR.config/"
	symlink "Nvim" "$DOT_DIR/nvim/" "$HOME_DIR.config/"
	symlink "Kitty" "$DOT_DIR/kitty/" "$HOME_DIR.config/"
	symlink "Omarchy" "$DOT_DIR/omarchy/" "$HOME_DIR.config/"
	symlink "Opencode" "$DOT_DIR/opencode/" "$HOME_DIR.config/"
	symlink "Tmux" "$DOT_DIR/tmux/" "$HOME_DIR.config/"
	symlink "Ruff" "$DOT_DIR/ruff.toml" "$HOME_DIR.config/ruff.toml"
	symlink "Starship" "$DOT_DIR/starship.toml" "$HOME_DIR.config/starship.toml"
elif [[ $PC =~ ^(Pi)$ ]]; then
	echo -e "${GREEN}Syslinking @ Pi${ENDCOLOR}\n" 
	symlink "Zshrc" "/home/mrsloth/.dotfiles/.zshrc" "/home/mrsloth/.zshrc"
else
	echo -e"${RED}Choose Work or Home${ENDCOLOR}\n"
fi
