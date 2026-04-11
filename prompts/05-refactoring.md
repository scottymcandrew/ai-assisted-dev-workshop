# Refactoring with AI

Refactoring is where AI assistants shine — but also where they're most dangerous if unsupervised. The key principle: **behaviour must not change**. Every prompt below reinforces this constraint.

## Safe extract and rename

```
Extract the [describe logic] from this function into a separate, well-named
function.

Rules:
- The external behaviour of the original function must not change
- The extracted function must be pure (no side effects) if possible
- Choose a name that makes the call site read like documentation
- Add JSDoc with @param and @returns
- Show me the before and after, with a brief explanation of what moved where

[paste code]
```

## Large function decomposition

```
This function is [X] lines long and does too much. Break it into smaller
functions, each with a single responsibility.

Approach:
1. First, list the distinct responsibilities you see (don't write code yet)
2. Propose a decomposition with function names and one-line descriptions
3. I'll approve or adjust the plan
4. Then write the refactored code

Constraints:
- Every test that currently passes must still pass
- No new dependencies
- Preserve the public API (same inputs → same outputs)

[paste code]
```

## Rename at scale

```
I want to rename [old_name] to [new_name] across the codebase.

Here are all the files that reference it:
[paste file list or grep output]

For each file, show me the exact change. Include enough context (3-5 lines
above and below) so I can verify each change is correct and not a false
positive (e.g. a similarly-named variable in a different scope).
```

## Pattern replacement

```
Replace all instances of [old pattern] with [new pattern] in this codebase.

Examples of the old pattern:
[paste 2-3 examples]

The new pattern should:
[describe the desired form]

For each replacement, verify it's semantically equivalent — don't just do
string substitution. Flag any cases where the replacement might change
behaviour.
```

## Dependency upgrade

```
I need to upgrade [package] from [old version] to [new version].

1. Summarise the breaking changes between these versions
2. Search the codebase for usages that would be affected
3. For each affected usage, show the before and after
4. Flag any changes that require manual review (ambiguous migrations)

[paste relevant code or file list]
```

## Code smell detector

```
Analyse this module for code smells:

1. Duplicated logic that could be extracted
2. Functions doing too many things
3. Deep nesting that could be flattened with early returns
4. Magic numbers or strings that should be named constants
5. Unclear boolean parameters (consider options objects)
6. Dead code or unreachable branches

For each smell, rate the urgency (fix now / fix soon / nice to have) and
show the refactored version.

[paste code]
```

## "Before you start" safety check

Use this before any large refactor to prevent regressions.

```
I'm about to refactor [describe the change].

Before I start, help me:
1. List every public function/export that external code depends on
2. Identify side effects that callers might rely on
3. List the existing tests and their coverage of the area I'm changing
4. Suggest any additional tests I should write BEFORE refactoring
   to protect against regressions
```
