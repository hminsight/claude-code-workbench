#!/bin/bash
# post-create.sh — runs after devcontainer is created
# Non-critical failures should not block the container from starting

# Resolve workspace root (works regardless of mount path or folder name)
WORKSPACE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
echo "=== Workspace: ${WORKSPACE_DIR} ==="

# --- Volume ownership ---
# Docker volumes for Claude Code may be created as root. Ensure the vscode user owns them in the container.
sudo chown -R "$(id -u):$(id -g)" "$HOME/.claude" /commandhistory 2>/dev/null || true

# --- Persistent bash history ---
# Ensure the history file exists on the volume and wire it into the shell profile.
touch /commandhistory/.bash_history
HISTORY_SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history"
if ! grep -q "/commandhistory/.bash_history" "$HOME/.bashrc" 2>/dev/null; then
  echo "$HISTORY_SNIPPET" >> "$HOME/.bashrc"
fi

# --- Claude Code settings ---
# The ~/.claude volume mount shadows the repo's .claude/ directory, so copy repo-level settings
# into the volume on first use (skip if already present so user customisations aren't overwritten).
if [ -f "${WORKSPACE_DIR}/.claude/settings.json" ] && [ ! -f "$HOME/.claude/settings.json" ]; then
  cp "${WORKSPACE_DIR}/.claude/settings.json" "$HOME/.claude/settings.json"
fi

# --- Claude Code ---
echo "=== Installing Claude Code ==="
if ! command -v claude &> /dev/null; then
  # Retry up to 5 times with a 10s delay between attempts (handles transient failures e.g. 429 rate limits).
  installed=false
  for _attempt in 1 2 3 4 5; do
    (set -o pipefail; curl -fsSL https://claude.ai/install.sh | bash) && installed=true && break
    [ "$_attempt" -lt 5 ] && echo "Install attempt ${_attempt} failed — retrying in 10s..." && sleep 10
  done
  $installed || echo "WARN: Claude Code install failed after 5 attempts — install manually later"
  # Ensure claude is on PATH for the rest of this script
  export PATH="$HOME/.claude/bin:$HOME/.local/bin:$PATH"
fi

# --- System packages ---
echo "=== Installing system packages ==="
sudo apt-get update -qq
sudo apt-get install -y -qq pandoc python3-pip python3-venv 2>&1 | tail -3 || echo "WARN: Some system packages failed to install"

# --- Python document tools ---
echo "=== Installing Python document tools ==="
pip3 install --break-system-packages python-pptx openpyxl pandas xlsxwriter 2>&1 | tail -3 || echo "WARN: Some Python packages failed to install"

# --- BMAD Method ---
echo "=== Installing BMAD Method ==="
if command -v npx &> /dev/null; then
  npx --yes bmad-method install --directory "${WORKSPACE_DIR}" --modules bmm --tools claude-code --yes 2>&1 | tail -20 || echo "WARN: BMAD install failed — run 'npx bmad-method install' manually"
else
  echo "WARN: npx not found — skipping BMAD install. Install Node.js first, then run 'npx bmad-method install'"
fi

# --- Azure CLI (optional, install if needed) ---
if ! command -v az &> /dev/null; then
  echo "=== Installing Azure CLI ==="
  curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash 2>&1 | tail -3 || echo "WARN: Azure CLI install failed — install manually if needed"
fi

echo "=== Dev container ready! ==="
echo "Workspace: ${WORKSPACE_DIR}"
echo "Tools: pandoc, python-pptx, openpyxl, pandas, xlsxwriter, BMAD Method, Claude Code"
