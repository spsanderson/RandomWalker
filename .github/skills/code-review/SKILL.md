---
name: code-review
description: Review RandomWalker pull requests for R package correctness, statistical accuracy, public API compatibility, and consistency between random walk generators, summaries, visualizations, and documentation.
---

# RandomWalker code review

Review proposed changes to RandomWalker, an R package for generating and analyzing random walks using tidyverse-compatible data.

## Establish context

- Read the pull request description, diff, and relevant repository instructions.
- When GitHub MCP tools are available, read linked issues and relevant pull request discussions to identify acceptance criteria and intentional tradeoffs. Do not assume access to additional MCP servers.
- Inspect affected functions, their callers, generator output, and existing tests before reporting a problem.
- Use the current branch as the source of truth. An open issue does not prove its fix is missing.
- Review without modifying files, changing repository settings, or closing issues.

## Prioritize actionable findings

Report defects introduced or exposed by the change: incorrect results, broken documented usage, compatibility regressions, or material performance problems.

For each finding, identify the triggering input or scenario, explain the user-visible consequence, and suggest the smallest appropriate correction. Anchor comments to the relevant changed lines.

Avoid speculative concerns, unrelated pre-existing defects, style-only preferences, and requests for broad refactoring. Do not repeat the same root cause across multiple comments.

## Check package contracts

- Preserve exported function names, argument defaults, positional calling conventions, aliases, and return structures unless the change intentionally revises them.
- Verify compatibility with the R version declared in `DESCRIPTION`.
- Check dependency declarations and namespace usage when new package functions are introduced.
- Verify that changes preserve required columns, column types, row ordering, grouping, and metadata used by downstream functions.
- Inspect actual generator output for supported dimensions. Do not assume every generator uses identical column names or attributes.

### Generators and statistics

- Check walk counts, step counts, initial values, dimension handling, distribution parameters, and cumulative calculations.
- Confirm calculations operate within the intended walk and dimension rather than accidentally combining independent walks.
- Distinguish sample and population statistics. Check formulas against the documented definition or existing contract.
- Consider missing values, short inputs, zero values, and negative values when the changed calculation makes them relevant. Do not demand unrelated numerical behavior changes.
- For optimized or compiled implementations, compare numerical results, output types, missing-value handling, and boundary behavior with the existing implementation. Require evidence for performance claims.

### Summaries and visualization

- Check tidy evaluation of unquoted columns, explicit `NULL`, omitted arguments, and pre-grouped input where relevant.
- For `summarize_walks()` and `summarise_walks()`, omitted or `NULL` grouping means an overall summary; explicit grouping selects the requested column.
- Dimension metadata may use `dimensions` or legacy `dimension`. Preserve documented precedence and fallback behavior; avoid accidental partial attribute matching.
- For `visualize_walks()`, verify `.pluck` selects the intended plotted columns. Exact names take precedence; short aliases must resolve uniquely.
- Check numeric plot indices and supported 1D, 2D, and 3D column names when selection logic changes. Inspect static and interactive paths when shared code affects both.

## Check documentation and validation

- Compare roxygen comments in `R/` with generated help in `man/`, including signatures, defaults, examples, and aliases.
- Check affected README and vignette examples against actual output. Do not require a complete website rebuild for an isolated fix.
- Look for a NEWS entry when a user-visible change warrants one.
- Prefer focused regression checks using the existing test approach. Do not require a new testing dependency without a concrete need.
- Use deterministic fixtures for numerical expectations and fixed seeds for stochastic checks. Avoid brittle snapshots of random results.
- When execution is available, run relevant tests and examples before broader package checks. Keep validation artifacts outside tracked files.
- Clearly distinguish checks that passed, checks that failed, and checks that could not run. Missing Pandoc, compiler tools, or dependencies are environment limitations, not evidence that the code passed or failed.

## Present the review

Lead with actionable findings, ordered by impact. State uncertainty explicitly when evidence is incomplete.

If no actionable defects are found, say so briefly and summarize the validation performed and any material limitations. Never invent findings to fill a review.
