#!/usr/bin/env bash
# AI Dev Workshop — one-time environment setup.
#
# Configures Claude Code to use the workshop's shared Amazon Bedrock account
# so attendees don't need to set up their own AWS credentials just for this.
set -e

REGION="us-east-1"
MODEL="us.anthropic.claude-sonnet-4-6"
TOKEN_URL=""
API_KEY=""

if [ -z "$TOKEN_URL" ] || [ -z "$API_KEY" ]; then
  echo "error: this clone is not wired up. Ask the workshop facilitator for the current setup.sh." >&2
  exit 1
fi

echo "→ Fetching workshop Bedrock credentials…"
BEARER="$(curl -fsSL -H "x-api-key: $API_KEY" "$TOKEN_URL")"

echo "→ Writing ~/.claude/settings.json"
mkdir -p "$HOME/.claude"
[ -f "$HOME/.claude/settings.json" ] && cp "$HOME/.claude/settings.json" "$HOME/.claude/settings.json.bak.$(date +%s)"
cat > "$HOME/.claude/settings.json" <<EOF
{
  "env": {
    "CLAUDE_CODE_USE_BEDROCK": "1",
    "AWS_REGION": "$REGION",
    "ANTHROPIC_MODEL": "$MODEL",
    "AWS_BEARER_TOKEN_BEDROCK": "$BEARER"
  }
}
EOF

echo "→ Verifying Claude Code can reach Bedrock…"
if command -v claude >/dev/null; then
  claude -p "Summarise this repo in one sentence." || true
else
  echo "  (Claude Code CLI not found — open the folder in Cursor instead.)"
fi

echo "✓ Done. Start with examples/01-getting-started.md"
echo "  When finished, run ./restore.sh to undo the Bedrock configuration."
