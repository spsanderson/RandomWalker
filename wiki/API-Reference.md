# API Reference

Complete reference for all RandomWalker functions, organized by category.

## Quick Navigation

- [Automatic Random Walks](#automatic-random-walks)
- [Continuous Distribution Generators](#continuous-distribution-generators)
- [Discrete Distribution Generators](#discrete-distribution-generators)
- [Custom Walks](#custom-walks)
- [Visualization Functions](#visualization-functions)
- [Statistical Functions](#statistical-functions)
- [Vector Functions](#vector-functions)
- [Utility Functions](#utility-functions)

## Automatic Random Walks

### `rw30()`

Quickly generate 30 random walks with 100 steps each.

**Usage:**
```r
rw30()
```

**Parameters:** None

**Returns:** Tibble with 3,000 rows (30 walks × 100 steps)

**Columns:**
- `walk_number`: Factor identifying each walk
- `step_number`: Integer step counter (1-100)
- `y`: Random walk values
- `cum_sum`, `cum_prod`, `cum_min`, `cum_max`, `cum_mean`: Cumulative functions can be added but are not returned

**Examples:**
```r
# Generate and view
rw30()

# Visualize
rw30() |> visualize_walks()

# Analyze
rw30() |> summarize_walks(.value = y)
```

---

## Continuous Distribution Generators

All continuous distribution generators share these common parameters:

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `.num_walks` | Integer | 25 | Number of walks to generate |
| `.n` | Integer | 100 | Number of steps per walk |
| `.initial_value` | Numeric | 0 | Starting value |
| `.dimensions` | Integer | 1 | Spatial dimensions (1, 2, or 3) |

### `random_normal_walk()`

Generate random walks using normal distribution.

**Additional Parameters:**
- `.mu`: Mean (default: 0)
- `.sd`: Standard deviation (default: 1)

**Example:**
```r
random_normal_walk(.num_walks = 10, .mu = 0, .sd = 1)
```

### `random_normal_drift_walk()`

Generate random walks with explicit drift component.

**Additional Parameters:**
- `.mu`: Drift parameter (default: 0)
- `.sd`: Standard deviation (default: 1)

### `brownian_motion()`

Generate standard Brownian motion (Wiener process).

**Additional Parameters:**
- `.mu`: Drift coefficient (default: 0)
- `.sigma`: Volatility coefficient (default: 1)

### `geometric_brownian_motion()`

Generate geometric Brownian motion (for stock prices).

**Additional Parameters:**
- `.mu`: Expected return (default: 0)
- `.sigma`: Volatility (default: 1)

**Note:** Initial value defaults to 100 for this function.

### `random_beta_walk()`

Generate walks using beta distribution.

**Additional Parameters:**
- `.shape1`: First shape parameter (α)
- `.shape2`: Second shape parameter (β)
- `.ncp`: Non-centrality parameter (default: 0)

### `random_cauchy_walk()`

Generate walks using Cauchy distribution (heavy tails).

**Additional Parameters:**
- `.location`: Location parameter (default: 0)
- `.scale`: Scale parameter (default: 1)

### `random_chisquared_walk()`

Generate walks using chi-squared distribution.

**Additional Parameters:**
- `.df`: Degrees of freedom
- `.ncp`: Non-centrality parameter (default: 0)

### `random_exponential_walk()`

Generate walks using exponential distribution.

**Additional Parameters:**
- `.rate`: Rate parameter (default: 1)

### `random_f_walk()`

Generate walks using F-distribution.

**Additional Parameters:**
- `.df1`: Numerator degrees of freedom
- `.df2`: Denominator degrees of freedom
- `.ncp`: Non-centrality parameter (default: 0)

### `random_gamma_walk()`

Generate walks using gamma distribution.

**Additional Parameters:**
- `.shape`: Shape parameter
- `.rate`: Rate parameter (default: 1)
- `.scale`: Scale parameter (default: 1/rate)

### `random_lognormal_walk()`

Generate walks using log-normal distribution.

**Additional Parameters:**
- `.meanlog`: Mean of log (default: 0)
- `.sdlog`: Standard deviation of log (default: 1)

### `random_logistic_walk()`

Generate walks using logistic distribution.

**Additional Parameters:**
- `.location`: Location parameter (default: 0)
- `.scale`: Scale parameter (default: 1)

### `random_t_walk()`

Generate walks using Student's t-distribution.

**Additional Parameters:**
- `.df`: Degrees of freedom
- `.ncp`: Non-centrality parameter (default: 0)

### `random_uniform_walk()`

Generate walks using uniform distribution.

**Additional Parameters:**
- `.min`: Minimum value (default: 0)
- `.max`: Maximum value (default: 1)

### `random_weibull_walk()`

Generate walks using Weibull distribution.

**Additional Parameters:**
- `.shape`: Shape parameter
- `.scale`: Scale parameter (default: 1)

---

## Discrete Distribution Generators

### `discrete_walk()`

Generate simple discrete random walks (binary up/down).

**Parameters:**
- `.num_walks`: Number of walks (default: 25)
- `.n`: Number of steps (default: 100)
- `.upper_bound`: Maximum step size (default: 1)
- `.lower_bound`: Minimum step size (default: -1)
- `.upper_probability`: Probability of moving up (default: 0.5)
- `.initial_value`: Starting value (default: 0)
- `.dimensions`: Spatial dimensions (default: 1)

### `random_binomial_walk()`

Generate walks using binomial distribution.

**Additional Parameters:**
- `.size`: Number of trials
- `.prob`: Probability of success (default: 0.5)

### `random_geometric_walk()`

Generate walks using geometric distribution.

**Additional Parameters:**
- `.prob`: Probability of success

### `random_hypergeometric_walk()`

Generate walks using hypergeometric distribution.

**Additional Parameters:**
- `.m`: Number of white balls
- `.n_param`: Number of black balls
- `.k`: Number of balls drawn

### `random_multinomial_walk()`

Generate walks using multinomial distribution.

**Additional Parameters:**
- `.size`: Number of trials
- `.prob`: Vector of probabilities (must sum to 1)

### `random_negbinomial_walk()`

Generate walks using negative binomial distribution.

**Additional Parameters:**
- `.size`: Target number of successes
- `.prob`: Probability of success
- `.mu`: Alternative parameterization (mean)

### `random_poisson_walk()`

Generate walks using Poisson distribution.

**Additional Parameters:**
- `.lambda`: Rate parameter (mean and variance)

### `random_wilcox_walk()`

Generate walks using Wilcoxon rank sum statistic distribution.

**Additional Parameters:**
- `.m`: Number of observations in first group
- `.n_param`: Number of observations in second group

### `random_wilcoxon_sr_walk()`

Generate walks using Wilcoxon signed rank statistic distribution.

**Additional Parameters:**
- `.n_param`: Number of observations

### `random_smirnov_walk()`

Generate walks using Kolmogorov-Smirnov statistic distribution.

**Additional Parameters:**
- `.n_param`: Sample size

---

## Custom Walks

### `custom_walk()`

Generate random walks with custom displacement function.

**Parameters:**
- `.num_walks`: Number of walks (default: 25)
- `.n`: Number of steps (default: 100)
- `.displacement_fn`: Custom function that returns displacement value
- `.initial_value`: Starting value (default: 0)
- `.dimensions`: Spatial dimensions (default: 1)

**Example:**
```r
# Custom function
my_displacement <- function() {
  sample(c(-2, -1, 0, 1, 2), 1, prob = c(0.1, 0.2, 0.4, 0.2, 0.1))
}

# Generate walk
custom_walk(
  .num_walks = 10,
  .displacement_fn = my_displacement
)
```

### `random_displacement_walk()`

Generate walks with custom displacement from a vector.

**Parameters:**
- `.num_walks`: Number of walks (default: 25)
- `.n`: Number of steps (default: 100)
- `.displacement`: Vector of possible displacement values
- `.initial_value`: Starting value (default: 0)
- `.dimensions`: Spatial dimensions (default: 1)

---

## Visualization Functions

### `visualize_walks()`

Create comprehensive visualizations of random walks.

**Parameters:**
- `.data`: Random walk data (tibble)
- `.alpha`: Line transparency, 0-1 (default: 0.7)
- `.interactive`: Boolean, create interactive plot (default: FALSE)
- `.pluck`: Select specific attributes to plot (default: FALSE shows all)
  - Options: `"y"`, `"cum_sum"`, `"cum_prod"`, `"cum_min"`, `"cum_max"`, `"cum_mean"`
  - Can be a vector: `c("y", "cum_sum")`

**Returns:** 
- Static mode: ggplot2/patchwork object
- Interactive mode: ggiraph object

**Examples:**
```r
# Basic visualization
rw30() |> visualize_walks()

# Adjust transparency
rw30() |> visualize_walks(.alpha = 0.3)

# Interactive
rw30() |> visualize_walks(.interactive = TRUE)

# Select specific panels
rw30() |> visualize_walks(.pluck = "cum_sum")
rw30() |> visualize_walks(.pluck = c("y", "cum_sum", "cum_mean"))
```

---

## Statistical Functions

### `summarize_walks()`

Compute comprehensive summary statistics for random walks.

**Parameters:**
- `.data`: Random walk data (tibble)
- `.value`: Column name to summarize (unquoted)
- `.group_var`: Optional grouping variable (unquoted)

**Returns:** Tibble with statistics:
- `fns`: Function name
- `fns_name`: Formatted function name
- `dimensions`: Number of dimensions
- `mean_val`: Mean
- `median`: Median
- `range`: Range (max - min)
- `quantile_lo`, `quantile_hi`: Quantiles
- `variance`, `sd`: Variance and standard deviation
- `min_val`, `max_val`: Minimum and maximum
- `harmonic_mean`, `geometric_mean`: Alternative means
- `skewness`, `kurtosis`: Shape measures

**Examples:**
```r
walks <- rw30()

# Overall summary
walks |> summarize_walks(.value = y)

# By walk
walks |> summarize_walks(.value = y, .group_var = walk_number)

# Cumulative sum
walks |> summarize_walks(.value = cum_sum)
```

### `subset_walks()`

Extract walks with extreme values.

**Parameters:**
- `.data`: Random walk data (tibble)
- `.value`: Column name to subset by (default: "y")
- `.subset_type`: Type of subset ("max" or "min")

**Returns:** Tibble containing only the selected walk

**Examples:**
```r
walks <- rw30()

# Walk with maximum value
walks |> subset_walks(.value = "cum_sum", .subset_type = "max")

# Walk with minimum value
walks |> subset_walks(.value = "cum_sum", .subset_type = "min")
```

---

## Vector Functions

### `confidence_interval()`

Calculate confidence interval for a vector.

**Parameters:**
- `.x`: Numeric vector
- `.alpha`: Significance level (default: 0.05 for 95% CI)

**Returns:** Tibble with columns:
- `mean`: Mean value
- `ci_lower`: Lower confidence bound
- `ci_upper`: Upper confidence bound
- `sd`: Standard deviation

**Example:**
```r
x <- rnorm(1000, mean = 10, sd = 2)
confidence_interval(x)

# 99% CI
confidence_interval(x, .alpha = 0.01)
```

### `running_quantile()`

Calculate running quantile at each position.

**Parameters:**
- `.x`: Numeric vector
- `.probs`: Probability value (0-1)

**Returns:** Numeric vector of same length

**Example:**
```r
x <- rnorm(100)
running_quantile(x, .probs = 0.5)  # Running median
```

### `euclidean_distance()`

Calculate Euclidean distance from origin for multi-dimensional walks.

**Parameters:**
- `.data`: Multi-dimensional random walk data (tibble)

**Returns:** Original data with added `distance` column

**Example:**
```r
walk_2d <- random_normal_walk(.dimensions = 2)
walk_2d |> euclidean_distance()
```

### Cumulative Functions

These are automatically included in walk data:

- `std_cum_sum_augment()`: Cumulative sum
- `std_cum_prod_augment()`: Cumulative product
- `std_cum_min_augment()`: Cumulative minimum
- `std_cum_max_augment()`: Cumulative maximum
- `std_cum_mean_augment()`: Cumulative mean

Generally used internally, but can be applied to custom data.

---

## Utility Functions

### `rand_walk_helper()`

Internal helper for adding cumulative columns.

**Parameters:**
- `.data`: Data frame
- `.value`: Initial value

**Returns:** Data frame with cumulative columns added

**Note:** Typically used internally by generator functions.

### `convert_snake_to_title_case()`

Convert snake_case strings to Title Case.

**Parameters:**
- `string`: Character string in snake_case

**Returns:** Character string in Title Case

**Example:**
```r
convert_snake_to_title_case("random_normal_walk")
#> "Random Normal Walk"

convert_snake_to_title_case("cum_sum")
#> "Cumulative Sum"
```

### `get_attributes()`

Get attributes without row names.

**Parameters:**
- `.data`: Object with attributes

**Returns:** List of attributes (excluding row.names)

**Example:**
```r
walks <- rw30()
get_attributes(walks)
```

---

## Data Structure

### Return Format

All generator functions return a tibble with consistent structure:

**1D Walks:**
```r
# A tibble: N × 8
  walk_number step_number     y cum_sum cum_prod cum_min cum_max cum_mean
  <fct>             <int> <dbl>   <dbl>    <dbl>   <dbl>   <dbl>    <dbl>
```

**2D Walks:**
```r
# A tibble: N × 14
  walk_number step_number     x     y cum_sum_x cum_sum_y cum_prod_x cum_prod_y
  <fct>             <int> <dbl> <dbl>     <dbl>     <dbl>      <dbl>      <dbl>
  # ... with 6 more columns: cum_min_x, cum_min_y, cum_max_x, cum_max_y,
  #   cum_mean_x, cum_mean_y
```

**3D Walks:**
```r
# A tibble: N × 20
  walk_number step_number     x     y     z cum_sum_x cum_sum_y cum_sum_z
  <fct>             <int> <dbl> <dbl> <dbl>     <dbl>     <dbl>     <dbl>
  # ... with 12 more columns for cumulative functions
```

### Attributes

All generated walks include attributes:

```r
walks <- random_normal_walk(.num_walks = 10, .n = 100)
attributes(walks)

# Common attributes:
# - fns: Function name
# - num_walks: Number of walks
# - n: Steps per walk
# - initial_value: Starting value
# - dimensions: Spatial dimensions
# - Distribution-specific parameters (mu, sd, lambda, etc.)
```

---

## Package Information

**Version:** 1.0.0.9000 (development)

**License:** MIT

**Authors:**
- Steven P. Sanderson II, MPH (Author, Creator, Maintainer)
- Antti Rask (Contributor, Visualization)

**Dependencies:**
- dplyr
- tidyr
- purrr
- rlang
- patchwork
- NNS
- ggiraph

**Suggested:**
- knitr
- rmarkdown
- stats
- ggplot2
- tidyselect

---

## Function Index

### By Category

**Generation:**
- `rw30()` - Quick 30 walks
- `random_normal_walk()` - Normal distribution
- `brownian_motion()` - Brownian motion
- `geometric_brownian_motion()` - GBM
- `discrete_walk()` - Binary walk
- 20+ more distribution generators

**Visualization:**
- `visualize_walks()` - Main plotting function

**Analysis:**
- `summarize_walks()` - Summary statistics
- `subset_walks()` - Extract extremes
- `euclidean_distance()` - Distance calculations
- `confidence_interval()` - Confidence intervals
- `running_quantile()` - Running quantiles

**Utilities:**
- `rand_walk_helper()` - Add cumulative columns
- `convert_snake_to_title_case()` - String formatting
- `get_attributes()` - Get attributes

---

## See Also

- **[Quick Start Guide](Quick-Start-Guide.md)** - Get started quickly
- **[Continuous Distributions](Continuous-Distribution-Generators.md)** - Detailed distribution guide
- **[Discrete Distributions](Discrete-Distribution-Generators.md)** - Discrete distribution guide
- **[Visualization Guide](Visualization-Guide.md)** - Advanced plotting
- **[Statistical Analysis](Statistical-Analysis-Guide.md)** - Analysis techniques
- **[FAQ](FAQ.md)** - Common questions

**Online Documentation:** https://www.spsanderson.com/RandomWalker/
