#!/usr/bin/env bash
# ai-sdlc dual-runtime installer: Claude Code (plugin marketplace) + Codex (skill symlinks).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
# Company overlays: run the overlay repo's own install.sh after this one.

echo "== Claude Code =="
if command -v claude >/dev/null 2>&1; then
  claude plugin marketplace add "$ROOT" 2>/dev/null || echo "  (marketplace already added, or add manually: /plugin marketplace add $ROOT)"
  claude plugin install ai-sdlc@ai-sdlc --scope user 2>/dev/null || echo "  install manually: /plugin install ai-sdlc@ai-sdlc"
else
  echo "  claude CLI not found; in Claude Code run: /plugin marketplace add $ROOT && /plugin install ai-sdlc@ai-sdlc"
fi

echo "== Codex =="
CODEX_SKILLS="${CODEX_HOME:-$HOME/.codex}/skills"
mkdir -p "$CODEX_SKILLS"
link_skills() {
  for d in "$1"/*/; do
    name="$(basename "$d")"
    target="$CODEX_SKILLS/$name"
    if [ -L "$target" ] || [ ! -e "$target" ]; then
      ln -sfn "${d%/}" "$target" && echo "  linked $name"
    else
      echo "  SKIPPED $name (non-symlink already exists at $target)"
    fi
  done
}
link_skills "$ROOT/plugins/ai-sdlc/skills"
echo "Done. Codex picks up skills from $CODEX_SKILLS; invoke with \$skill-name or by description."
