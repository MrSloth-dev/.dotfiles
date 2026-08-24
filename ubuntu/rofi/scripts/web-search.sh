#!/usr/bin/env bash

## Author : Custom script for web search
## Rofi   : Web Search with Google in zen-browser

# Get search query from rofi
query=$(rofi -dmenu -p "Search" -theme-str 'window {width: 600px;}')

# Exit if no query was entered
if [ -z "$query" ]; then
    exit 0
fi

# URL encode the query
encoded_query=$(echo "$query" | sed 's/ /+/g' | jq -sRr @uri)

# Open in zen-browser (flatpak) with Google search
flatpak run app.zen_browser.zen "https://www.google.com/search?q=${encoded_query}" &
