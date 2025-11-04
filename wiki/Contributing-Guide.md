# Contributing Guide

Thank you for your interest in contributing to RandomWalker! This guide will help you get started.

## Table of Contents

- [Ways to Contribute](#ways-to-contribute)
- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Coding Standards](#coding-standards)
- [Testing](#testing)
- [Documentation](#documentation)
- [Submitting Changes](#submitting-changes)

## Ways to Contribute

You can contribute to RandomWalker in many ways:

### 1. Report Bugs

Found a bug? Please [open an issue](https://github.com/spsanderson/RandomWalker/issues/new) with:
- **Clear title** describing the problem
- **Steps to reproduce** the bug
- **Expected behavior** vs actual behavior
- **Your environment**: R version, OS, RandomWalker version
- **Minimal reproducible example** (reprex)

Example:
```r
library(RandomWalker)

# This should work but throws an error
random_normal_walk(.num_walks = -1)  # Negative walks causes error
```

### 2. Suggest Features

Have an idea? [Open an issue](https://github.com/spsanderson/RandomWalker/issues/new) with:
- **Clear description** of the feature
- **Use cases** explaining why it's needed
- **Example code** showing how it would work
- **Alternative approaches** you've considered

### 3. Improve Documentation

Documentation improvements are always welcome:
- Fix typos or unclear explanations
- Add examples to function documentation
- Write tutorials or vignettes
- Improve this wiki!

### 4. Submit Code

Contribute code for:
- Bug fixes
- New features
- Performance improvements
- New distribution generators
- Visualization enhancements

### 5. Answer Questions

Help others by:
- Responding to issues
- Participating in [GitHub Discussions](https://github.com/spsanderson/RandomWalker/discussions)
- Answering Stack Overflow questions tagged `randomwalker`

## Code of Conduct

Please be respectful and considerate:
- Use welcoming and inclusive language
- Be respectful of differing viewpoints
- Accept constructive criticism gracefully
- Focus on what's best for the community
- Show empathy towards others

## Getting Started

### Prerequisites

- **R** (>= 4.1.0)
- **RStudio** (recommended)
- **Git** for version control
- **devtools** and **roxygen2** packages

### Fork and Clone

1. Fork the repository on GitHub
2. Clone your fork locally:
   ```bash
   git clone https://github.com/YOUR-USERNAME/RandomWalker.git
   cd RandomWalker
   ```

3. Add upstream remote:
   ```bash
   git remote add upstream https://github.com/spsanderson/RandomWalker.git
   ```

### Install Dependencies

```r
# Install development dependencies
install.packages(c("devtools", "roxygen2", "pkgdown", "knitr", "rmarkdown"))

# Install package dependencies
install.packages(c("dplyr", "tidyr", "purrr", "rlang", "ggplot2", "ggiraph", "patchwork", "NNS"))

# Install from your local clone
devtools::install()
```

## Development Workflow

### 1. Create a Branch

Always work on a feature branch:

```bash
# Update your main branch
git checkout master
git pull upstream master

# Create feature branch
git checkout -b feature/my-new-feature
```

Branch naming conventions:
- `feature/description` - New features
- `bugfix/description` - Bug fixes
- `docs/description` - Documentation only
- `refactor/description` - Code refactoring

### 2. Make Changes

Edit code following our [coding standards](#coding-standards).

### 3. Document Your Code

Use roxygen2 for function documentation:

```r
#' Generate Random Normal Walk
#'
#' @family Generator Functions
#'
#' @author Your Name
#'
#' @description Generates random walks from normal distribution.
#'
#' @details
#' This function creates random walks where each step is drawn from
#' a normal distribution with specified mean and standard deviation.
#'
#' @param .num_walks Integer. Number of walks to generate (default: 25).
#' @param .n Integer. Number of steps per walk (default: 100).
#' @param .mu Numeric. Mean of the distribution (default: 0).
#' @param .sd Numeric. Standard deviation (default: 1).
#'
#' @return A tibble with columns walk_number, step_number, y, and cumulative functions.
#'
#' @examples
#' # Basic usage
#' random_normal_walk()
#'
#' # Custom parameters
#' random_normal_walk(.num_walks = 10, .mu = 0.1, .sd = 0.5)
#'
#' @export
random_normal_walk <- function(.num_walks = 25, .n = 100, .mu = 0, .sd = 1) {
  # Function body
}
```

### 4. Update Documentation

Regenerate documentation:

```r
devtools::document()
```

This updates:
- `man/` directory with help files
- `NAMESPACE` with exports/imports

### 5. Check Your Changes

Run package checks:

```r
devtools::check()
```

Target: **0 errors, 0 warnings, 0 notes**

If you get notes about "no visible binding for global variable", add them to `R/00_global_variables.R`:

```r
globalVariables(c("variable_name"))
```

### 6. Test Locally

Test your changes:

```r
# Load package
devtools::load_all()

# Test manually
result <- your_new_function()
print(result)

# Test with examples
devtools::run_examples()
```

## Coding Standards

### Style Guide

RandomWalker follows the [tidyverse style guide](https://style.tidyverse.org/):

**Naming:**
```r
# Good
my_function <- function() {}
my_variable <- 10

# Bad
myFunction <- function() {}
my.variable <- 10
```

**Spacing:**
```r
# Good
x <- 1 + 2
if (x > 0) {
  print("positive")
}

# Bad
x<-1+2
if(x>0){print("positive")}
```

**Indentation:**
- Use 2 spaces (not tabs)
- Align function arguments

```r
# Good
my_function(
  arg1 = "value1",
  arg2 = "value2",
  arg3 = "value3"
)

# Bad
my_function(arg1="value1",
arg2="value2",arg3="value3")
```

### Function Design

**Parameter naming:**
- Start with `.` for consistency: `.num_walks`, `.n`, `.mu`
- Use full words: `.initial_value` not `.init_val`
- Match existing patterns in the package

**Return values:**
- Always return tibbles (not data.frames)
- Include attributes for metadata
- Document return structure clearly

**Error handling:**
```r
# Use rlang for errors
if (invalid_input) {
  rlang::abort(
    message = "Descriptive error message",
    use_cli_format = TRUE
  )
}
```

### Use the Pipe

Use the native pipe `|>` (R >= 4.1):

```r
# Good
data |>
  filter(x > 0) |>
  mutate(y = x^2) |>
  summarize(mean_y = mean(y))

# Also acceptable (for backward compatibility)
data %>%
  filter(x > 0)
```

## Testing

Currently, RandomWalker has no formal test suite. If you want to add tests:

1. Create `tests/testthat/` directory
2. Add test files: `test-function-name.R`
3. Use `testthat` framework

Example test:
```r
test_that("random_normal_walk generates correct structure", {
  walks <- random_normal_walk(.num_walks = 5, .n = 10)
  
  expect_s3_class(walks, "tbl_df")
  expect_equal(nrow(walks), 50)  # 5 walks * 10 steps
  expect_true("walk_number" %in% names(walks))
  expect_true("cum_sum" %in% names(walks))
})
```

For now, manual testing is sufficient:
```r
# Test your function works
result <- your_function()
head(result)
str(result)

# Test edge cases
your_function(.num_walks = 1)
your_function(.n = 1)

# Test errors are caught
tryCatch(
  your_function(.num_walks = -1),
  error = function(e) print("Correctly caught error")
)
```

## Documentation

### Function Documentation (roxygen2)

Required tags:
- `@family` - Group the function
- `@author` - Your name
- `@description` - One-line summary
- `@details` - Detailed explanation
- `@param` - Each parameter
- `@return` - What the function returns
- `@examples` - Working examples
- `@export` - If function should be exported

### README

If your changes affect usage, update `README.Rmd` (NOT `README.md`):

```r
# Edit README.Rmd
# Then regenerate README.md
rmarkdown::render("README.Rmd")
```

### Vignettes

For major features, consider adding to `vignettes/getting-started.Rmd`.

### NEWS.md

Add entry under "Development version":

```markdown
# RandomWalker (development version)

## New Features

1. Fix #123 - Add function `my_new_function()` to do X.

## Bug Fixes

1. Fix #456 - Corrected issue with Y.
```

## Submitting Changes

### 1. Commit Your Changes

Write clear commit messages:

```bash
# Good commit messages
git commit -m "Add random_laplace_walk() function"
git commit -m "Fix bug in visualize_walks() with 3D data"
git commit -m "Update documentation for brownian_motion()"

# Bad commit messages
git commit -m "fix"
git commit -m "changes"
git commit -m "update"
```

### 2. Push to Your Fork

```bash
git push origin feature/my-new-feature
```

### 3. Create Pull Request

1. Go to your fork on GitHub
2. Click "New Pull Request"
3. Select your feature branch
4. Fill out the PR template:

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Refactoring

## Checklist
- [ ] Code follows style guidelines
- [ ] Documentation updated
- [ ] `devtools::check()` passes
- [ ] Examples work
- [ ] NEWS.md updated

## Testing
Describe how you tested these changes

## Related Issues
Closes #123
```

### 4. Respond to Review

Maintainers may request changes:
- Address feedback promptly
- Push additional commits to the same branch
- Engage in constructive discussion

### 5. Merge

Once approved, maintainers will merge your PR. Thank you for contributing!

## Development Tips

### Quick Development Cycle

```r
# 1. Make changes to R files
# 2. Reload package
devtools::load_all()

# 3. Test interactively
my_function()

# 4. Repeat 1-3 until satisfied

# 5. Document
devtools::document()

# 6. Check
devtools::check()
```

### Build Website Locally

```r
pkgdown::build_site()
# Opens in browser
```

### Debug Issues

```r
# Use browser() for debugging
my_function <- function(x) {
  browser()  # Stops execution here
  x + 1
}

# Or use debug()
debug(my_function)
my_function(5)
undebug(my_function)
```

### Keep Your Fork Updated

```bash
# Regularly sync with upstream
git checkout master
git fetch upstream
git merge upstream/master
git push origin master
```

## Questions?

- **Issues**: Technical questions → [GitHub Issues](https://github.com/spsanderson/RandomWalker/issues)
- **Discussions**: General questions → [GitHub Discussions](https://github.com/spsanderson/RandomWalker/discussions)
- **Email**: spsanderson@gmail.com

## Recognition

Contributors are recognized in:
- Package DESCRIPTION file
- NEWS.md entries
- README.md acknowledgments

Thank you for making RandomWalker better!

---

**Ready to contribute?** [Open an issue](https://github.com/spsanderson/RandomWalker/issues) or [start coding](https://github.com/spsanderson/RandomWalker)!
