# Effective Prompting

The difference between a mediocre AI response and a great one is almost always the prompt. These techniques work across any AI coding assistant.

## The BLUF pattern

**Bottom Line Up Front.** State what you want in the first sentence, then provide context. AI assistants weight the beginning of your prompt heavily.

```
Build a rate limiter middleware for Express that uses a sliding window algorithm.

Context:
- Node.js 20, Express 4.x
- Should work with in-memory storage (no Redis)
- Limit: configurable per-route
- Return 429 with Retry-After header when exceeded
```

Compare this to the vague version: "I need some kind of rate limiting for my API, can you help?" — the BLUF version gets working code on the first try.

## Constraint-driven prompts

The more constraints you specify, the less guesswork the AI does.

```
Write a validation function for UK phone numbers.

Constraints:
- Accept +44 and 07 formats
- Return { valid: boolean, normalised: string, error?: string }
- Pure function, no side effects
- No external dependencies
- Handle edge cases: leading/trailing whitespace, double spaces, dashes
```

## The "act as" technique

Give the AI a role to anchor its perspective.

```
You are a senior backend engineer reviewing a pull request.
Review this Express route handler for:
1. Security vulnerabilities
2. Error handling gaps
3. Performance concerns
4. Naming and readability

Be specific — cite line numbers and suggest fixes, not just observations.
```

## Iterative refinement

Don't expect perfection on the first pass. The best results come from a conversation.

**Round 1:** "Build the endpoint"
**Round 2:** "Add input validation with these specific rules: ..."
**Round 3:** "Now add error handling for the database timeout case"
**Round 4:** "Write tests for the three edge cases we discussed"

Each round builds on established context. This is faster and produces better code than trying to specify everything upfront.

## Prompt chaining for complex tasks

Break large tasks into a sequence of focused prompts.

```
Step 1: "Design the data model for a customer entity with these fields: ..."
Step 2: "Now write the validation schema based on that model"
Step 3: "Build the Express route handler that uses the schema"
Step 4: "Write integration tests for the happy path and two error cases"
```

Each step validates the previous one. If the AI makes a wrong turn in Step 2, you catch it before building on a broken foundation.

## Anti-patterns to avoid

- **"Make it better"** — better how? Be specific about what dimension to improve.
- **Pasting 500 lines and saying "fix this"** — isolate the problem area first.
- **Accepting the first output** — always review, always iterate.
- **Ignoring the AI's questions** — if it asks for clarification, that's a signal your prompt was ambiguous.
