# Use Cases and Examples

Real-world applications and comprehensive examples for RandomWalker.

## Table of Contents

- [Financial Modeling](#financial-modeling)
- [Physics Simulation](#physics-simulation)
- [Biology and Ecology](#biology-and-ecology)
- [Algorithm Testing](#algorithm-testing)
- [Education and Teaching](#education-and-teaching)
- [Quality Control](#quality-control)
- [Computer Science](#computer-science)

## Financial Modeling

### Stock Price Simulation

Model stock prices using Geometric Brownian Motion:

```r
library(RandomWalker)
library(dplyr)
library(ggplot2)

# Simulate one year of daily stock prices
stock_sim <- geometric_brownian_motion(
  .num_walks = 1000,      # Monte Carlo scenarios
  .n = 252,               # Trading days in a year
  .mu = 0.08,             # 8% expected annual return
  .sigma = 0.25,          # 25% annual volatility
  .initial_value = 100    # Starting price $100
)

# Visualize scenarios
stock_sim |>
  visualize_walks(.alpha = 0.05, .pluck = "cum_prod")

# Analyze outcomes
outcomes <- stock_sim |>
  group_by(walk_number) |>
  slice_max(step_number, n = 1) |>
  mutate(
    final_price = cum_prod_y,
    return_pct = (final_price - 100) / 100 * 100
  )

# Summary statistics
outcomes |>
  summarize(
    prob_profit = mean(final_price > 100),
    prob_double = mean(final_price > 200),
    prob_loss_50 = mean(final_price < 50),
    median_price = median(final_price),
    mean_return = mean(return_pct),
    sd_return = sd(return_pct)
  )
```

### Portfolio Risk Analysis

Analyze Value at Risk (VaR):

```r
# Generate many scenarios
portfolio_sim <- geometric_brownian_motion(
  .num_walks = 10000,
  .n = 252,
  .mu = 0.10,
  .sigma = 0.30,
  .initial_value = 1000000  # $1M portfolio
)

# Calculate VaR
final_values <- portfolio_sim |>
  group_by(walk_number) |>
  slice_max(step_number) |>
  pull(cum_prod_y)

# 95% VaR (5% worst case)
var_95 <- quantile(final_values, 0.05)
loss_95 <- 1000000 - var_95

cat(sprintf("95%% VaR: $%.2f\n", loss_95))
cat(sprintf("Expected Shortfall: $%.2f\n",
            1000000 - mean(final_values[final_values < var_95])))

# Visualize distribution
tibble(final_value = final_values) |>
  ggplot(aes(x = final_value)) +
  geom_histogram(bins = 100, fill = "steelblue", alpha = 0.7) +
  geom_vline(xintercept = var_95, color = "red", linewidth = 1, linetype = "dashed") +
  geom_vline(xintercept = 1000000, color = "black", linewidth = 1) +
  theme_minimal() +
  labs(
    title = "Portfolio Value Distribution After 1 Year",
    subtitle = "Red line shows 95% VaR",
    x = "Portfolio Value ($)",
    y = "Count"
  )
```

### Option Pricing Monte Carlo

Price a European call option:

```r
# Parameters
S0 <- 100      # Current stock price
K <- 105       # Strike price
r <- 0.05      # Risk-free rate
sigma <- 0.25  # Volatility
T <- 1         # Time to maturity (years)
n_steps <- 252 # Daily steps

# Simulate stock prices
stock_paths <- geometric_brownian_motion(
  .num_walks = 10000,
  .n = n_steps,
  .mu = r,
  .sigma = sigma,
  .initial_value = S0
)

# Calculate option payoffs
option_value <- stock_paths |>
  group_by(walk_number) |>
  slice_max(step_number) |>
  mutate(
    payoff = pmax(cum_prod_y - K, 0)  # Call option payoff
  ) |>
  summarize(
    option_price = mean(payoff) * exp(-r * T)  # Discount to present
  )

cat(sprintf("European Call Option Price: $%.2f\n", mean(option_value$option_price)))
```

### Trading Strategy Backtesting

Test a simple moving average crossover strategy:

```r
# Generate price series
prices <- geometric_brownian_motion(
  .num_walks = 1,
  .n = 500,
  .mu = 0.08,
  .sigma = 0.25,
  .initial_value = 100
)

# Add moving averages
library(zoo)

prices_with_signals <- prices |>
  mutate(
    price = cum_prod,
    ma_fast = rollmean(price, k = 20, fill = NA, align = "right"),
    ma_slow = rollmean(price, k = 50, fill = NA, align = "right"),
    signal = case_when(
      ma_fast > ma_slow ~ "Buy",
      ma_fast < ma_slow ~ "Sell",
      TRUE ~ "Hold"
    ),
    position = if_else(signal == "Buy", 1, 0)
  )

# Calculate returns
strategy_returns <- prices_with_signals |>
  mutate(
    price_return = (price - lag(price)) / lag(price),
    strategy_return = position * price_return
  ) |>
  filter(!is.na(strategy_return))

# Performance metrics
cat(sprintf("Buy & Hold Return: %.2f%%\n",
            (last(prices$cum_prod) - 100) / 100 * 100))
cat(sprintf("Strategy Return: %.2f%%\n",
            sum(strategy_returns$strategy_return, na.rm = TRUE) * 100))

# Visualize
ggplot(prices_with_signals, aes(x = step_number)) +
  geom_line(aes(y = price), color = "black") +
  geom_line(aes(y = ma_fast), color = "blue") +
  geom_line(aes(y = ma_slow), color = "red") +
  theme_minimal() +
  labs(
    title = "Moving Average Crossover Strategy",
    x = "Day",
    y = "Price",
    color = "MA"
  )
```

## Physics Simulation

### Particle Diffusion (2D)

Simulate Brownian motion of particles:

```r
# Simulate 100 particles diffusing
particles <- brownian_motion(
  .num_walks = 100,
  .n = 1000,
  .sigma = 0.1,
  .dimensions = 2
)

# Calculate distance from origin
particles_with_distance <- particles |>
  euclidean_distance()

# Plot trajectories
ggplot(particles, aes(x = cum_sum_x, y = cum_sum_y, group = walk_number)) +
  geom_path(alpha = 0.2, color = "steelblue") +
  geom_point(data = particles |> filter(step_number == 1),
             color = "green", size = 2) +
  coord_equal() +
  theme_minimal() +
  labs(
    title = "2D Particle Diffusion",
    subtitle = "Green points show starting positions",
    x = "X Position",
    y = "Y Position"
  )

# Analyze diffusion
diffusion_stats <- particles_with_distance |>
  group_by(step_number) |>
  summarize(
    mean_distance = mean(distance),
    theoretical = sqrt(step_number * 0.1^2)  # sqrt(Dt)
  )

ggplot(diffusion_stats, aes(x = step_number)) +
  geom_line(aes(y = mean_distance, color = "Observed"), linewidth = 1) +
  geom_line(aes(y = theoretical, color = "Theoretical"), linewidth = 1, linetype = "dashed") +
  scale_color_manual(values = c("Observed" = "blue", "Theoretical" = "red")) +
  theme_minimal() +
  labs(
    title = "Mean Squared Displacement",
    subtitle = "Verifying Einstein's relation for diffusion",
    x = "Time",
    y = "Mean Distance",
    color = ""
  )
```

### Random Walk in 3D Space

Simulate a particle in 3D:

```r
library(plotly)

# Generate 3D walk
particle_3d <- brownian_motion(
  .num_walks = 5,
  .n = 500,
  .sigma = 0.5,
  .dimensions = 3
)

# Interactive 3D plot
plot_ly(
  data = particle_3d,
  x = ~cum_sum_x,
  y = ~cum_sum_y,
  z = ~cum_sum_z,
  color = ~walk_number,
  type = "scatter3d",
  mode = "lines",
  line = list(width = 2)
) |>
  layout(
    title = "3D Brownian Motion of Particles",
    scene = list(
      xaxis = list(title = "X"),
      yaxis = list(title = "Y"),
      zaxis = list(title = "Z")
    )
  )
```

### Heat Diffusion

Model heat diffusion with random walk:

```r
# Multiple heat sources diffusing
heat_sources <- brownian_motion(
  .num_walks = 50,
  .n = 200,
  .sigma = 1,
  .dimensions = 2
)

# Create heat map
ggplot(heat_sources, aes(x = cum_sum_x, y = cum_sum_y)) +
  geom_bin2d(bins = 50) +
  scale_fill_viridis_c(option = "inferno", name = "Temperature") +
  coord_equal() +
  theme_minimal() +
  labs(
    title = "Heat Diffusion Pattern",
    x = "X Position",
    y = "Y Position"
  )
```

## Biology and Ecology

### Animal Foraging Behavior

Model animal movement with Lévy flights (using Cauchy distribution for heavy tails):

```r
# Animal foraging in 2D
animal <- random_cauchy_walk(
  .num_walks = 1,
  .n = 500,
  .scale = 1,
  .dimensions = 2
)

# Add distance from nest
animal_with_distance <- animal |>
  mutate(distance_from_nest = sqrt(cum_sum_x^2 + cum_sum_y^2))

# Visualize
ggplot(animal, aes(x = cum_sum_x, y = cum_sum_y)) +
  geom_path(color = "darkgreen", alpha = 0.6, linewidth = 0.8) +
  geom_point(aes(color = animal_with_distance$distance_from_nest), size = 2) +
  geom_point(x = 0, y = 0, size = 5, color = "red", shape = 17) +  # Nest
  scale_color_viridis_c(option = "mako", name = "Distance\nfrom Nest") +
  coord_equal() +
  theme_minimal() +
  labs(
    title = "Animal Foraging Path (Lévy Flight)",
    subtitle = "Red triangle marks nest location",
    x = "X Position (meters)",
    y = "Y Position (meters)"
  )

# Analyze foraging efficiency
animal_with_distance |>
  summarize(
    max_distance = max(distance_from_nest),
    mean_distance = mean(distance_from_nest),
    total_path_length = sum(sqrt(diff(cum_sum_x)^2 + diff(cum_sum_y)^2))
  )
```

### Population Dynamics

Model population fluctuations:

```r
# Simulate population over time with environmental stochasticity
population <- random_normal_walk(
  .num_walks = 20,
  .n = 100,
  .mu = 0.01,  # Slight growth
  .sd = 0.05,  # Environmental noise
  .initial_value = 1000  # Starting population
)

# Visualize with extinction threshold
population |>
  visualize_walks(.pluck = "cum_sum") +
  geom_hline(yintercept = 0, color = "red", linetype = "dashed", linewidth = 1) +
  labs(
    title = "Population Dynamics with Environmental Stochasticity",
    subtitle = "Red line shows extinction threshold",
    y = "Population Size"
  )

# Calculate extinction probability
extinctions <- population |>
  group_by(walk_number) |>
  summarize(went_extinct = any(cum_sum < 0))

cat(sprintf("Extinction probability: %.1f%%\n",
            mean(extinctions$went_extinct) * 100))
```

### Epidemic Spread

Model disease spread using Poisson walk (count of new infections):

```r
# Daily new infections
infections <- random_poisson_walk(
  .num_walks = 10,
  .n = 100,  # 100 days
  .lambda = 5  # Average 5 new infections per day
)

# Cumulative infections
infections |>
  visualize_walks(.pluck = "cum_sum") +
  labs(
    title = "Epidemic Spread Over Time",
    subtitle = "Cumulative infections from Poisson process",
    x = "Day",
    y = "Total Infections"
  )
```

## Algorithm Testing

### Anomaly Detection

Generate test data for anomaly detection algorithms:

```r
# Normal behavior
normal_data <- random_normal_walk(
  .num_walks = 100,
  .n = 100,
  .sd = 0.5
)

# Inject anomalies (Cauchy walk has heavy tails)
anomalies <- random_cauchy_walk(
  .num_walks = 10,
  .n = 100,
  .scale = 0.5
)

# Combine
test_data <- bind_rows(
  normal_data |> mutate(type = "Normal"),
  anomalies |> mutate(type = "Anomaly")
)

# Visualize
test_data |>
  filter(step_number > 50) |>  # Show later steps
  ggplot(aes(x = step_number, y = cum_sum, group = walk_number, color = type)) +
  geom_line(alpha = 0.5) +
  scale_color_manual(values = c("Normal" = "blue", "Anomaly" = "red")) +
  theme_minimal() +
  labs(
    title = "Test Data for Anomaly Detection",
    subtitle = "Red walks show anomalous behavior",
    x = "Step",
    y = "Value"
  )
```

### Time Series Forecasting

Create test data for forecasting models:

```r
# Generate walks with drift
test_series <- random_normal_drift_walk(
  .num_walks = 1,
  .n = 200,
  .mu = 0.05,  # Positive drift
  .sd = 1
)

# Split into train/test
train <- test_series |> filter(step_number <= 150)
test <- test_series |> filter(step_number > 150)

# Your forecasting algorithm goes here
# forecast_result <- my_forecast_function(train)

# Visualize
ggplot() +
  geom_line(data = train, aes(x = step_number, y = cum_sum), color = "black") +
  geom_line(data = test, aes(x = step_number, y = cum_sum), color = "red") +
  geom_vline(xintercept = 150, linetype = "dashed", color = "blue") +
  theme_minimal() +
  labs(
    title = "Train/Test Split for Time Series Forecasting",
    subtitle = "Black: training, Red: test set",
    x = "Time",
    y = "Value"
  )
```

## Education and Teaching

### Illustrating Central Limit Theorem

Demonstrate CLT with random walks:

```r
# Generate many walks
walks <- random_uniform_walk(
  .num_walks = 1000,
  .n = 100,
  .min = -1,
  .max = 1
)

# Get final positions
final_positions <- walks |>
  group_by(walk_number) |>
  slice_max(step_number) |>
  pull(cum_sum)

# Plot distribution
ggplot(tibble(value = final_positions), aes(x = value)) +
  geom_histogram(aes(y = after_stat(density)), bins = 50,
                 fill = "steelblue", alpha = 0.7) +
  stat_function(fun = dnorm,
                args = list(mean = mean(final_positions),
                           sd = sd(final_positions)),
                color = "red", linewidth = 1) +
  theme_minimal() +
  labs(
    title = "Central Limit Theorem Demonstration",
    subtitle = "Uniform steps → Normal distribution (red curve)",
    x = "Final Position",
    y = "Density"
  )
```

### Gambler's Ruin Problem

Teach probability with gambling simulation:

```r
# Simulate gambler starting with $50
# Goal: reach $100 or go broke
gamblers <- discrete_walk(
  .num_walks = 1000,
  .n = 10000,  # Allow many steps
  .upper_bound = 1,
  .lower_bound = -1,
  .upper_probability = 0.48,  # House edge
  .initial_value = 50
)

# Find ruin times
ruin_analysis <- gamblers |>
  group_by(walk_number) |>
  mutate(
    bankroll = cum_sum,
    ruined = bankroll <= 0,
    won = bankroll >= 100
  ) |>
  summarize(
    final_state = case_when(
      any(ruined) ~ "Ruined",
      any(won) ~ "Won",
      TRUE ~ "Ongoing"
    ),
    steps_to_outcome = if_else(
      final_state %in% c("Ruined", "Won"),
      min(step_number[ruined | won]),
      NA_real_
    )
  )

# Results
table(ruin_analysis$final_state)

# Visualize sample paths
gamblers |>
  filter(walk_number %in% sample(levels(walk_number), 20)) |>
  ggplot(aes(x = step_number, y = cum_sum, color = walk_number)) +
  geom_line(alpha = 0.6) +
  geom_hline(yintercept = c(0, 100), linetype = "dashed", color = "red") +
  theme_minimal() +
  theme(legend.position = "none") +
  labs(
    title = "Gambler's Ruin: Starting with $50",
    subtitle = "Red lines: bankruptcy ($0) and goal ($100)",
    x = "Number of Bets",
    y = "Bankroll ($)"
  )
```

## Quality Control

### Defect Monitoring

Monitor defect rates using binomial walks:

```r
# Daily defect counts
defects <- random_binomial_walk(
  .num_walks = 10,  # 10 production lines
  .n = 30,  # 30 days
  .size = 100,  # 100 items inspected per day
  .prob = 0.05  # 5% defect rate
)

# Control chart
defects |>
  ggplot(aes(x = step_number, y = y, color = walk_number)) +
  geom_line(alpha = 0.7) +
  geom_point(size = 1) +
  geom_hline(yintercept = 5, color = "blue", linewidth = 1) +  # Expected
  geom_hline(yintercept = c(0, 10), color = "red", linetype = "dashed") +  # Control limits
  theme_minimal() +
  labs(
    title = "Statistical Process Control Chart",
    subtitle = "Daily defect counts (blue: expected, red: control limits)",
    x = "Day",
    y = "Defects Found"
  )
```

## Computer Science

### Random Number Generator Testing

Test uniformity of RNG:

```r
# Generate supposedly uniform random walks
uniform_test <- random_uniform_walk(
  .num_walks = 50,
  .n = 1000,
  .min = 0,
  .max = 1
)

# Check if steps are uniform
steps <- uniform_test |> pull(y)

# Kolmogorov-Smirnov test
ks.test(steps, "punif", 0, 1)

# Visual check
ggplot(tibble(value = steps), aes(x = value)) +
  geom_histogram(bins = 50, fill = "steelblue", alpha = 0.7) +
  geom_hline(yintercept = length(steps) / 50, color = "red", linetype = "dashed") +
  theme_minimal() +
  labs(
    title = "Testing Uniformity of Random Number Generator",
    subtitle = "Red line shows expected count for uniform distribution",
    x = "Value",
    y = "Count"
  )
```

## Next Steps

- **[Quick Start Guide](Quick-Start-Guide.md)** - Learn the basics
- **[Visualization Guide](Visualization-Guide.md)** - Create better plots
- **[Statistical Analysis Guide](Statistical-Analysis-Guide.md)** - Deeper analysis
- **[API Reference](API-Reference.md)** - Function documentation

---

**Have your own use case?** Share it in [GitHub Discussions](https://github.com/spsanderson/RandomWalker/discussions)!
