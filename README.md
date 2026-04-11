# AI-Assisted Development Workshop

Learn to build production-grade APIs using AI coding agents. This workshop pairs hands-on exercises with a curated collection of prompts you can take back to your daily work.

## What you'll learn

- How to write effective prompts for code generation, review, and debugging
- Building REST APIs with AI assistance (Express + Node.js)
- Iterative development patterns: prompt → review → refine
- When to trust AI suggestions and when to push back

## Quick start

```bash
./setup.sh          # Configure your environment
```

Then open this folder in **Cursor** (or your preferred AI-enabled editor) and start with `exercises/01-getting-started.md`.

## What's inside

```text
ai-dev-workshop/
├── prompts/            ← Reusable prompt templates (the good stuff)
├── exercises/          ← Guided coding exercises
├── src/                ← Express API scaffold to build on
├── tests/              ← Test suite
├── lib/dev-toolkit/    ← HTTP utilities used throughout exercises
├── CLAUDE.md           ← Project conventions for AI assistants
└── .env.example        ← Environment template
```

## Prompts collection

The `prompts/` folder contains battle-tested templates for common AI-assisted development tasks. Browse them before starting the exercises — they're designed to be copied and adapted for your own projects.

| Prompt | Focus |
|--------|-------|
| [01 — Effective Prompting](prompts/01-effective-prompting.md) | Foundational techniques |
| [02 — Code Review](prompts/02-code-review.md) | Security, performance, readability |
| [03 — Test Generation](prompts/03-test-generation.md) | Beyond happy-path coverage |
| [04 — Debugging](prompts/04-debugging.md) | Systematic root-cause analysis |
| [05 — Refactoring](prompts/05-refactoring.md) | Safe, behaviour-preserving changes |
| [06 — Legacy Migration](prompts/06-legacy-migration.md) | Working with existing codebases |

## Exercises

1. **[Getting Started](exercises/01-getting-started.md)** — Explore the project with your AI assistant
2. **[Customer API](exercises/02-customer-api.md)** — Build a full registration + search API

## Prerequisites

- Node.js 20+
- An AI-enabled editor (Cursor recommended)
- Curiosity

## License

MIT
