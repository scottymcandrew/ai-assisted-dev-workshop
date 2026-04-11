# Debugging with AI

AI assistants are surprisingly good debuggers — but only if you give them the right information. "It doesn't work" is the worst possible prompt. These templates structure the conversation for fast root-cause analysis.

## The structured bug report

```
I'm seeing unexpected behaviour in [component/function].

Expected: [what should happen]
Actual: [what actually happens]
Reproducible: [always / intermittent / only in specific conditions]

Environment:
- Node.js [version]
- OS: [mac/linux/windows]
- Relevant config: [any flags, env vars, feature toggles]

Steps to reproduce:
1. [step]
2. [step]
3. [observe the bug]

Here's the relevant code:
[paste code]

Here's the error/output:
[paste error or unexpected output]
```

## Hypothesis-driven debugging

```
I have a bug: [one-sentence description].

Generate 5 hypotheses for what could cause this, ranked by likelihood.
For each hypothesis:
1. What evidence would confirm it?
2. What's the quickest way to test it?
3. If confirmed, what's the fix?

I'll test them in order and report back.
```

## Stack trace analysis

```
Explain this error stack trace. For each frame:
1. What file and function is involved?
2. Is it my code or a library?
3. What's likely happening at that point?

Then identify the root cause (not just the symptom) and suggest a fix.

[paste stack trace]
```

## Rubber-duck debugging

When you're stuck and don't even know what to ask.

```
I'm stuck on a problem and need to think through it.

Here's what I'm trying to do: [goal]
Here's what I've tried: [approaches]
Here's where I'm stuck: [the specific confusion]

Walk me through this step by step. Ask me clarifying questions if my
description is ambiguous. Don't jump to a solution — help me understand
the problem first.
```

## "What changed?" debugging

For regressions where something that worked is now broken.

```
This endpoint was working yesterday and is now returning 500 errors.

Here's the diff of everything that changed since it last worked:
[paste git diff]

Here's the error:
[paste error]

Which change is most likely responsible? Explain the causal chain from
the change to the error.
```

## Performance debugging

```
This function is taking [X]ms but should complete in under [Y]ms.

Profile data shows the bottleneck is in [area].

Analyse the code and identify:
1. What's causing the slowness?
2. What's the algorithmic complexity? Can it be reduced?
3. Are there any unnecessary allocations or copies?
4. Is there I/O that could be parallelised or cached?

Provide the optimised version with comments explaining each change.

[paste code]
```

## The "explain it to me" technique

Sometimes the best debugging move is understanding the system.

```
Explain how [technology/pattern/library] works under the hood.

I'm debugging an issue where [symptom], and I think it's related to
how [technology] handles [specific mechanism].

Don't just describe the API — explain the internal behaviour, including
edge cases and gotchas that aren't obvious from the docs.
```
