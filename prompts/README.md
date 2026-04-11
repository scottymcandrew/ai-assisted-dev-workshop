# Prompt Templates

A curated collection of prompts for AI-assisted development. Each file contains ready-to-use templates you can paste directly into your AI coding assistant.

These aren't hypothetical — they're distilled from real engineering workflows and refined through iteration.

## The collection

| # | Template | What it's for |
|---|----------|---------------|
| 01 | [Effective Prompting](01-effective-prompting.md) | Foundational techniques for getting better output from any AI assistant |
| 02 | [Code Review](02-code-review.md) | Structured review prompts for security, performance, and readability |
| 03 | [Test Generation](03-test-generation.md) | Moving beyond happy-path tests to meaningful coverage |
| 04 | [Debugging](04-debugging.md) | Systematic root-cause analysis with AI assistance |
| 05 | [Refactoring](05-refactoring.md) | Safe, behaviour-preserving code transformation |
| 06 | [Legacy Migration](06-legacy-migration.md) | Strategies for working with existing codebases |

## How to use

1. Read the template for the task you're doing
2. Copy the prompt, fill in the bracketed placeholders
3. Iterate — most prompts work best as a conversation, not a single shot
4. Adapt them to your own style over time

## Tips

- **Be specific about constraints.** "Write a function" is weak. "Write a pure function that takes X, returns Y, handles Z edge case, and has no side effects" gives the AI something to work with.
- **Show, don't tell.** Include a code snippet as an example of the style you want.
- **Ask for trade-offs.** When the AI gives you one approach, ask "what are two alternatives and their trade-offs?" — this often surfaces better solutions.
