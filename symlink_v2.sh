#!/usr/bin/env bash

RED='\e[31m'
GREEN='\e[33m'
CYAN='\e[36m'
GREEN='\e[32m'
ENDCOLOR='\e[0m'

if [[ $USER == "joao-pol" ]]; then
    PC="Work"
    DOTFILES_DIR="/home/joao-pol/.dotfiles"
    HOME_DIR="/home/joao-pol"
elif [[ $USER == "mrsloth" ]]; then
    PC="Home"
    DOTFILES_DIR="/home/mrsloth/.dotfiles"
    HOME_DIR="/home/mrsloth"
fi

# Function to sync directory contents to dotfiles and create symlink
function sync_and_link() {
    name="$1"
    path="$2"  # relative path from HOME_DIR
    dotfile_path="$3"  # path inside dotfiles directory
    full_path="$HOME_DIR/$path"

    echo -e "${CYAN}Syncing and linking $name${ENDCOLOR}"

    if [[ ! -e "$full_path" ]]; then
        echo -e "${RED}Warning: $full_path does not exist${ENDCOLOR}"
        return
    }

    # If source is a directory
    if [[ -d "$full_path" ]]; then
        # Create directory in dotfiles if it doesn't exist
        mkdir -p "$DOTFILES_DIR/$(dirname "$dotfile_path")"

        # Sync contents to dotfiles directory
        rsync -av --delete "$full_path/" "$DOTFILES_DIR/$dotfile_path/"

        # Remove original and create symlink
        rm -rf "$full_path"
        ln -sf "$DOTFILES_DIR/$dotfile_path" "$full_path"
    else
        # For single files
        mkdir -p "$DOTFILES_DIR/$(dirname "$dotfile_path")"
        cp -f "$full_path" "$DOTFILES_DIR/$dotfile_path"
        ln -sf "$DOTFILES_DIR/$dotfile_path" "$full_path"
    fi
}

if [[ $PC =~ ^(Work|work|WORK)$ ]]; then
    echo -e "${GREEN}Syncing and linking @ Work${ENDCOLOR}\n"
    sync_and_link "Tmux" ".tmux.conf.local" ".tmux.conf.local"
    sync_and_link "Nvim" ".config/nvim" "nvim"
    sync_and_link "Kitty" ".config/kitty" "kitty"
    sync_and_link "Zshrc" ".zshrc" ".zshrc"
    sync_and_link "p10k" ".p10k.zsh" ".p10k.zsh"
elif [[ $PC =~ ^(Home|home|HOME)$ ]]; then
    echo -e "${GREEN}Syncing and linking @ Home${ENDCOLOR}\n"
    sync_and_link "Tmux" ".tmux.conf.local" ".tmux.conf.local"
    sync_and_link "Nvim" ".config/nvim" "nvim"
    sync_and_link "Zshrc" ".zshrc" ".zshrc"
    sync_and_link "p10k" ".p10k.zsh" ".p10k.zsh"
    sync_and_link "Polybar" ".config/polybar" "polybar"
    sync_and_link "i3" ".config/i3" "i3"
    sync_and_link "Rofi" ".config/rofi" "rofi"
    sync_and_link "Kitty" ".config/kitty" "kitty"
else
    echo -e "${RED}Invalid environment: $PC${ENDCOLOR}"
    exit 1
fi
