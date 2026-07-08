#!/usr/bin/env bash
# Show wiki health: page count, orphans, recent log, stubs, broken links
WIKI="/mnt/c/Users/joao.barbosa/LTP/wiki"

if [ ! -d "$WIKI" ]; then
  echo "Wiki not found at $WIKI — run bootstrap first"
  exit 1
fi

# strip WIKI prefix from path using bash parameter expansion
relpath() { echo "${1#$WIKI/}"; }

echo "=== Wiki Status ==="
echo ""

# Page count
TOTAL=$(find "$WIKI" -name "*.md" | wc -l | tr -d ' ')
echo "Total wiki pages: $TOTAL"
find "$WIKI" -name "*.md" | while read f; do relpath "$f"; done | sort
echo ""

# Recent log entries
if [ -f "$WIKI/log.md" ]; then
  echo "=== Recent log entries ==="
  grep "^## \[" "$WIKI/log.md" | tail -10
  echo ""
fi

# Stub pages (< 5 lines)
echo "=== Stub pages (< 5 lines) ==="
found_stub=0
find "$WIKI" -name "*.md" ! -name "index.md" ! -name "log.md" | while read f; do
  lines=$(wc -l < "$f")
  if [ "$lines" -lt 5 ]; then
    echo "  $(relpath $f) ($lines lines)"
    found_stub=1
  fi
done
[ "$found_stub" -eq 0 ] && echo "  None"
echo ""

# Unresolved contradictions
echo "=== Unresolved contradictions ==="
matches=$(grep -rn "⚠️ Contradiction" "$WIKI" --include="*.md" 2>/dev/null)
if [ -n "$matches" ]; then
  while IFS= read -r line; do
    echo "  ${line#$WIKI/}"
  done <<< "$matches"
else
  echo "  None"
fi
echo ""

# Broken wikilinks: [[wiki/X]] where wiki/X.md doesn't exist
echo "=== Broken wikilinks ==="
found_broken=0
grep -roh '\[\[wiki/[^]]*\]\]' "$WIKI" --include="*.md" -l | while read srcfile; do
  grep -oh '\[\[wiki/[^]]*\]\]' "$srcfile" | while read link; do
    # strip [[ ]] and trailing .md if present
    inner="${link#[[}"
    inner="${inner%]]}"
    inner="${inner%.md}"
    # inner is now like "wiki/projects/AIR" — check for file
    target="$WIKI/${inner#wiki/}.md"
    if [ ! -f "$target" ]; then
      echo "  $(relpath $srcfile): $link → NOT FOUND"
      found_broken=1
    fi
  done
done
[ "$found_broken" -eq 0 ] && echo "  None"
echo ""

# Pages not in index.md
echo "=== Pages not in index.md ==="
found_missing=0
find "$WIKI" -name "*.md" ! -name "index.md" ! -name "log.md" | while read f; do
  rel=$(relpath "$f")
  page="${rel%.md}"
  if ! grep -q "$page" "$WIKI/index.md" 2>/dev/null; then
    echo "  NOT IN INDEX: $rel"
    found_missing=1
  fi
done
[ "$found_missing" -eq 0 ] && echo "  All pages covered"
echo ""

# Orphan detection: pages not linked from any other wiki page
echo "=== Orphan pages (no inbound wikilinks) ==="
find "$WIKI" -name "*.md" ! -name "index.md" ! -name "log.md" | while read f; do
  rel=$(relpath "$f")
  page="${rel%.md}"
  # look for [[wiki/<page>]] anywhere in wiki (excluding self)
  hits=$(grep -rl "\[\[wiki/$page\]\]" "$WIKI" --include="*.md" 2>/dev/null | grep -v "^$f$" | wc -l | tr -d ' ')
  if [ "$hits" -eq 0 ]; then
    echo "  $rel"
  fi
done
