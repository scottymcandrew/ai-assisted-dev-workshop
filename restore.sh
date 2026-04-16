#!/usr/bin/env bash
# Undo the workshop's changes to ~/.claude/settings.json.
# Restores the most recent backup if one exists, otherwise removes the file.
set -e

LATEST="$(ls -t "$HOME"/.claude/settings.json.bak.* 2>/dev/null | head -n1 || true)"
if [ -n "$LATEST" ]; then
  mv "$LATEST" "$HOME/.claude/settings.json"
  echo "✓ Restored $HOME/.claude/settings.json from $LATEST"
else
  rm -f "$HOME/.claude/settings.json"
  echo "✓ Removed $HOME/.claude/settings.json (no prior backup)"
fi
