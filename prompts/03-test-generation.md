# Test Generation

The default AI instinct is to write happy-path tests. These prompts push for meaningful coverage that actually catches bugs.

## Edge case discovery

```
Here's a function that [describe what it does].

Before writing any tests, list 10 edge cases that could cause unexpected
behaviour. Think about:
- Boundary values (0, -1, MAX_SAFE_INTEGER, empty string, null, undefined)
- Type coercion gotchas in JavaScript
- Concurrency and timing issues
- Invalid or malicious input
- State dependencies (what if this runs twice? out of order?)

Then write a test for each edge case using Jest.

[paste function]
```

## Test-first design

```
I need to build [describe the feature].

Write the test suite FIRST, before any implementation. The tests should define
the contract:
- What inputs are valid?
- What does the output look like for each case?
- What errors should be thrown and when?
- What side effects should occur?

Use Jest with descriptive test names that read like documentation.
Group related tests in describe blocks.
```

## Integration test prompts

```
Write an integration test for this Express endpoint using supertest.

Cover:
1. Happy path: valid request → expected response
2. Validation: each required field missing → 400 with field-level error
3. Auth: no token → 401, invalid token → 401, wrong role → 403
4. Duplicate: creating a record that already exists → 409
5. Server error: simulate a downstream failure → 500 with safe error message

Use beforeEach to set up test data and afterEach to clean up.
Don't mock the database — use a test database.

[paste endpoint code]
```

## Mutation testing analysis

```
Here's a function and its test suite.

Analyse the tests for gaps by mentally "mutating" the implementation:
- What if I changed > to >= on line X?
- What if I removed the null check on line Y?
- What if I swapped the order of operations on line Z?

For each mutation that the current tests would NOT catch, write the missing test.

Function:
[paste function]

Tests:
[paste tests]
```

## Test readability

```
Refactor these tests for readability:
1. Each test name should complete the sentence "it should ..."
2. Follow the Arrange-Act-Assert pattern with clear visual separation
3. Extract repeated setup into beforeEach or helper functions
4. Use descriptive variable names (not "result", "data", "response")
5. Keep each test focused on one assertion (split if needed)

[paste tests]
```

## Property-based testing

```
This function [describe behaviour].

Write property-based tests using fast-check that verify:
1. [Invariant 1, e.g. "output is always a valid email format"]
2. [Invariant 2, e.g. "round-tripping through encode/decode returns the original"]
3. [Invariant 3, e.g. "output length is always <= input length"]

Generate arbitrary inputs that stress-test the boundaries.

[paste function]
```
