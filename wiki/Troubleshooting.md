# Troubleshooting Guide

Solutions to common problems when using RandomWalker.

## Table of Contents

- [Installation Issues](#installation-issues)
- [Function Errors](#function-errors)
- [Visualization Problems](#visualization-problems)
- [Performance Issues](#performance-issues)
- [Data Structure Issues](#data-structure-issues)
- [Getting More Help](#getting-more-help)

## Installation Issues

### Problem: R Version Too Old

**Error:**
```
Error: package 'RandomWalker' requires R version >= 4.1.0
```

**Solution:**
Update R to version 4.1.0 or higher:
- **Windows/Mac**: Download from [CRAN](https://cran.r-project.org/)
- **Linux**: Use your package manager

```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install r-base

# Check version
R --version
```

### Problem: Dependency Installation Fails

**Error:**
```
ERROR: dependencies 'dplyr', 'tidyr' are not available
```

**Solution 1:** Install dependencies manually
```r
install.packages(c("dplyr", "tidyr", "purrr", "rlang", "patchwork", "NNS", "ggiraph"))
```

**Solution 2:** Install with all dependencies
```r
install.packages("RandomWalker", dependencies = TRUE)
```

**Solution 3:** Check system dependencies (Linux)
```bash
# Ubuntu/Debian
sudo apt-get install libxml2-dev libcurl4-openssl-dev libssl-dev

# Fedora/RHEL
sudo dnf install libxml2-devel libcurl-devel openssl-devel
```

### Problem: GitHub Installation Fails

**Error:**
```
Error: Failed to install 'RandomWalker' from GitHub
```

**Solution 1:** Check internet connection
```r
# Test connection
curl::has_internet()
```

**Solution 2:** Use HTTPS (not SSH)
```r
devtools::install_github("spsanderson/RandomWalker")  # Uses HTTPS
```

**Solution 3:** Increase timeout
```r
options(timeout = 300)  # 5 minutes
devtools::install_github("spsanderson/RandomWalker")
```

## Function Errors

### Problem: "The value to summarize must be provided"

**Error:**
```r
walks |> summarize_walks()
#> Error: The value to summarize must be provided.
```

**Solution:** Specify `.value` parameter
```r
# Correct
walks |> summarize_walks(.value = y)
walks |> summarize_walks(.value = cum_sum)
```

### Problem: "object 'y' not found"

**Error:**
```r
walk_2d <- random_normal_walk(.dimensions = 2)
walk_2d |> summarize_walks(.value = y)
#> Error: object 'y' not found
```

**Solution:** Use dimension-specific columns for multi-dimensional walks
```r
# For 2D walks
walk_2d |> summarize_walks(.value = cum_sum_x)
walk_2d |> summarize_walks(.value = cum_sum_y)

# Or use the step values
walk_2d |> summarize_walks(.value = x)
walk_2d |> summarize_walks(.value = y)
```

### Problem: Negative Number of Walks

**Error:**
```r
random_normal_walk(.num_walks = -5)
#> Error: .num_walks must be positive
```

**Solution:** Use positive integers
```r
random_normal_walk(.num_walks = 5)
```

### Problem: Invalid Dimension

**Error:**
```r
random_normal_walk(.dimensions = 4)
#> Error: .dimensions must be 1, 2, or 3
```

**Solution:** Use 1, 2, or 3 dimensions
```r
random_normal_walk(.dimensions = 1)  # 1D
random_normal_walk(.dimensions = 2)  # 2D
random_normal_walk(.dimensions = 3)  # 3D
```

### Problem: Invalid Probability

**Error:**
```r
discrete_walk(.upper_probability = 1.5)
#> Error: Probability must be between 0 and 1
```

**Solution:** Use values between 0 and 1
```r
discrete_walk(.upper_probability = 0.6)  # 60% probability
```

## Visualization Problems

### Problem: Plot is Blank or Doesn't Show

**Solution 1:** Explicitly print the plot
```r
p <- rw30() |> visualize_walks()
print(p)
```

**Solution 2:** Check if data exists
```r
walks <- rw30()
nrow(walks)  # Should be > 0
head(walks)
```

**Solution 3:** Try different plotting device
```r
# In RStudio, clear plots
dev.off()

# Then try again
rw30() |> visualize_walks()
```

### Problem: Too Many Walks Make Plot Unreadable

**Solution 1:** Reduce transparency
```r
walks |> visualize_walks(.alpha = 0.1)
```

**Solution 2:** Sample walks
```r
library(dplyr)

walks |>
  filter(walk_number %in% sample(levels(walk_number), 20)) |>
  visualize_walks()
```

**Solution 3:** Focus on specific aspect
```r
walks |> visualize_walks(.pluck = "cum_sum")
```

### Problem: Interactive Plot Not Interactive

**Error:** Interactive plot shows but doesn't respond to hover/zoom

**Solution 1:** Ensure you're using a compatible viewer
```r
# Works in:
# - RStudio Viewer pane
# - Web browser
# - Knitted R Markdown HTML

# May not work in:
# - PDF output
# - Static image viewers
```

**Solution 2:** Save and open in browser
```r
library(htmlwidgets)

p <- rw30() |> visualize_walks(.interactive = TRUE)
saveWidget(p, "plot.html")
browseURL("plot.html")
```

### Problem: Plot Export Quality Poor

**Solution:** Increase DPI and size
```r
library(ggplot2)

p <- rw30() |> visualize_walks()

# High-quality export
ggsave(
  "plot.png",
  p,
  width = 12,
  height = 8,
  dpi = 600  # High resolution
)

# Vector format for publications
ggsave("plot.pdf", p, width = 12, height = 8)
```

### Problem: Colors Don't Look Good

**Solution:** Use better color palettes
```r
library(ggplot2)

p <- random_normal_walk(.num_walks = 5) |>
  visualize_walks(.pluck = "y")

# Viridis (colorblind-friendly)
p + scale_color_viridis_d()

# ColorBrewer
p + scale_color_brewer(palette = "Set2")
```

## Performance Issues

### Problem: Generation is Slow

**For large numbers:**
```r
# This might be slow
walks <- random_normal_walk(.num_walks = 10000, .n = 10000)
```

**Solution 1:** Reduce size if possible
```r
walks <- random_normal_walk(.num_walks = 1000, .n = 1000)
```

**Solution 2:** Use profiling to identify bottleneck
```r
library(profvis)

profvis({
  walks <- random_normal_walk(.num_walks = 1000, .n = 1000)
})
```

**Solution 3:** Consider batch processing
```r
# Generate in batches
batch1 <- random_normal_walk(.num_walks = 500)
batch2 <- random_normal_walk(.num_walks = 500)
combined <- bind_rows(batch1, batch2)
```

### Problem: Visualization is Slow

**Solution 1:** Downsample for plotting
```r
# Keep every 10th step
walks_downsampled <- walks |>
  filter(step_number %% 10 == 0)

walks_downsampled |> visualize_walks()
```

**Solution 2:** Use static plots
```r
# Faster than interactive
walks |> visualize_walks(.interactive = FALSE)
```

**Solution 3:** Plot fewer walks
```r
walks |>
  filter(walk_number %in% sample(levels(walk_number), 50)) |>
  visualize_walks(.alpha = 0.3)
```

### Problem: Out of Memory

**Error:**
```
Error: cannot allocate vector of size ...
```

**Solution 1:** Reduce data size
```r
# Instead of
walks <- random_normal_walk(.num_walks = 100000, .n = 10000)

# Try
walks <- random_normal_walk(.num_walks = 10000, .n = 1000)
```

**Solution 2:** Remove unnecessary data
```r
# Keep only what you need
walks_small <- walks |>
  select(walk_number, step_number, cum_sum)
```

**Solution 3:** Process in chunks
```r
# Process walks in groups
process_chunk <- function(chunk_id, chunk_size = 1000) {
  walks <- random_normal_walk(.num_walks = chunk_size)
  # Process walks
  result <- walks |> summarize_walks(.value = y)
  return(result)
}

# Process 10 chunks
results <- map_dfr(1:10, process_chunk)
```

## Data Structure Issues

### Problem: Expected Tibble, Got Data Frame

**Solution:** Convert to tibble
```r
library(dplyr)

df <- as_tibble(your_data)
```

### Problem: walk_number is Not a Factor

**Solution:** Convert to factor
```r
walks <- walks |>
  mutate(walk_number = as.factor(walk_number))
```

### Problem: Columns Missing

**Check what columns exist:**
```r
names(walks)
str(walks)
```

**Common issues:**
- 1D walks have `y`, not `x`
- Multi-D walks have `x`, `y`, (and `z`)
- Cumulative columns have suffixes: `cum_sum_x`, `cum_sum_y`, etc.

### Problem: Attributes Lost After dplyr Operations

**Solution:** Re-attach attributes
```r
# Save attributes
atb <- attributes(walks)

# Do operations
walks_filtered <- walks |> filter(step_number > 50)

# Restore attributes (except row names and class)
for (attr_name in setdiff(names(atb), c("names", "row.names", "class"))) {
  attr(walks_filtered, attr_name) <- atb[[attr_name]]
}
```

## Common Workflow Issues

### Problem: Pipe Not Working

**Error:**
```r
walks |> visualize_walks()
#> Error: could not find function "|>"
```

**Solution:** You need R >= 4.1.0 for `|>`. Use magrittr pipe instead:
```r
library(magrittr)
walks %>% visualize_walks()
```

### Problem: Functions Not Found

**Error:**
```r
random_normal_walk()
#> Error: could not find function "random_normal_walk"
```

**Solution:** Load the package
```r
library(RandomWalker)
random_normal_walk()
```

### Problem: Reproducibility Issues

**Different results each time:**
```r
walk1 <- rw30()
walk2 <- rw30()
identical(walk1, walk2)  # FALSE
```

**Solution:** Set seed
```r
set.seed(123)
walk1 <- rw30()

set.seed(123)
walk2 <- rw30()

identical(walk1, walk2)  # TRUE
```

## Error Message Index

Quick reference for common error messages:

| Error Message | Solution |
|---------------|----------|
| "The value to summarize must be provided" | Add `.value` parameter to `summarize_walks()` |
| "object 'y' not found" | Use correct column name for dimension |
| ".num_walks must be positive" | Use positive integer |
| ".dimensions must be 1, 2, or 3" | Use valid dimension |
| "Probability must be between 0 and 1" | Use value in [0, 1] range |
| "could not find function" | Load package with `library(RandomWalker)` |
| "cannot allocate vector" | Reduce data size |
| "Package version too old" | Update R to >= 4.1.0 |
| "dependencies not available" | Install dependencies manually |

## Debugging Tips

### Check Package Version

```r
packageVersion("RandomWalker")
```

### Check R Version

```r
R.version.string
```

### Check Dependencies

```r
installed.packages()[c("dplyr", "tidyr", "purrr", "rlang", "ggplot2"), "Version"]
```

### Get Session Info

```r
sessionInfo()
```

### Create Minimal Reproducible Example

```r
library(RandomWalker)

# Minimal example that demonstrates the issue
walks <- rw30()
# ... code that causes error ...
```

## Getting More Help

### Search Existing Issues

1. Go to [GitHub Issues](https://github.com/spsanderson/RandomWalker/issues)
2. Search for your problem
3. Check closed issues too

### Create New Issue

Include:
```r
# 1. Your environment
sessionInfo()

# 2. Reproducible example
library(RandomWalker)
walks <- rw30()
# ... code that causes error ...

# 3. Expected vs actual behavior
# Expected: ...
# Actual: ...

# 4. Error message (full text)
```

### Ask in Discussions

For questions (not bugs):
- [GitHub Discussions](https://github.com/spsanderson/RandomWalker/discussions)

### Contact Maintainer

- Email: spsanderson@gmail.com
- Include reproducible example and session info

## Useful Resources

- **[FAQ](FAQ.md)** - Common questions
- **[API Reference](API-Reference.md)** - Function documentation
- **[GitHub Issues](https://github.com/spsanderson/RandomWalker/issues)** - Bug reports
- **[Installation Guide](Installation.md)** - Detailed installation help

---

**Still having issues?** [Open an issue](https://github.com/spsanderson/RandomWalker/issues/new) and we'll help!
