# Basic Concepts

Understanding the fundamentals of random walks and how RandomWalker implements them.

## Table of Contents

- [What is a Random Walk?](#what-is-a-random-walk)
- [Types of Random Walks](#types-of-random-walks)
- [Key Properties](#key-properties)
- [Mathematical Background](#mathematical-background)
- [RandomWalker Implementation](#randomwalker-implementation)
- [Common Terminology](#common-terminology)

## What is a Random Walk?

A **random walk** is a mathematical model describing a path consisting of a succession of random steps. At each point in time, the next step is determined by chance.

### Simple Example

Imagine flipping a coin:
- **Heads**: Move one step forward (+1)
- **Tails**: Move one step backward (-1)
- **Start**: Position 0

After 10 flips, you might be at position +2, -4, or anywhere else. This is a random walk!

```r
library(RandomWalker)

# Coin flip random walk
coin_walk <- discrete_walk(
  .num_walks = 1,
  .n = 100,
  .upper_bound = 1,
  .lower_bound = -1,
  .upper_probability = 0.5
)

coin_walk |> visualize_walks(.pluck = "cum_sum")
```

### Real-World Analogies

- **Stock prices**: Daily price changes are like random steps
- **Particle motion**: Molecules moving due to thermal energy
- **Drunk person walking**: Each step in a random direction
- **Photon path**: Light scattering through a medium

## Types of Random Walks

### 1. Simple Random Walk

Each step is ±1 with equal probability:

```r
discrete_walk(
  .num_walks = 10,
  .upper_bound = 1,
  .lower_bound = -1,
  .upper_probability = 0.5
)
```

**Properties:**
- Symmetric (unbiased)
- Steps are independent
- Mean position = 0
- Variance grows linearly with time

### 2. Random Walk with Drift

Steps have a non-zero mean (bias in one direction):

```r
random_normal_drift_walk(
  .num_walks = 10,
  .mu = 0.1  # Positive drift
)
```

**Properties:**
- Asymmetric (biased)
- Tends to move in one direction
- Mean position ≠ 0
- Can model trending data

### 3. Brownian Motion (Wiener Process)

Continuous-time random walk:

```r
brownian_motion(
  .num_walks = 10,
  .mu = 0,      # Drift
  .sigma = 1    # Volatility
)
```

**Properties:**
- Continuous in time
- Normally distributed increments
- Foundation of stochastic calculus
- Used in physics and finance

### 4. Geometric Brownian Motion

Multiplicative random walk (always positive):

```r
geometric_brownian_motion(
  .num_walks = 10,
  .initial_value = 100
)
```

**Properties:**
- Cannot go negative
- Used for stock prices
- Log-normal distribution
- Percentage changes are normal

## Key Properties

### Property 1: Mean Displacement

For a symmetric random walk starting at 0:

**Expected value after n steps = 0**

```r
# Verify empirically
walks <- random_normal_walk(.num_walks = 1000, .n = 100)

walks |>
  group_by(step_number) |>
  summarize(mean_position = mean(cum_sum_y)) |>
  pull(mean_position) |>
  abs() |>
  max()  # Should be close to 0
```

### Property 2: Variance Growth

For standard random walk:

**Variance after n steps = n**

```r
# Verify empirically
walks <- random_normal_walk(.num_walks = 1000, .n = 100)

walks |>
  group_by(step_number) |>
  reframe(
    variance = var(cum_sum),
    theoretical = step_number
  ) |>
  tail(10)
```

### Property 3: Distance from Origin

Expected distance grows as √n:

**E[|position|] ∝ √n**

```r
# Verify with 2D walk
walks_2d <- random_normal_walk(.num_walks = 100, .n = 500, .dimensions = 2)

walks_2d |>
  euclidean_distance(.x = x, .y = y) |>
  group_by(step_number) |>
  reframe(
    mean_distance = mean(distance),
    theoretical = sqrt(step_number)
  ) |>
  filter(step_number %% 50 == 0)
```

### Property 4: First Return to Origin

For 1D symmetric walk:
- **Probability of eventual return = 1** (certain to return)
- **Expected return time = ∞** (infinite expected time!)

For 2D symmetric walk:
- **Probability of eventual return = 1**

For 3D symmetric walk:
- **Probability of eventual return ≈ 0.34** (not certain!)

### Property 5: Scaling

Random walks exhibit **scaling invariance**:
- If you zoom out by factor k
- Time scales by k²
- Position scales by k

## Mathematical Background

### One-Dimensional Random Walk

**Position after n steps:**
```
X(n) = X(0) + Σ(i=1 to n) Δᵢ
```

Where Δᵢ are independent random steps.

**For standard normal walk:**
- Δᵢ ~ N(0, 1)
- X(n) ~ N(0, n)
- E[X(n)] = 0
- Var[X(n)] = n

### Brownian Motion

**Continuous-time stochastic process:**
```
dX(t) = μ dt + σ dW(t)
```

Where:
- μ = drift coefficient
- σ = volatility coefficient
- W(t) = standard Wiener process

**Properties:**
- W(0) = 0
- W(t) ~ N(0, t)
- W(t) - W(s) ~ N(0, t-s) for t > s
- Independent increments

### Geometric Brownian Motion

**For stock prices:**
```
dS(t) = μ S(t) dt + σ S(t) dW(t)
```

**Solution:**
```
S(t) = S(0) exp((μ - σ²/2)t + σW(t))
```

**Properties:**
- Always positive
- Log-normal distribution
- Used in Black-Scholes model

## RandomWalker Implementation

### How RandomWalker Works

1. **Generate random steps** from specified distribution
2. **Compute cumulative sum** (position over time)
3. **Add cumulative statistics** (min, max, mean, product)
4. **Return tidy tibble** for analysis

### Example: Behind the Scenes

```r
# What rw30() does internally:

# 1. Generate random steps
steps <- rnorm(100, mean = 0, sd = 1)

# 2. Compute cumulative sum
positions <- cumsum(c(0, steps[-100]))

# 3. Add to tibble
walk_data <- tibble(
  step_number = 1:100,
  y = steps,
  cum_sum = positions
)

# 4. Add more cumulative functions
walk_data <- walk_data |>
  mutate(
    cum_prod = cumprod(1 + y),
    cum_min = cummin(y),
    cum_max = cummax(y),
    cum_mean = cumsum(y) / step_number
  )
```

### Dimensions

**1D Walk:**
- Single value per step: `y`
- Position: `cum_sum`

**2D Walk:**
- Two values per step: `x`, `y`
- Position: `(cum_sum_x, cum_sum_y)`
- Distance: `sqrt(cum_sum_x² + cum_sum_y²)`

**3D Walk:**
- Three values per step: `x`, `y`, `z`
- Position: `(cum_sum_x, cum_sum_y, cum_sum_z)`
- Distance: `sqrt(cum_sum_x² + cum_sum_y² + cum_sum_z²)`

## Common Terminology

### Terms Used in RandomWalker

| Term | Definition | Example |
|------|------------|---------|
| **Walk** | A single realization of the random process | One stock price path |
| **Step** | One random increment | Daily price change |
| **Trajectory** | Path taken by the walk | Price history |
| **Cumulative sum** | Running total of steps | Stock price level |
| **Displacement** | Distance from starting point | Profit/loss |
| **Excursion** | Distance from reference point | Drawdown |
| **First passage time** | Time to first reach a level | Time to profit |
| **Return time** | Time to return to starting point | Recovery time |

### Statistical Terms

| Term | Definition |
|------|------------|
| **Mean** | Average value |
| **Variance** | Spread of values |
| **Standard deviation** | √Variance |
| **Skewness** | Asymmetry measure |
| **Kurtosis** | Tail heaviness |
| **Quantile** | Percentile value |
| **Confidence interval** | Range containing true value with probability |

### Probability Distributions

| Distribution | Use Case | Parameters |
|--------------|----------|------------|
| **Normal** | General purpose | μ (mean), σ (sd) |
| **Uniform** | Equal probabilities | min, max |
| **Exponential** | Waiting times | λ (rate) |
| **Poisson** | Event counts | λ (rate) |
| **Cauchy** | Heavy tails | location, scale |
| **Binomial** | Success counts | n (trials), p (prob) |

## Worked Examples

### Example 1: Verify Properties

```r
library(RandomWalker)
library(dplyr)

# Generate many walks
walks <- random_normal_walk(.num_walks = 1000, .n = 100)

# Property 1: Mean = 0
walks |>
  summarize(overall_mean = mean(cum_sum_y))

# Property 2: Variance = n
walks |>
  filter(step_number == 80) |>
  summarize(
    variance = var(cum_sum_y),
    theoretical = 80
  )

# Property 3: Distance ∝ √n
walks |>
  group_by(step_number) |>
  summarize(
    mean_abs_position = mean(abs(cum_sum_y)),
    theoretical = sqrt(2/pi) * sqrt(step_number)  # Exact for normal
  )
```

### Example 2: Distribution of Final Position

```r
library(ggplot2)

# Generate walks
walks <- random_normal_walk(.num_walks = 10000, .n = 100)

# Get final positions
final_pos <- walks |>
  group_by(walk_number) |>
  slice_max(step_number) |>
  pull(cum_sum_y)

# Plot
tibble(position = final_pos) |>
  ggplot(aes(x = position)) +
  geom_histogram(aes(y = after_stat(density)), bins = 50,
                 fill = "steelblue", alpha = 0.7) +
  stat_function(fun = dnorm, args = list(mean = 0, sd = 10),
                color = "red", linewidth = 1) +
  theme_minimal() +
  labs(
    title = "Distribution of Final Positions (n=100)",
    subtitle = "Theoretical N(0, 100) in red",
    x = "Final Position",
    y = "Density"
  )
```

### Example 3: Path Dependency

Random walks are **path-dependent** - the ending doesn't tell you the route:

```r
# Generate walks ending at similar positions
set.seed(123)
walks <- random_normal_walk(.num_walks = 100, .n = 100)

# Find walks ending near 10
similar_end <- walks |>
  group_by(walk_number) |>
  filter(step_number == 80, abs(cum_sum_y - 10) < 1)

# Plot their paths - very different!
walks |>
  filter(walk_number %in% similar_end$walk_number) |>
  visualize_walks(.pluck = "cum_sum", .alpha = 0.5)
```

## Next Steps

Now that you understand the basics:

- **[Quick Start Guide](Quick-Start-Guide.md)** - Start using RandomWalker
- **[Continuous Distribution Generators](Continuous-Distribution-Generators.md)** - Explore distributions
- **[Statistical Analysis Guide](Statistical-Analysis-Guide.md)** - Analyze properties
- **[Use Cases and Examples](Use-Cases-and-Examples.md)** - Real-world applications

## Further Reading

### Academic Resources

- **Books:**
  - "Random Walks and Electric Networks" by Doyle & Snell
  - "A Guide to Brownian Motion" by Mörters & Peres
  - "Stochastic Processes" by Ross

- **Papers:**
  - Einstein's 1905 paper on Brownian motion
  - Pearson's 1905 paper introducing the term "random walk"

### Online Resources

- [Wikipedia: Random Walk](https://en.wikipedia.org/wiki/Random_walk)
- [Wikipedia: Brownian Motion](https://en.wikipedia.org/wiki/Brownian_motion)
- [MIT OpenCourseWare: Stochastic Processes](https://ocw.mit.edu/)

---

**Ready to generate walks?** Head to the **[Quick Start Guide](Quick-Start-Guide.md)**!
