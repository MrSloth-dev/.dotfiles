#!/bin/zsh

# List of repository paths
REPOS=(
    "~/.dotfiles/"
    "~/Obsidiandotfiles/"
)
# Function to pull updates for a single repository
pull_repository_updates() {
    local repo_path=$1
    echo "Pulling updates for repository: $repo_path"
    
    if cd "$repo_path"; then
        if git pull; then
            echo "Successfully pulled updates"
        else
            echo "Failed to pull updates"
        fi
    else
        echo "Failed to change to repository directory"
    fi
    
    echo "------------------------"
}

# Main function to process all repositories
update_all_repositories() {
    for repo_path in "${REPOSITORY_PATHS[@]}"; do
        pull_repository_updates "$repo_path"
    done
    
    echo "All repositories processed"
}

# Run the main function
update_all_repositories
