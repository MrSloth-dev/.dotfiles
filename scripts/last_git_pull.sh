#!/bin/zsh

LAST_PULL_FILE="$HOME/.dotfiles/.last_git_pull"
REPO_PATH="/home/joao-pol/.dotfiles/"

# Check if the file exists and if the last pull was today
if [ ! -f "$LAST_PULL_FILE" ] || [ "$(cat "$LAST_PULL_FILE")" != "$(date +%Y-%m-%d)" ]; then
    cd "$REPO_PATH" && git pull
    date +%Y-%m-%d > "$LAST_PULL_FILE"
fi
