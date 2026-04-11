# Code Review with AI

AI assistants are excellent reviewers when given the right lens. The key is specifying *what* to look for — otherwise you get generic "looks good" responses.

## Security review

```
Review this code for security vulnerabilities. Focus on:

1. Injection risks (SQL, NoSQL, command injection, XSS)
2. Authentication/authorisation bypasses
3. Sensitive data exposure (logs, error messages, headers)
4. Insecure cryptographic choices
5. Missing input validation or sanitisation

For each finding:
- Severity: critical / high / medium / low
- The specific vulnerable line(s)
- How an attacker would exploit it
- The fix, with code

[paste code here]
```

## Performance review

```
Analyse this code for performance issues. Consider:

1. N+1 query patterns or redundant database calls
2. Unbounded operations (no pagination, no limits)
3. Blocking operations on the event loop
4. Memory leaks or unnecessary allocations
5. Missing caching opportunities

For each finding, estimate the impact (latency, throughput, memory) and provide the optimised version.

[paste code here]
```

## Readability and maintainability review

```
Review this code for readability and long-term maintainability:

1. Are function and variable names self-documenting?
2. Is the control flow easy to follow?
3. Are there any "clever" patterns that should be simplified?
4. Is error handling consistent and informative?
5. Could any section be extracted into a well-named function?

Suggest concrete renames, extractions, or restructurings — not just observations.

[paste code here]
```

## Scoping a review

For large files, focus the AI on what matters.

```
I'm about to merge this PR. The changes are in the authentication middleware.
Review ONLY the auth logic — ignore formatting, test files, and unchanged code.

Key concern: we switched from session-based to JWT auth. Are there any
gaps in the migration that could let unauthenticated requests through?

[paste diff or changed files]
```

## Comparative review

```
Here are two implementations of the same feature. Compare them on:
1. Correctness (do they handle the same edge cases?)
2. Performance (which is faster for our expected load of ~1000 req/s?)
3. Readability (which would be easier for a new team member to understand?)

Recommend which to merge and why.

Implementation A:
[paste code]

Implementation B:
[paste code]
```

## Review checklist generator

```
Generate a code review checklist for a [type of change, e.g. "new REST endpoint",
"database migration", "authentication change"] in a Node.js/Express codebase.

Include checks for: security, error handling, testing, documentation, backward
compatibility, and operational concerns (logging, monitoring, rollback).

Format as a markdown checklist I can paste into a PR template.
```
