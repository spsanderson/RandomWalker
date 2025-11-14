# Quick Start Guide

Get started with RandomWalker in just a few minutes! This guide covers the essential features to get you up and running.

## Your First Random Walk

Let's create your first random walk in just two lines of code:

```r
library(RandomWalker)
rw30()
```

This generates 30 random walks with 100 steps each. The output is a tidy tibble:

```r
#> # A tibble: 3,000 × 3
#>    walk_number step_number      y
#>    <fct>             <int>  <dbl>
#>  1 1                     1  0    
#>  2 1                     2  1.06 
#>  3 1                     3  0.977
#>  4 1                     4  1.86 
#>  5 1                     5  0.859
```

## Visualize Your Walk

Create a beautiful visualization with one function:

```r
rw30() |> visualize_walks()
```

This creates a comprehensive plot showing:
- The random walk trajectory
- Cumulative sum
- Cumulative product
- Cumulative minimum
- Cumulative maximum
- Cumulative mean

### Interactive Visualization

Make your plots interactive:

```r
rw30() |> visualize_walks(.interactive = TRUE)
```

Interactive features include:
- Hover to see values
- Zoom in/out
- Pan around
- Toolbar for navigation

## Basic Statistical Analysis

Get summary statistics for your walks:

```r
# Overall summary
rw30() |> summarize_walks(.value = y)

# Summary by walk
rw30() |> 
  summarize_walks(.value = y, .group_var = walk_number) |>
  head(10)
```

The summary includes:
- Mean, median, range
- Variance and standard deviation
- Quantiles (lo/hi)
- Min and max values
- Harmonic and geometric means
- Skewness and kurtosis

## Creating Custom Random Walks

### Normal Random Walk

Generate walks from a normal distribution with custom parameters:

```r
random_normal_walk(
  .num_walks = 5,           # Number of walks
  .n = 100,                 # Steps per walk
  .mu = 0,                  # Mean
  .sd = 0.1,                # Standard deviation
  .initial_value = 100      # Starting value
)
```

### Geometric Brownian Motion

Perfect for modeling stock prices:

```r
geometric_brownian_motion(
  .num_walks = 10,
  .n = 100,
  .mu = 0.05,              # Drift (5% growth)
  .sigma = 0.2,            # Volatility (20%)
  .initial_value = 100     # Starting price
) |> visualize_walks()
```

### Discrete Random Walk

For binary up/down movements:

```r
discrete_walk(
  .num_walks = 5,
  .n = 100,
  .upper_bound = 1,        # Maximum step size
  .lower_bound = -1,       # Minimum step size
  .upper_probability = 0.55, # Probability of moving up
  .initial_value = 0
) |> visualize_walks()
```

## Working with Multiple Distributions

Try different distributions to see how they behave:

```r
# Exponential walk (asymmetric)
random_exponential_walk(
  .num_walks = 5,
  .n = 100,
  .rate = 1
)

# Beta walk (bounded between 0 and 1)
random_beta_walk(
  .num_walks = 5,
  .n = 100,
  .shape1 = 2,
  .shape2 = 5
)

# Cauchy walk (heavy-tailed)
random_cauchy_walk(
  .num_walks = 5,
  .n = 100,
  .location = 0,
  .scale = 1
)

# Gamma walk (positive values)
random_gamma_walk(
  .num_walks = 5,
  .n = 100,
  .shape = 2,
  .rate = 1
)
```

## Multi-Dimensional Walks

### 2D Random Walk

Explore spatial movement in two dimensions:

```r
# 2D walk
walk_2d <- random_normal_walk(
  .num_walks = 3,
  .n = 100,
  .dimensions = 2
)

head(walk_2d, 10)
#> # A tibble: 10 × 8
#>    walk_number step_number      x      y cum_sum_x cum_sum_y cum_prod_x cum_prod_y
#>    <fct>             <int>  <dbl>  <dbl>     <dbl>     <dbl>      <dbl>      <dbl>
#>  1 1                     1  0      0          0         0          0          0    
#>  2 1                     2  0.106  0.197      0.106     0.197      0.106      0.197
```

### 3D Random Walk

Model particle movement in three-dimensional space:

```r
# 3D walk
walk_3d <- random_normal_walk(
  .num_walks = 2,
  .n = 50,
  .dimensions = 3
)

head(walk_3d, 10)
#> # A tibble: 10 × 11
#>    walk_number step_number      x      y      z cum_sum_x cum_sum_y cum_sum_z
#>    <fct>             <int>  <dbl>  <dbl>  <dbl>     <dbl>     <dbl>     <dbl>
#>  1 1                     1  0      0      0          0         0         0    
#>  2 1                     2  0.106  0.197 -0.031      0.106     0.197    -0.031
```

### Calculate Distance Traveled

For multi-dimensional walks, calculate Euclidean distance:

```r
walk_2d |>
  euclidean_distance(.x = x, .y = y)
```

## Advanced Visualization Options

### Visualize Specific Attributes

Focus on specific aspects of your walks:

```r
# Show only cumulative sum
random_normal_walk() |> visualize_walks(.pluck = "cum_sum")

# Show multiple specific attributes
random_normal_walk(.num_walks = 5, .initial_value = 100) |>
  visualize_walks(.pluck = c("y", "cum_sum"))
```

### Adjust Plot Aesthetics

Customize the appearance:

```r
# Adjust transparency
rw30() |> visualize_walks(.alpha = 0.5)

# More opaque lines
rw30() |> visualize_walks(.alpha = 0.9)
```

## Pipe-Friendly Workflow

