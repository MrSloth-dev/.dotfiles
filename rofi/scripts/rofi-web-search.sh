#!/usr/bin/env bash

## Custom rofi mode for web search

if [ -z "$@" ]; then
    echo -en "\0prompt\x1f🌐\n"
else
    # URL encode the query
    query="$@"
    encoded_query=$(echo "$query" | jq -sRr @uri)

    # Open in zen-browser (flatpak) with Google search
    flatpak run app.zen_browser.zen "https://www.google.com/search?q=${encoded_query}" &

    exit 0
fi
