# Automatic Random Walks

The simplest way to generate random walks with RandomWalker is using the automatic function `rw30()`.

## Table of Contents

- [Overview](#overview)
- [The rw30() Function](#the-rw30-function)
- [Understanding the Output](#understanding-the-output)
- [Common Usage Patterns](#common-usage-patterns)
- [When to Use rw30()](#when-to-use-rw30)
- [Limitations](#limitations)

## Overview

RandomWalker provides `rw30()` as a quick way to generate random walks without specifying any parameters. This is perfect for:

- Quick demonstrations
- Learning and teaching
- Prototyping
- Exploratory analysis

## The rw30() Function

### Basic Usage

```r
library(RandomWalker)

# Generate 30 random walks
walks <- rw30()

# View the data
head(walks, 10)
```

### What rw30() Does

The `rw30()` function:
1. Generates **30 random walks**
2. Each with **100 steps**
3. Using **normal distribution** (mean = 0, sd = 1)
4. Starting at **0**
5. Returns a **tidy tibble**

It's equivalent to:
```r
random_normal_walk(
  .num_walks = 30,
  .n = 100,
  .mu = 0,
  .sd = 1,
  .initial_value = 0,
  .dimensions = 1
)
```

### Output Structure

```r
rw30()
#> # A tibble: 3,000 × 8
#>    walk_number step_number      y cum_sum cum_prod cum_min cum_max cum_mean
#>    <fct>             <int>  <dbl>   <dbl>    <dbl>   <dbl>   <dbl>    <dbl>
#>  1 1                     1  0       0        0       0       0        0    
#>  2 1                     2  1.06    1.06     1.06    0       1.06     0.531
#>  3 1                     3 -0.082   0.977    0.913   0       1.06     0.489
#>  4 1                     4  0.888   1.86     1.72    0       1.86     0.621
```

**Columns:**
- `walk_number`: Factor (1-30) identifying each walk
- `step_number`: Integer (1-100) for each step
- `y`: The random walk values
- `cum_sum`: Cumulative sum
- `cum_prod`: Cumulative product
- `cum_min`: Cumulative minimum
- `cum_max`: Cumulative maximum
- `cum_mean`: Cumulative mean

## Understanding the Output

### Walk Structure

Each walk consists of 100 steps:
```r
walks <- rw30()

# Count steps per walk
walks |>
  group_by(walk_number) |>
  summarize(n_steps = n())
#> All walks have 100 steps
```

### Random Walk Behavior

Since steps are drawn from N(0,1):
```r
# Mean of steps should be ≈ 0
mean(walks$y)

# Standard deviation is 1 for the function, but it returns the cumsum of y so it won't show as 1
sd(walks$y)

# Final positions vary widely
walks |>
  group_by(walk_number) |>
  slice_max(step_number) |>
  pull(y) |>
  range()
```

### Attributes

The function stores metadata:
```r
walks <- rw30()
attributes(walks)

# Key attributes:
# $fns: "rw30"
# $num_walks: 30
# $num_steps: 100
# $mu: 0
# $sd: 1
```

## Common Usage Patterns

### Pattern 1: Quick Visualization

```r
# One line to plot
rw30() |> visualize_walks()

# Interactive exploration
rw30() |> visualize_walks(.interactive = TRUE)
```

### Pattern 2: Statistical Analysis

```r
# Overall statistics
rw30() |> summarize_walks(.value = y)

# By walk
rw30() |>
  summarize_walks(.value = y, .group_var = walk_number) |>
  head(10)

# Custom analysis
rw30() |>
  group_by(walk_number) |>
  summarize(
    final_value = last(y),
    max_value = max(y),
    min_value = min(y),
    volatility = sd(y)
  )
```

### Pattern 3: Finding Extremes

```r
library(RandomWalker)
library(dplyr)
library(ggplot2)

# Walk that went highest
max_walk <- rw30() |>
  subset_walks(.value = "y", .type = "max")

# Walk that went lowest
min_walk <- rw30() |>
  subset_walks(.value = "y", .type = "min")

# Compare extremes
library(patchwork)

p1 <- max_walk |> visualize_walks() +
  labs(title = "Highest Walk")

p2 <- min_walk |> visualize_walks() +
  labs(title = "Lowest Walk")

p1 / p2

# Or
rw30() |>
  subset_walks(.value = "y", .type = "both") |>
  visualize_walks() +
  labs(title = "Highest Walk")
```

### Pattern 4: Filtering and Subsetting

```r
library(dplyr)
library(ggplot2)

walks <- rw30()

# Get only first 10 walks
walks |>
  filter(walk_number %in% as.character(1:10)) |>
  visualize_walks()

# Get steps 50-100 only
walks |>
  filter(step_number >= 50) |>
  visualize_walks()

# Find walks that crossed zero
walks |>
  group_by(walk_number) |>
  filter(any(cumsum(y) < 0) & any(cumsum(y) > 0)) |> 
  ungroup() |>
  ggplot(aes(x = step_number, y = cumsum(y), group = walk_number, color = walk_number)) +
  geom_line() +
  labs(title = "Walks That Crossed Zero")
```

### Pattern 5: Teaching Demonstrations

```r
# Show variability
library(ggplot2)

walks <- rw30()

# Distribution of final positions
walks |>
  group_by(walk_number) |>
  slice_max(step_number) |>
  ggplot(aes(x = y)) +
  geom_histogram(bins = 15, fill = "steelblue", alpha = 0.7) +
  geom_vline(xintercept = 0, color = "red", linetype = "dashed") +
  theme_minimal() +
  labs(
    title = "Distribution of Final Positions",
    subtitle = "30 random walks, 100 steps each",
    x = "Final Position",
    y = "Count"
  )
```

### Pattern 6: Comparing to Theory

```r
# Test if variance grows linearly with steps
walks <- rw30()

variance_by_step <- walks |>
  group_by(step_number) |>
  reframe(
    variance = var(y),
    theoretical = step_number  # For N(0,1), var = n
  )

ggplot(variance_by_step, aes(x = step_number)) +
  geom_line(aes(y = variance, color = "Observed"), linewidth = 1) +
  geom_line(aes(y = theoretical, color = "Theoretical"), linewidth = 1, linetype = "dashed") +
  scale_color_manual(values = c("Observed" = "blue", "Theoretical" = "red")) +
  theme_minimal() +
  labs(
    title = "Variance Growth in Random Walk",
    subtitle = "Observed vs Theoretical (Var = n)",
    x = "Step Number",
    y = "Variance",
    color = ""
  )
```

## When to Use rw30()

### ✅ Use rw30() When:

- **Learning**: First time using RandomWalker
- **Demos**: Quick demonstrations
- **Teaching**: Showing random walk concepts
- **Prototyping**: Testing visualization or analysis code
- **Exploratory**: Quick data exploration

### ❌ Don't Use rw30() When:

- **Custom parameters needed**: Use `random_normal_walk()` instead
- **Different distribution**: Use specific generator functions
- **Different number of walks**: rw30() always generates 30
- **Multi-dimensional**: rw30() is 1D only
- **Production code**: Use explicit generator functions for clarity

## Limitations

### Fixed Parameters

`rw30()` has no parameters, which means:

```r
# ❌ Can't change number of walks
# rw30(.num_walks = 50)  # Error!

# ✅ Use random_normal_walk() instead
random_normal_walk(.num_walks = 50)

# ❌ Can't change number of steps
# rw30(.n = 200)  # Error!

# ✅ Use random_normal_walk() instead
random_normal_walk(.n = 200)

# ❌ Can't change distribution parameters
# rw30(.mu = 0.1)  # Error!

# ✅ Use random_normal_walk() instead
random_normal_walk(.mu = 0.1)
```

### Only Normal Distribution

`rw30()` uses normal distribution exclusively:

```r
# ❌ Can't use other distributions
# rw30(.distribution = "cauchy")  # Not possible!

# ✅ Use specific generator functions
random_cauchy_walk(.num_walks = 30)
geometric_brownian_motion(.num_walks = 30)
discrete_walk(.num_walks = 30)
```

### Only 1D

`rw30()` generates 1D walks only:

```r
# ❌ Can't create 2D walks
# rw30(.dimensions = 2)  # Error!

# ✅ Use random_normal_walk()
random_normal_walk(.num_walks = 30, .dimensions = 2)
```

## Alternatives to rw30()

When `rw30()` doesn't fit your needs:

### For Custom Parameters

```r
# Instead of rw30()
random_normal_walk(
  .num_walks = 30,
  .n = 100,
  .mu = 0,
  .sd = 1,
  .initial_value = 0
)

# With custom parameters
random_normal_walk(
  .num_walks = 50,
  .n = 200,
  .mu = 0.05,
  .sd = 0.5,
  .initial_value = 100
)
```

### For Different Distributions

```r
# Geometric Brownian Motion (like rw30 but for stocks)
geometric_brownian_motion(
  .num_walks = 30,
  .n = 100,
  .initial_value = 100
)

# Heavy-tailed walks
random_cauchy_walk(
  .num_walks = 30,
  .n = 100
)

# Discrete walks
discrete_walk(
  .num_walks = 30,
  .n = 100
)
```

### For Multi-Dimensional

```r
# 2D walks
random_normal_walk(
  .num_walks = 30,
  .n = 100,
  .dimensions = 2
)

# 3D walks
random_normal_walk(
  .num_walks = 30,
  .n = 100,
  .dimensions = 3
)
```

## Complete Examples

### Example 1: Teaching Random Walk Properties

```r
library(RandomWalker)
library(ggplot2)
library(dplyr)

# Generate walks
walks <- rw30()

# Show that mean displacement is zero
walks |>
  group_by(step_number) |>
  summarize(mean_position = mean(cumsum(y))) |>
  ggplot(aes(x = step_number, y = mean_position)) +
  geom_line(color = "blue", linewidth = 1) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  theme_minimal() +
  labs(
    title = "Mean Position Over Time",
    subtitle = "Averages to zero (red line)",
    x = "Step",
    y = "Mean Position"
  )

# Show that standard deviation grows as sqrt(n)
walks |>
  group_by(step_number) |>
  reframe(
    sd_position = sd(cumsum(y)),
    theoretical = sqrt(step_number)
  ) |>
  ungroup() |>
  ggplot(aes(x = step_number)) +
  geom_line(aes(y = sd_position, color = "Observed"), linewidth = 1) +
  geom_line(aes(y = theoretical, color = "Theoretical"), linewidth = 1, linetype = "dashed") +
  scale_color_manual(values = c("Observed" = "blue", "Theoretical" = "red")) +
  theme_minimal() +
  labs(
    title = "Standard Deviation Growth",
    subtitle = "Should follow sqrt(n) (red dashed line)",
    x = "Step",
    y = "Standard Deviation",
    color = ""
  )
```

### Example 2: First Passage Time

```r
# Find when walks first cross a threshold
walks <- rw30()

first_crossing <- walks |>
  group_by(walk_number) |>
  filter(cumsum(y) >= 5) |>
  slice_min(step_number, n = 1) |>
  select(walk_number, first_crossing_time = step_number)

# Some walks may never cross
n_crossed <- nrow(first_crossing)
cat(sprintf("%d out of 30 walks crossed 5\n", n_crossed))

# Distribution of first crossing times
if (n_crossed > 0) {
  ggplot(first_crossing, aes(x = first_crossing_time)) +
    geom_histogram(bins = 20, fill = "steelblue", alpha = 0.7) +
    theme_minimal() +
    labs(
      title = "First Passage Time Distribution",
      subtitle = "Time to first cross level 5",
      x = "Step Number",
      y = "Count"
    )
}
```

### Example 3: Maximum Excursion

```r
# Find maximum distance from origin
walks <- rw30()

max_excursion <- walks |>
  group_by(walk_number) |>
  summarize(
    max_positive = max(cumsum(y)),
    max_negative = min(cumsum(y)),
    max_excursion = max(abs(cumsum(y)))
  )

# Visualize
max_excursion |>
  ggplot(aes(x = max_excursion)) +
  geom_histogram(bins = 15, fill = "steelblue", alpha = 0.7) +
  theme_minimal() +
  labs(
    title = "Distribution of Maximum Excursions",
    subtitle = "Maximum absolute distance from origin",
    x = "Maximum Excursion",
    y = "Count"
  )
```

## Next Steps

Once you're comfortable with `rw30()`, explore:

- **[Quick Start Guide](Quick-Start-Guide.md)** - Learn more random walk functions
- **[Continuous Distribution Generators](Continuous-Distribution-Generators.md)** - Explore all distributions
- **[Visualization Guide](Visualization-Guide.md)** - Create better plots
- **[Statistical Analysis Guide](Statistical-Analysis-Guide.md)** - Analyze your walks

---

**Ready for more control?** Check out **[Continuous Distribution Generators](Continuous-Distribution-Generators.md)** for customizable random walks!
