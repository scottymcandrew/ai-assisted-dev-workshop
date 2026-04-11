# Exercise 1: Getting Started

**Goal:** Familiarise yourself with the project and your AI coding assistant before building anything.

**Time:** 10-15 minutes

## Step 1: Project exploration

Ask your AI assistant to explore the project. Try this prompt:

```
Read and summarise every file in this project. For each file, tell me:
1. What it does
2. What it depends on
3. Anything unusual or noteworthy

Include configuration files, environment templates, and package manifests.
I want a complete picture before I start coding.
```

Review the output. You should now have a mental map of the codebase.

## Step 2: Understand the conventions

Ask your assistant:

```
Read CLAUDE.md and summarise the project conventions. What patterns
should I follow when writing new code? Are there any specific libraries
or approaches I must use?
```

These conventions are important — they ensure your code is consistent with the rest of the project.

## Step 3: Check the tooling

This project includes `dev-toolkit` for HTTP utilities. Ask your assistant to explain it:

```
Read lib/dev-toolkit/index.js and its README. Explain the API:
- How do I create an HTTP client?
- How do I format responses?
- What retry/timeout behaviour is built in?
```

## Step 4: Run the tests

Make sure everything works before you start changing code:

```bash
npm test
```

All tests should pass. If they don't, ask your AI assistant to help debug.

## Next

When you're comfortable with the project layout, move on to [Exercise 2: Customer API](02-customer-api.md).