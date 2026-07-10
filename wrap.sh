#!/bin/bash
# Wraps a content-only HTML fragment (title + style + body markup + script,
# written for the Claude Artifact tool's auto-wrapping) into a full standalone
# HTML document with a proper doctype/head/viewport meta tag, for direct
# hosting on GitHub Pages (which does NOT auto-wrap anything).
#
# Usage: bash wrap.sh <source.html> <output.html>
set -e
SRC="$1"
OUT="$2"
{
  echo '<!doctype html>'
  echo '<html lang="ko">'
  echo '<head>'
  echo '<meta charset="utf-8">'
  echo '<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">'
  sed -n '1,/<\/style>/p' "$SRC"
  echo '</head>'
  echo '<body>'
  sed -n '/<\/style>/,$p' "$SRC" | tail -n +2
  echo '</body>'
  echo '</html>'
} > "$OUT"
