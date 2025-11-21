# Statistical Analysis Guide

RandomWalker provides comprehensive statistical analysis capabilities for random walks. This guide covers all the tools available for analyzing and understanding your random walk data.

## Table of Contents

- [Summary Statistics](#summary-statistics)
- [Cumulative Functions](#cumulative-functions)
- [Confidence Intervals](#confidence-intervals)
- [Running Quantiles](#running-quantiles)
- [Distance Calculations](#distance-calculations)
- [Subsetting Walks](#subsetting-walks)
- [Advanced Analysis](#advanced-analysis)
- [Statistical Tests](#statistical-tests)

## Summary Statistics

### Basic Summary with `summarize_walks()`

The `summarize_walks()` function computes comprehensive statistics:

```r
library(RandomWalker)
library(dplyr)

# Generate walks
walks <- random_normal_walk(.num_walks = 30, .n = 100)

# Overall summary
walks |> summarize_walks(.value = y)
#> # A tibble: 1 × 16
#>   fns                 fns_name dimensions mean_val median range quantile_lo quantile_hi variance    sd
#>   <chr>               <chr>         <dbl>    <dbl>  <dbl> <dbl>       <dbl>       <dbl>    <dbl> <dbl>
#> 1 random_normal_walk  Random …          1   0.0123  0.015  12.1       -3.05        2.98     2.99  1.73

# Summary by walk
walks |>
  summarize_walks(.value = y, .group_var = walk_number) |>
  head()
```

**Statistics Included:**
- `fns` - Function name used to generate walks
- `fns_name` - Formatted function name
- `dimensions` - Number of dimensions (1, 2, or 3)
- `mean_val` - Mean of all values
- `median` - Median value
- `range` - Difference between max and min
- `quantile_lo` - Lower quantile (default 0.025)
- `quantile_hi` - Upper quantile (default 0.975)
- `variance` - Variance
- `sd` - Standard deviation
- `min_val` - Minimum value
- `max_val` - Maximum value
- `harmonic_mean` - Harmonic mean
- `geometric_mean` - Geometric mean
- `skewness` - Skewness (measure of asymmetry)
- `kurtosis` - Kurtosis (measure of tail heaviness)

### Analyzing Different Values

```r
# Summarize cumulative sum
walks |> summarize_walks(.value = cum_sum_y)

# Summarize cumulative product
geometric_brownian_motion(.num_walks = 30, .initial_value = 100) |>
  summarize_walks(.value = cum_prod_y)

# Summarize by group
walks |>
  summarize_walks(.value = cum_sum_y, .group_var = walk_number)
```

### Understanding Output Columns

**Location Measures:**
- `mean_val`: Average value across all observations
- `median`: Middle value (50th percentile)
- `harmonic_mean`: Harmonic mean (useful for rates and ratios)
- `geometric_mean`: Geometric mean (useful for growth rates)

**Dispersion Measures:**
- `variance`: Average squared deviation from mean
- `sd`: Standard deviation (square root of variance)
- `range`: Max - Min
- `quantile_lo` / `quantile_hi`: Lower and upper quantiles

**Shape Measures:**
- `skewness`: 
  - = 0: Symmetric distribution
  - > 0: Right-skewed (tail extends right)
  - < 0: Left-skewed (tail extends left)
- `kurtosis`:
  - ≈ 3: Normal distribution
  - > 3: Heavy tails (more extreme values)
  - < 3: Light tails (fewer extreme values)

### Practical Examples

#### Example 1: Analyzing Stock Price Simulations

```r
# Simulate stock prices
stock_sim <- geometric_brownian_motion(
  .num_walks = 1000,
  .n = 252,  # Trading days
  .mu = 0.08,
  .sigma = 0.25,
  .initial_value = 100
)

# Get final price statistics
final_prices <- stock_sim |>
  summarize_walks(.value = cum_prod_y, .group_var = walk_number) |>
  pull(max_val)

# Analyze outcomes
tibble(final_price = final_prices) |>
  summarize(
    median_price = median(final_price),
    mean_price = mean(final_price),
    prob_profit = mean(final_price > 100),
    prob_loss_20 = mean(final_price < 80),
    sd_returns = sd((final_price - 100) / 100)
  )
```

#### Example 2: Comparing Distributions

```r
# Normal vs Cauchy walks
normal_stats <- random_normal_walk(.num_walks = 100, .n = 100) |>
  summarize_walks(.value = y) |>
  mutate(distribution = "Normal")

cauchy_stats <- random_cauchy_walk(.num_walks = 100, .n = 100) |>
  summarize_walks(.value = y) |>
  mutate(distribution = "Cauchy")

# Compare
bind_rows(normal_stats, cauchy_stats) |>
  select(distribution, mean_val, sd, skewness, kurtosis)
```

## Cumulative Functions

RandomWalker automatically computes several cumulative functions for each walk.

### Available Cumulative Functions

**For 1D Walks:**
- `cum_sum` - Cumulative sum: ∑ y
- `cum_prod` - Cumulative product: ∏ (1 + y)
- `cum_min` - Cumulative minimum: min(y₁, y₂, ..., yₙ)
- `cum_max` - Cumulative maximum: max(y₁, y₂, ..., yₙ)
- `cum_mean` - Cumulative mean: (∑ y) / n

**For Multi-Dimensional Walks:**
Cumulative functions are computed for each dimension (x, y, z).

### Using Cumulative Functions

```r
# Generate walk
walks <- random_normal_walk(.num_walks = 10, .n = 100, .initial_value = 100)

# Cumulative functions are already in the data
walks |>
  select(walk_number, step_number, y, starts_with("cum_")) |>
  head(10)

# Analyze cumulative sum
walks |>
  summarize_walks(.value = cum_sum_y, .group_var = walk_number)

# Track maximum ever reached
walks |>
  group_by(walk_number) |>
  summarize(
    max_ever = max(cum_max_y),
    min_ever = min(cum_min_y),
    final_value = last(cum_sum_y)
  )
```

### Custom Cumulative Functions

Add your own cumulative calculations:

```r
library(dplyr)

walks <- random_normal_walk(.num_walks = 10, .n = 100, .initial_value = 100)

# Add custom cumulative functions
walks_extended <- walks |>
  group_by(walk_number) |>
  mutate(
    # Cumulative variance
    cum_var = cumsum((y - cumsum(y) / row_number())^2) / row_number(),
    # Cumulative absolute sum
    cum_abs_sum = cumsum(abs(y)),
    # Running maximum drawdown
    running_peak = cummax(cum_sum_y),
    drawdown = (cum_sum_y - running_peak) / running_peak,
    max_drawdown = cummin(drawdown)
  ) |>
  ungroup()

# Visualize drawdown
walks_extended |>
  ggplot(aes(x = step_number, y = max_drawdown, color = walk_number)) +
  geom_line(alpha = 0.7) +
  theme_minimal() +
  labs(title = "Maximum Drawdown Over Time")
```

## Confidence Intervals

### Using `confidence_interval()`

Calculate confidence intervals for a vector:

```r
library(RandomWalker)

# Generate data
x <- rnorm(1000, mean = 10, sd = 2)

# Calculate 95% CI (default)
confidence_interval(x)
#> # A tibble: 1 × 4
#>    mean ci_lower ci_upper    sd
#>   <dbl>    <dbl>    <dbl> <dbl>
#> 1  10.0     9.88     10.1  2.01

# Calculate 99% CI
confidence_interval(x, .interval = 0.01)

# Calculate 90% CI
confidence_interval(x, .interval = 0.10)
```

### Confidence Intervals for Random Walks

```r
library(dplyr)

# Generate walks
walks <- random_normal_walk(.num_walks = 100, .n = 100)

# Calculate CI at each step
ci_by_step <- walks |>
  group_by(step_number) |>
  summarize(
    ci = list(confidence_interval(y))
  ) |>
  tidyr::unnest(ci)

# Visualize
library(ggplot2)

ggplot(ci_by_step, aes(x = step_number)) +
  geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.3, fill = "steelblue") +
  geom_line(aes(y = rowMeans(ci_by_step[,2:3], TRUE)), color = "darkblue", linewidth = 1) +
  theme_minimal() +
  labs(
    title = "Mean Random Walk with 95% Confidence Interval",
    x = "Step",
    y = "Value"
  )
```

### Confidence Intervals for Final Values

```r
# Get final values from many walks
walks <- random_normal_walk(.num_walks = 1000, .n = 100, .initial_value = 100)

final_values <- walks |>
  group_by(walk_number) |>
  slice_max(step_number, n = 1) |>
  pull(cum_sum_y)

# Calculate confidence interval
confidence_interval(final_values)
```

## Running Quantiles

### Using `running_quantile()`

Calculate quantiles at each position:

```r
# Generate walks
walks <- random_normal_walk(.num_walks = 100, .n = 100)

# Calculate running median (50th percentile)
walks_with_median <- walks |>
  group_by(step_number) |>
  mutate(median_at_step = running_quantile(y, .probs = 0.5, .window = 5)) |>
  ungroup()

# Calculate running quartiles
walks_with_quartiles <- walks |>
  group_by(step_number) |>
  mutate(
    q25 = running_quantile(y, .probs = 0.25, .window = 5),
    q50 = running_quantile(y, .probs = 0.50, .window = 5),
    q75 = running_quantile(y, .probs = 0.75, .window = 5)
  ) |>
  ungroup()
```

### Visualizing Quantile Evolution

```r
library(ggplot2)
library(dplyr)

# Generate many walks
walks <- random_normal_walk(.num_walks = 200, .n = 100)

# Calculate quantiles at each step
quantile_evolution <- walks |>
  group_by(step_number) |>
  summarize(
    q05 = quantile(y, 0.05),
    q25 = quantile(y, 0.25),
    q50 = quantile(y, 0.50),
    q75 = quantile(y, 0.75),
    q95 = quantile(y, 0.95)
  )

# Plot
ggplot(quantile_evolution, aes(x = step_number)) +
  geom_ribbon(aes(ymin = q05, ymax = q95), alpha = 0.2, fill = "blue") +
  geom_ribbon(aes(ymin = q25, ymax = q75), alpha = 0.3, fill = "blue") +
  geom_line(aes(y = q50), color = "darkblue", linewidth = 1) +
  theme_minimal() +
  labs(
    title = "Random Walk Quantile Evolution",
    subtitle = "Median (dark blue), IQR (darker shading), and 90% CI (lighter shading)",
    x = "Step",
    y = "Value"
  )
```

## Distance Calculations

### Using `euclidean_distance()`

For multi-dimensional walks, calculate distance from origin:

```r
# 2D walk
walks_2d <- random_normal_walk(.num_walks = 10, .n = 100, .dimensions = 2)

# Calculate Euclidean distance
walks_with_distance <- walks_2d |>
  euclidean_distance(.x = x, .y = y)

# Visualize distance over time
walks_with_distance |>
  ggplot(aes(x = step_number, y = distance, color = walk_number)) +
  geom_line(alpha = 0.7) +
  theme_minimal() +
  labs(
    title = "Distance from Origin in 2D Random Walk",
    x = "Step",
    y = "Euclidean Distance"
  )
```

### Distance Statistics

```r
# 3D walk
walks_3d <- random_normal_walk(.num_walks = 100, .n = 1000, .dimensions = 3)

# Calculate distance
walks_with_dist <- walks_3d |> euclidean_distance(.x = x, .y = z)

# Analyze distance evolution
distance_stats <- walks_with_dist |>
  group_by(step_number) |>
  summarize(
    mean_dist = mean(distance),
    sd_dist = sd(distance),
    max_dist = max(distance)
  )

# Plot average distance vs sqrt(n) theoretical prediction
distance_stats |>
  ggplot(aes(x = step_number)) +
  geom_line(aes(y = mean_dist, color = "Observed"), linewidth = 1) +
  geom_line(aes(y = sqrt(step_number), color = "Theory"), linewidth = 1, linetype = "dashed") +
  scale_color_manual(values = c("Observed" = "blue", "Theory" = "red")) +
  theme_minimal() +
  labs(
    title = "Mean Distance vs Theoretical Prediction",
    subtitle = "Distance ~ sqrt(n) for standard Brownian motion",
    x = "Step",
    y = "Distance",
    color = ""
  )
```

### First Passage Time

Calculate when walks first reach a threshold:

```r
library(dplyr)

# Generate walks
walks <- discrete_walk(.num_walks = 100, .n = 1000, .initial_value = 0)

# Find first passage time to level 10
first_passage <- walks |>
  group_by(walk_number) |>
  filter(cum_sum_y >= 10) |>
  slice_min(step_number, n = 1) |>
  select(walk_number, first_passage_time = step_number)

# Analyze distribution of first passage times
first_passage |>
  ggplot(aes(x = first_passage_time)) +
  geom_histogram(bins = 50, fill = "steelblue", alpha = 0.7) +
  theme_minimal() +
  labs(
    title = "Distribution of First Passage Times to Level 10",
    x = "First Passage Time (Steps)",
    y = "Count"
  )
```

## Subsetting Walks

### Using `subset_walks()`

Extract walks with extreme values:

```r
# Generate walks
walks <- random_normal_walk(.num_walks = 100, .n = 100, .initial_value = 100)

# Get walk with maximum final value
max_walk <- walks |> subset_walks(.value = "cum_sum_y", .type = "max")

# Get walk with minimum final value
min_walk <- walks |> subset_walks(.value = "cum_sum_y", .type = "min")

# Visualize extremes
library(patchwork)

p_max <- max_walk |> visualize_walks(.pluck = "cum_sum") +
  labs(title = "Maximum Final Value Walk")

p_min <- min_walk |> visualize_walks(.pluck = "cum_sum") +
  labs(title = "Minimum Final Value Walk")

p_max / p_min
```

### Finding Specific Walks

```r
library(dplyr)

# Find walks that cross a threshold
walks <- random_normal_walk(.num_walks = 100, .n = 100, .initial_value = 100)

# Identify walks that reached 102
crossed_102 <- walks |>
  group_by(walk_number) |>
  filter(any(cum_sum_y >= 102)) |>
  pull(walk_number) |>
  unique()

# Extract and visualize those walks
walks |>
  filter(walk_number %in% crossed_102) |>
  visualize_walks(.pluck = "cum_sum", .alpha = 0.3)
```

## Advanced Analysis

### Autocorrelation Analysis

```r
# Generate walk with drift
walks <- random_normal_drift_walk(.num_walks = 1, .n = 500, .mu = 0.1)

# Calculate autocorrelation
acf_result <- walks |> pull(y) |> acf(plot = FALSE)

# Plot
plot(acf_result, main = "Autocorrelation of Random Walk Steps")
```

### Distribution Testing

```r
library(dplyr)

# Generate walks
walks <- random_normal_walk(.num_walks = 100, .n = 100)

# Test if steps are normally distributed
steps <- walks |> pull(y)

# Shapiro-Wilk test for normality
shapiro.test(sample(steps, 5000))  # Sample for computational efficiency

# Q-Q plot
qqnorm(steps)
qqline(steps)
```

### Variance Ratio Test

Test for random walk hypothesis:

```r
library(dplyr)

# Generate walk
walk <- random_normal_walk(.num_walks = 1, .n = 1000)

# Calculate variance ratio
values <- walk |> pull(cum_sum)

# Variance of k-differences
k <- 10
var_k <- var(diff(values, lag = k))
var_1 <- var(diff(values, lag = 1))

# Variance ratio (should be ≈ k for random walk)
vr <- var_k / (k * var_1)
print(paste("Variance Ratio:", round(vr, 3), "| Expected:", k))
```

### Return Analysis (Financial)

```r
library(dplyr)

# Generate stock price simulation
prices <- geometric_brownian_motion(
  .num_walks = 1,
  .n = 252,
  .mu = 0.08,
  .sigma = 0.25,
  .initial_value = 100
)

# Calculate returns
returns <- prices |>
  mutate(
    log_return = log(cum_prod / lag(cum_prod)),
    simple_return = (cum_prod - lag(cum_prod)) / lag(cum_prod)
  ) |>
  filter(!is.na(log_return))

# Analyze returns
returns |>
  summarize(
    mean_return = mean(log_return) * 252,  # Annualized
    volatility = sd(log_return) * sqrt(252),  # Annualized
    sharpe_ratio = mean_return / volatility,
    skewness = moments::skewness(log_return),
    kurtosis = moments::kurtosis(log_return)
  )
```

## Statistical Tests

### Comparing Distributions

```r
library(dplyr)

# Generate two types of walks
normal_walks <- random_normal_walk(.num_walks = 50, .n = 100)
cauchy_walks <- random_cauchy_walk(.num_walks = 50, .n = 100)

# Get final values
normal_final <- normal_walks |>
  group_by(walk_number) |>
  slice_max(step_number) |>
  pull(cum_sum)

cauchy_final <- cauchy_walks |>
  group_by(walk_number) |>
  slice_max(step_number) |>
  pull(cum_sum)

# Wilcoxon rank-sum test (non-parametric)
wilcox.test(normal_final, cauchy_final)

# Kolmogorov-Smirnov test
ks.test(normal_final, cauchy_final)
```

### Testing for Drift

```r
# Generate walk with known drift
walks <- random_normal_drift_walk(.num_walks = 100, .n = 100, .mu = 0.1)

# Test if mean step is significantly different from 0
steps <- walks |> pull(y)
t.test(steps, mu = 0)
```

## Next Steps

- **[Visualization Guide](Visualization-Guide.md)** - Visualize your analysis
- **[Use Cases and Examples](Use-Cases-and-Examples.md)** - Real-world applications
- **[Multi-Dimensional Walks](Multi-Dimensional-Walks.md)** - Analyze spatial walks
- **[API Reference](API-Reference.md)** - Complete function documentation

---

**Need more examples?** Check out the **[Use Cases and Examples](Use-Cases-and-Examples.md)** page!
