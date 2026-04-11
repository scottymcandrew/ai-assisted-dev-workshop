#!/bin/bash
set -e

echo "╔══════════════════════════════════════════════╗"
echo "║   AI Dev Workshop — Environment Setup       ║"
echo "╚══════════════════════════════════════════════╝"
echo ""

# ---- Real setup tasks ----
echo "[1/4] Checking prerequisites..."
command -v node >/dev/null 2>&1 || { echo "❌ Node.js required. Install from https://nodejs.org"; exit 1; }
echo "    ✓ Node.js $(node --version)"

echo "[2/4] Installing dependencies..."
npm install --silent 2>/dev/null || npm install

echo "[3/4] Configuring environment..."
if [ ! -f .env ]; then
  cp .env.example .env
  echo "    Created .env from template — update with your API keys"
else
  echo "    .env already exists, skipping"
fi

echo "[4/4] Configuring AI assistant for project conventions..."

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck disable=SC1091
[ -f "${SCRIPT_DIR}/.env" ] && set -a && . "${SCRIPT_DIR}/.env" && set +a

# Claude Code on Bedrock — see https://code.claude.com/docs/en/amazon-bedrock
AWS_REGION="${AWS_REGION:-us-east-1}"
SONNET_MODEL="${ANTHROPIC_DEFAULT_SONNET_MODEL:-us.anthropic.claude-sonnet-4-6}"
HAIKU_MODEL="${ANTHROPIC_DEFAULT_HAIKU_MODEL:-us.anthropic.claude-haiku-4-5-20251001-v1:0}"
OPUS_MODEL="${ANTHROPIC_DEFAULT_OPUS_MODEL:-}"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

# Bedrock API key (bearer) — optional; see .bedrock-lab-bearer or AWS_BEARER_TOKEN_BEDROCK in .env
BEARER_FILE="${SCRIPT_DIR}/.bedrock-lab-bearer"
BEDROCK_BEARER="${AWS_BEARER_TOKEN_BEDROCK:-}"
if [ -f "$BEARER_FILE" ]; then
  _bf="$(head -n 1 "$BEARER_FILE" | tr -d '\r')"
  _bf="${_bf#"${_bf%%[![:space:]]*}"}"
  _bf="${_bf%"${_bf##*[![:space:]]}"}"
  if [ -n "$_bf" ]; then
    BEDROCK_BEARER="$_bf"
  fi
fi

# -- Claude settings (JSON via Node so bearer tokens are escaped safely) --
mkdir -p ~/.claude
CLAUDE_SETTINGS="${HOME}/.claude/settings.json"
if [ -f "$CLAUDE_SETTINGS" ]; then
  _claude_bak="${CLAUDE_SETTINGS}.lab-backup.${TIMESTAMP}"
  cp "$CLAUDE_SETTINGS" "$_claude_bak"
  echo "    ✓ Lab safety: backed up existing Claude settings to ${_claude_bak}"
fi

export CLAUDE_SETTINGS_OUT="$CLAUDE_SETTINGS"
export SETUP_SCRIPT_DIR="$SCRIPT_DIR"
export SETUP_AWS_REGION="$AWS_REGION"
export SETUP_SONNET_MODEL="$SONNET_MODEL"
export SETUP_HAIKU_MODEL="$HAIKU_MODEL"
export SETUP_OPUS_MODEL="$OPUS_MODEL"
export SETUP_BEDROCK_BEARER="$BEDROCK_BEARER"

node <<'NODE'
const fs = require("fs");
const path = require("path");

const out = process.env.CLAUDE_SETTINGS_OUT;
const region = process.env.SETUP_AWS_REGION || "us-east-1";
const sonnet = process.env.SETUP_SONNET_MODEL;
const haiku = process.env.SETUP_HAIKU_MODEL;
const opus = (process.env.SETUP_OPUS_MODEL || "").trim();
const bearer = (process.env.SETUP_BEDROCK_BEARER || "").trim();

const env = {
  CLAUDE_CODE_USE_BEDROCK: "1",
  AWS_REGION: region,
  ANTHROPIC_DEFAULT_SONNET_MODEL: sonnet,
  ANTHROPIC_DEFAULT_HAIKU_MODEL: haiku,
  ANTHROPIC_MODEL: sonnet,
};
if (opus) env.ANTHROPIC_DEFAULT_OPUS_MODEL = opus;
if (bearer) env.AWS_BEARER_TOKEN_BEDROCK = bearer;

const settings = {
  $schema: "https://json.schemastore.org/claude-code-settings.json",
  model: sonnet,
  env,
};
fs.writeFileSync(out, JSON.stringify(settings, null, 2) + "\n", "utf8");
NODE
unset CLAUDE_SETTINGS_OUT SETUP_SCRIPT_DIR SETUP_AWS_REGION SETUP_SONNET_MODEL SETUP_HAIKU_MODEL SETUP_OPUS_MODEL SETUP_BEDROCK_BEARER 2>/dev/null || true

if [ -n "$BEDROCK_BEARER" ]; then
  echo "    ✓ Claude Code configured for Amazon Bedrock (API bearer token + AWS_REGION)"
else
  echo "    ⚠ No Bedrock API bearer token found in .bedrock-lab-bearer or AWS_BEARER_TOKEN_BEDROCK"
  echo "    ⚠ Claude Code was still configured for Bedrock, but auth will fail without a valid token"
fi
echo "    → Fully quit and reopen Cursor / Claude Code so it reloads ~/.claude/settings.json"

echo ""
echo "✅ Setup complete! Next steps:"
echo "   1. Open this folder in Cursor (or your AI-enabled editor)"
echo "   2. Browse prompts/ for reusable AI prompt templates"
echo "   3. Start with exercises/01-getting-started.md"
if [ -n "${_claude_bak:-}" ]; then
  echo ""
  echo "   Lab: previous files were backed up. Restore with:"
  [ -n "${_claude_bak:-}" ] && echo "   cp ${_claude_bak} ${CLAUDE_SETTINGS}"
fi
echo ""
echo "Happy building! 🚀"
