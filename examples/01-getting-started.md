# Exercise 1: Get oriented

Open this folder in Cursor (or any editor with Claude Code) and try this prompt:

> Read the project and summarise what's here.

You should see Sonnet respond. The shared workshop Bedrock account was configured for you by `setup.sh`, so no AWS credentials of your own are needed.

## Try a few more prompts

- *"Explain what `setup.sh` does, line by line."*
- *"What changes did this project make to my machine?"*
- *"How would I undo those changes?"*

## When you're done

```bash
./restore.sh
```

This removes the workshop's Bedrock configuration from `~/.claude/settings.json` and puts your previous settings back if you had any.