RandomWalker works seamlessly with pipes:

```r
# Using R 4.1+ native pipe
random_normal_walk(.num_walks = 10, .n = 100) |>
  summarize_walks(.value = y, .group_var = walk_number) |>
  dplyr::filter(mean_val > 0) |>
  head()

# Using magrittr pipe (if you prefer)
library(magrittr)
random_normal_walk(.num_walks = 10, .n = 100) %>%
  visualize_walks()
```

## Combining with dplyr

Leverage dplyr for data manipulation:

```r
library(dplyr)

# Filter to specific walks
random_normal_walk(.num_walks = 10, .n = 100) |>
  filter(walk_number %in% c("1", "5", "10")) |>
  visualize_walks()

# Add custom calculations
random_normal_walk(.num_walks = 5, .n = 100, .initial_value = 100) |>
  mutate(
    pct_change = (cum_sum_y - lag(cum_sum_y)) / lag(cum_sum_y) * 100,
    is_positive = cum_sum_y > 100
  ) |>
  select(walk_number, step_number, cum_sum_y, pct_change, is_positive)
```

## Subset Walks by Values

Find walks with specific characteristics:

```r
# Get walks with maximum value
rw30() |> 
  subset_walks(.value = "y", .type = "max")

# Get walks with minimum value
rw30() |> 
  subset_walks(.value = "y", .type = "min")
```

## Reproducibility with Seeds

Set seeds for reproducible results:

```r
# Set seed before generating walks
set.seed(123)
walk1 <- rw30()

# Same seed produces same result
set.seed(123)
walk2 <- rw30()

identical(walk1, walk2)  # TRUE
```

## Accessing Attributes

Each random walk has metadata stored as attributes:

```r
walks <- rw30()
atb <- attributes(walks)

# View attributes (excluding row names)
atb[!names(atb) %in% c("row.names")]
```

Common attributes include:
- `fns` - Function name used
- `num_walks` - Number of walks generated
- `n` - Steps per walk
- `mu`, `sd` - Distribution parameters
- `initial_value` - Starting value
- `dimensions` - Number of dimensions

## Quick Reference Card

| Task | Function | Example |
|------|----------|---------|
| Generate 30 walks | `rw30()` | `rw30()` |
| Normal walk | `random_normal_walk()` | `random_normal_walk(.num_walks = 5)` |
| Brownian motion | `brownian_motion()` | `brownian_motion(.num_walks = 5)` |
| Geometric Brownian | `geometric_brownian_motion()` | `geometric_brownian_motion(.num_walks = 5)` |
| Discrete walk | `discrete_walk()` | `discrete_walk(.num_walks = 5)` |
| Visualize | `visualize_walks()` | `walks \|> visualize_walks()` |
| Summarize | `summarize_walks()` | `walks \|> summarize_walks(.value = y)` |
| Interactive plot | `visualize_walks(.interactive = TRUE)` | `walks \|> visualize_walks(.interactive = TRUE)` |
| 2D walk | `random_normal_walk(.dimensions = 2)` | `random_normal_walk(.dimensions = 2)` |
| 3D walk | `random_normal_walk(.dimensions = 3)` | `random_normal_walk(.dimensions = 3)` |

## Common Workflows

### Financial Modeling

```r
# Model stock prices
stock_price <- geometric_brownian_motion(
  .num_walks = 100,
  .n = 252,  # Trading days in a year
  .mu = 0.08,
  .sigma = 0.25,
  .initial_value = 100
)

# Visualize scenarios
stock_price |> visualize_walks(.alpha = 0.3)

# Analyze outcomes
stock_price |>
  summarize_walks(.value = cum_prod, .group_var = walk_number) |>
  summarize(
    prob_profit = mean(max_val > 100),
    avg_return = mean((max_val - 100) / 100)
  )
```

### Physics Simulation

```r
# Simulate particle diffusion in 3D
particle <- brownian_motion(
  .num_walks = 50,
  .n = 1000,
  .dimensions = 3
)

# Calculate distance from origin
particle |>
  euclidean_distance(.x = x, .y = z) |>
  visualize_walks()
```

### Algorithm Testing

```r
# Generate test data
test_data <- discrete_walk(
  .num_walks = 1000,
  .n = 100,
  .upper_probability = 0.5
)

# Use for testing your algorithms
# ... your analysis code ...
```

## Next Steps

Now that you know the basics, explore more advanced topics:

- **[Continuous Distribution Generators](Continuous-Distribution-Generators.md)** - Explore all continuous distributions
- **[Discrete Distribution Generators](Discrete-Distribution-Generators.md)** - Work with discrete distributions
- **[Visualization Guide](Visualization-Guide.md)** - Master plotting techniques
- **[Statistical Analysis Guide](Statistical-Analysis-Guide.md)** - Deep dive into analysis
- **[Multi-Dimensional Walks](Multi-Dimensional-Walks.md)** - Advanced spatial modeling
- **[Use Cases and Examples](Use-Cases-and-Examples.md)** - Real-world applications

## Getting Help

- **Function help**: Use `?function_name`, e.g., `?random_normal_walk`
- **Vignette**: `vignette("getting-started")`
- **Examples**: Most functions have built-in examples - check `?function_name`
- **Issues**: [GitHub Issues](https://github.com/spsanderson/RandomWalker/issues)
- **Discussions**: [GitHub Discussions](https://github.com/spsanderson/RandomWalker/discussions)

---

**Ready for more?** Check out the **[Use Cases and Examples](Use-Cases-and-Examples.md)** page for real-world applications!
