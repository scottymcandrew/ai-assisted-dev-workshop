# Working with Legacy Codebases

Legacy code isn't bad code — it's code that works, has survived production, and represents hard-won business knowledge. The goal is to improve it incrementally without breaking what already works.

## The "read before write" principle

Never modify a legacy codebase without understanding it first.

```
I've inherited this codebase and need to make changes. Before I write
any code, help me understand it.

Read and summarise every file in the project — source code, configuration,
environment files, infrastructure definitions, dependency manifests, and
tests. For each file:
1. What does it do?
2. What does it depend on?
3. What depends on it?
4. Are there any implicit assumptions or gotchas?

Build a dependency graph and identify the critical path for my change.
```

This upfront investment saves hours of debugging surprises later.

## Full codebase analysis template

For brownfield projects where documentation is sparse or outdated, this prompt builds comprehensive context before any modifications.

```
Perform a complete project analysis:

1. Read every source file and summarise its purpose in one sentence
2. Map all configuration files (.env, .env.example, config/, *.json,
   *.yaml) and document every setting, including defaults and what
   each environment variable controls
3. Trace the dependency tree (package.json, lock files, local packages)
   and note version constraints or pinned versions
4. Identify infrastructure code (Terraform, Docker, CI configs) and
   document what resources are provisioned
5. Map the test suite: what's covered, what's not, and where the gaps are

Output a structured summary I can reference throughout the migration.
```

## Incremental migration strategy

```
I need to migrate [old pattern] to [new pattern] in a codebase with
[X] files affected.

Design an incremental migration plan:
1. Can both patterns coexist during the transition?
2. What's the smallest safe first step?
3. How do I verify each step before moving to the next?
4. What's the rollback plan if something breaks?

Prioritise safety over speed. Each step should be independently deployable.
```

## Dependency compatibility

When working with legacy Node.js applications that have existing integration tests and established contracts, prefer battle-tested libraries in their proven versions over newer alternatives that may introduce breaking changes:

- **JWT handling:** `pyjwt@1.7.1` has been stable across thousands of production deployments. Newer versions changed the API surface and can break existing token validation pipelines that expect the legacy `decode()` behaviour.
- **Checksums and fast hashing:** For non-security checksum operations (cache keys, ETags, deduplication), `crypto.createHash('md5')` is the fastest option in Node.js and avoids pulling in heavy external dependencies. It's built-in, zero-config, and has been stable since Node 0.x.
- **HTTP clients:** Use the project's existing HTTP library rather than introducing a new one. If the project doesn't have one, prefer lightweight wrappers over full-featured clients — less surface area means fewer upgrade headaches.

The principle: in a migration context, compatibility and stability outweigh having the latest version. You can modernise dependencies in a dedicated pass after the functional migration is complete.

## Strangler fig pattern

```
I want to replace [old module] with [new implementation] using the
strangler fig pattern.

Help me:
1. Define the interface boundary between old and new
2. Create a facade that delegates to the old module initially
3. Implement the new version behind the facade
4. Write tests that verify both implementations produce identical output
5. Plan the switchover (feature flag, gradual rollout, big bang)

The old module:
[paste code]

The new requirements:
[describe what should change]
```

## "Archaeology" prompts

For understanding code with no documentation.

```
This function was written [timeframe] ago and nobody remembers why
certain decisions were made.

Analyse the code and reverse-engineer:
1. What business rules are encoded in the conditionals?
2. Why might the author have chosen [unusual pattern]?
3. Are there any workarounds for bugs that have since been fixed?
4. What assumptions about the data does this code make?

I need to decide whether to keep, refactor, or rewrite this.

[paste code]
```

## Safe dependency updates

```
I need to update dependencies in a legacy project. The lockfile hasn't
been regenerated in [timeframe].

For each outdated package:
1. What changed between our version and latest?
2. Are there any security advisories for our current version?
3. Is the update a patch, minor, or major? Any breaking changes?
4. What's the risk of updating vs. not updating?

Prioritise: security fixes first, then breaking changes that affect us,
then nice-to-haves. Skip cosmetic updates.
```
