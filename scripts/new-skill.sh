#!/usr/bin/env bash
# Scaffold a new skill: just creates the folder and copies SKILL.md template.
# Usage: scripts/new-skill.sh <category> <skill-name>
set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <category> <skill-name>" >&2
  echo "Categories: $(ls "$(dirname "$0")/../skills" | tr '\n' ' ')" >&2
  exit 1
fi

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DEST="$ROOT/skills/$1/$2"

[[ -d "$DEST" ]] && { echo "Already exists: $DEST" >&2; exit 1; }
[[ -d "$ROOT/skills/$1" ]] || { echo "Unknown category: $1" >&2; exit 1; }

mkdir -p "$DEST"
cp "$ROOT/templates/SKILL.md" "$DEST/SKILL.md"
sed -i.bak "s/skill-name-in-kebab-case/$2/g" "$DEST/SKILL.md" && rm "$DEST/SKILL.md.bak"

echo "Scaffolded: $DEST/SKILL.md"
echo "Fill it in, then optionally add examples/ and references/voice-prompts.md."
