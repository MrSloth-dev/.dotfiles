#!/usr/bin/env bash
# Search across all wiki pages for a term
WIKI="/mnt/c/Users/joao.barbosa/LTP/wiki"
TERM="$1"

if [ -z "$TERM" ]; then
  echo "Usage: wiki-search.sh <term>"
  exit 1
fi

if [ ! -d "$WIKI" ]; then
  echo "Wiki not found at $WIKI — run bootstrap first"
  exit 1
fi

echo "=== Wiki search: '$TERM' ==="
grep -rn --include="*.md" -i "$TERM" "$WIKI" \
  | sed "s|$WIKI/||" \
  | grep -v "^index.md:" \
  | grep -v "^log.md:"
