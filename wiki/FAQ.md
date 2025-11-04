# Frequently Asked Questions (FAQ)

Quick answers to common questions about RandomWalker.

## General Questions

### What is RandomWalker?

RandomWalker is an R package for generating, visualizing, and analyzing random walks. It supports 27+ probability distributions, multi-dimensional walks (1D, 2D, 3D), and provides tidyverse-compatible functions for data manipulation and analysis.

### Who should use RandomWalker?

RandomWalker is useful for:
- **Researchers**: Modeling stochastic processes, simulating experiments
- **Students**: Learning probability and statistics
- **Data Scientists**: Generating synthetic data, testing algorithms
- **Financial Analysts**: Modeling asset prices, risk analysis
- **Physicists/Biologists**: Simulating particle movement, organism behavior
- **Educators**: Teaching probability concepts

### Is RandomWalker free to use?

Yes! RandomWalker is open-source software licensed under the MIT License. You can use it freely for academic, commercial, or personal projects.

## Installation Questions

### How do I install RandomWalker?

```r
# From CRAN (stable)
install.packages("RandomWalker")

# From GitHub (development)
devtools::install_github("spsanderson/RandomWalker")
```

See the **[Installation Guide](Installation)** for more details.

### What R version do I need?

RandomWalker requires R version 4.1.0 or higher.

### Why am I getting dependency errors?

Try installing dependencies manually:
```r
install.packages(c("dplyr", "tidyr", "purrr", "rlang", "patchwork", "NNS", "ggiraph"))
```

See **[Installation - Troubleshooting](Installation#troubleshooting-installation-issues)** for more solutions.

## Usage Questions

### How do I generate a simple random walk?

```r
library(RandomWalker)
rw30()  # Generates 30 walks with 100 steps each
```

### How do I visualize my random walks?

```r
library(RandomWalker)
rw30() |> visualize_walks()
```

### How do I create a custom random walk?

Use one of the generator functions:
```r
random_normal_walk(
  .num_walks = 10,
  .n = 100,
  .mu = 0,
  .sd = 1,
  .initial_value = 0
)
```

See **[Continuous Distribution Generators](Continuous-Distribution-Generators)** for all options.

### Can I set a seed for reproducibility?

Yes:
```r
set.seed(123)
walks <- rw30()

# Same seed produces same result
set.seed(123)
walks2 <- rw30()
identical(walks, walks2)  # TRUE
```

## Distribution Questions

### Which distribution should I use?

It depends on your use case:

- **General purpose**: `random_normal_walk()`
- **Stock prices**: `geometric_brownian_motion()`
- **Particle diffusion**: `brownian_motion()`
- **Binary outcomes**: `discrete_walk()`
- **Heavy tails**: `random_cauchy_walk()` or `random_t_walk()`
- **Count data**: `random_poisson_walk()`

See **[Comparison Guide](Continuous-Distribution-Generators#comparison-guide)** for more details.

### What's the difference between `random_normal_walk()` and `brownian_motion()`?

Both use normal distributions, but:
- `random_normal_walk()`: Discrete steps, cumulative sum
- `brownian_motion()`: Continuous-time stochastic process, includes drift (μ) and volatility (σ) parameters

For most purposes, they're similar. Use `brownian_motion()` for financial modeling.

### What's the difference between `brownian_motion()` and `geometric_brownian_motion()`?

- **Brownian Motion**: Can go negative, additive process
  ```
  X(t) = X(0) + μt + σW(t)
  ```

- **Geometric Brownian Motion**: Always positive, multiplicative process
  ```
  X(t) = X(0) exp((μ - σ²/2)t + σW(t))
  ```

Use Geometric Brownian Motion for modeling stock prices (can't go negative).

### Can I use custom distributions?

Yes! Use `custom_walk()`:
```r
# Custom displacement function
my_displacement <- function() {
  # Your custom logic here
  return(some_value)
}

custom_walk(
  .num_walks = 10,
  .n = 100,
  .displacement_fn = my_displacement
)
```

See **[Custom Walks](Custom-Walks)** for more details.

## Multi-Dimensional Questions

### How do I create a 2D random walk?

Add `.dimensions = 2`:
```r
random_normal_walk(.num_walks = 10, .n = 100, .dimensions = 2)
```

### How do I visualize 2D walks?

```r
library(ggplot2)

walk_2d <- random_normal_walk(.num_walks = 10, .n = 100, .dimensions = 2)

ggplot(walk_2d, aes(x = cum_sum_x, y = cum_sum_y, color = walk_number)) +
  geom_path() +
  coord_equal() +
  theme_minimal()
```

See **[Multi-Dimensional Walks](Multi-Dimensional-Walks)** for comprehensive examples.

### What's the difference between x, y in 1D vs 2D walks?

- **1D**: `y` is the random value, `x` is renamed to `step_number`
- **2D**: `x` and `y` are the two spatial dimensions
- **3D**: `x`, `y`, and `z` are the three spatial dimensions

### Can I calculate distance from origin?

Yes, use `euclidean_distance()`:
```r
walk_2d <- random_normal_walk(.dimensions = 2)
walk_2d |> euclidean_distance()
```

## Visualization Questions

### How do I make interactive plots?

Add `.interactive = TRUE`:
```r
rw30() |> visualize_walks(.interactive = TRUE)
```

### How do I show only specific panels?

Use `.pluck`:
```r
# Single panel
rw30() |> visualize_walks(.pluck = "cum_sum")

# Multiple panels
rw30() |> visualize_walks(.pluck = c("y", "cum_sum", "cum_mean"))
```

### How do I adjust transparency?

Use `.alpha`:
```r
rw30() |> visualize_walks(.alpha = 0.3)  # More transparent
rw30() |> visualize_walks(.alpha = 0.9)  # More opaque
```

### How do I export plots?

```r
library(ggplot2)

p <- rw30() |> visualize_walks()
ggsave("my_plot.png", p, width = 12, height = 8, dpi = 300)
```

### Can I customize colors?

Yes, using ggplot2:
```r
p <- random_normal_walk(.num_walks = 5) |>
  visualize_walks(.pluck = "y")

p + scale_color_viridis_d()
p + scale_color_brewer(palette = "Set1")
```

## Statistical Analysis Questions

### How do I get summary statistics?

```r
walks <- rw30()

# Overall summary
walks |> summarize_walks(.value = y)

# By walk
walks |> summarize_walks(.value = y, .group_var = walk_number)
```

### What statistics are included?

- Mean, median, range
- Variance, standard deviation
- Quantiles (2.5% and 97.5% by default)
- Min, max
- Harmonic mean, geometric mean
- Skewness, kurtosis

### How do I calculate confidence intervals?

```r
# For a vector
x <- rnorm(1000)
confidence_interval(x)

# For walks at each step
library(dplyr)

walks <- random_normal_walk(.num_walks = 100, .n = 100)

walks |>
  group_by(step_number) |>
  summarize(ci = list(confidence_interval(y))) |>
  tidyr::unnest(ci)
```

### How do I subset walks by extremes?

```r
walks <- rw30()

# Get walk with maximum final value
max_walk <- walks |> subset_walks(.value = "cum_sum", .subset_type = "max")

# Get walk with minimum final value
min_walk <- walks |> subset_walks(.value = "cum_sum", .subset_type = "min")
```

## Performance Questions

### How many walks can I generate?

This depends on your system, but RandomWalker can handle:
- **Light**: 1,000 walks × 1,000 steps each
- **Moderate**: 10,000 walks × 10,000 steps each
- **Heavy**: 100,000+ walks with careful memory management

### My visualization is slow. How do I speed it up?

1. **Reduce transparency**: `.alpha = 0.2`
2. **Sample walks**: Show fewer walks
3. **Downsample steps**: Keep every nth step
4. **Use static plots**: Disable `.interactive`

```r
# Sample walks
walks_large |>
  filter(walk_number %in% sample(levels(walk_number), 50)) |>
  visualize_walks(.alpha = 0.2)

# Downsample steps
walks_large |>
  filter(step_number %% 10 == 0) |>
  visualize_walks()
```

### Can I parallelize generation?

The functions are vectorized, but you can use parallel processing:
```r
library(future)
library(furrr)

plan(multisession, workers = 4)

walks_list <- future_map(1:10, ~random_normal_walk(.num_walks = 100))
```

## Data Structure Questions

### What format does RandomWalker return?

A tibble (tidyverse-compatible data frame) with columns:
- `walk_number` (factor)
- `step_number` (integer)
- Value columns (`y` for 1D, `x`/`y` for 2D, `x`/`y`/`z` for 3D)
- Cumulative function columns

### How do I access attributes?

```r
walks <- rw30()
atb <- attributes(walks)
atb[!names(atb) %in% c("row.names")]
```

Common attributes: `fns`, `num_walks`, `n`, `initial_value`, distribution parameters.

### Can I convert to other formats?

Yes:
```r
# To base R data.frame
as.data.frame(walks)

# To matrix (values only)
walks |> select(y) |> as.matrix()

# To time series
ts(walks$y, frequency = 1)

# To wide format
walks |> tidyr::pivot_wider(names_from = walk_number, values_from = y)
```

## Error Messages

### "The value to summarize must be provided"

You forgot to specify `.value` in `summarize_walks()`:
```r
# Wrong
walks |> summarize_walks()

# Correct
walks |> summarize_walks(.value = y)
```

### "object 'y' not found"

You might be using a 2D/3D walk where `y` refers to a dimension. Use `cum_sum_y` or specify dimensions:
```r
walk_2d <- random_normal_walk(.dimensions = 2)

# Wrong
walk_2d |> summarize_walks(.value = y)

# Correct
walk_2d |> summarize_walks(.value = cum_sum_y)
```

### "Package X is not available"

Install the missing package:
```r
install.packages("package_name")
```

## Integration Questions

### Does RandomWalker work with dplyr?

Yes! RandomWalker is designed for tidyverse:
```r
library(dplyr)

random_normal_walk(.num_walks = 10) |>
  filter(step_number > 50) |>
  mutate(positive = cum_sum > 0) |>
  group_by(walk_number) |>
  summarize(prop_positive = mean(positive))
```

### Can I use it in Shiny apps?

Yes:
```r
library(shiny)
library(RandomWalker)

ui <- fluidPage(
  numericInput("num_walks", "Number of Walks:", 10),
  plotOutput("walks_plot")
)

server <- function(input, output) {
  output$walks_plot <- renderPlot({
    random_normal_walk(.num_walks = input$num_walks) |>
      visualize_walks(.pluck = "cum_sum")
  })
}

shinyApp(ui, server)
```

### Can I use it with ggplot2?

Yes, `visualize_walks()` returns ggplot2 objects:
```r
library(ggplot2)

p <- rw30() |> visualize_walks(.pluck = "y")

# Customize further
p +
  labs(title = "My Custom Title") +
  theme_bw()
```

## Application Questions

### How do I model stock prices?

Use Geometric Brownian Motion:
```r
stock_prices <- geometric_brownian_motion(
  .num_walks = 1000,
  .n = 252,  # Trading days
  .mu = 0.08,  # 8% expected return
  .sigma = 0.25,  # 25% volatility
  .initial_value = 100
)
```

See **[Use Cases - Financial Modeling](Use-Cases-and-Examples#financial-modeling)**.

### How do I simulate particle diffusion?

Use Brownian Motion in 2D or 3D:
```r
particles <- brownian_motion(
  .num_walks = 50,
  .n = 1000,
  .dimensions = 3
)
```

See **[Use Cases - Physics](Use-Cases-and-Examples#physics-simulation)**.

### How do I test an algorithm?

Generate synthetic data:
```r
# Generate test walks
test_data <- discrete_walk(
  .num_walks = 1000,
  .n = 100,
  .upper_probability = 0.5
)

# Run your algorithm
result <- my_algorithm(test_data)
```

## Getting Help

### Where can I find more examples?

- **[Quick Start Guide](Quick-Start-Guide)** - Basic examples
- **[Use Cases and Examples](Use-Cases-and-Examples)** - Real-world applications
- **[Vignette](https://www.spsanderson.com/RandomWalker/articles/getting-started.html)** - Comprehensive tutorial

### Where do I report bugs?

[GitHub Issues](https://github.com/spsanderson/RandomWalker/issues)

### Where can I ask questions?

- [GitHub Discussions](https://github.com/spsanderson/RandomWalker/discussions)
- Stack Overflow (use `randomwalker` tag)
- Email: spsanderson@gmail.com

### How do I cite RandomWalker?

```r
citation("RandomWalker")
```

### Is there a community?

Yes! Join us on:
- [GitHub Discussions](https://github.com/spsanderson/RandomWalker/discussions)
- Follow [@spsanderson](https://twitter.com/spsanderson) on Twitter

## Contributing

### Can I contribute?

Yes! We welcome contributions:
- Bug reports
- Feature requests
- Code contributions
- Documentation improvements
- Examples and tutorials

See **[Contributing Guide](Contributing-Guide)** for details.

### How do I suggest a new feature?

Open an issue on [GitHub Issues](https://github.com/spsanderson/RandomWalker/issues) with:
- Clear description of the feature
- Use cases
- Example code (if applicable)

## Related Questions

### What's the difference between RandomWalker and other R packages?

RandomWalker is unique in:
- Tidyverse compatibility
- 27+ distributions in one package
- Multi-dimensional support (1D/2D/3D)
- Rich visualization capabilities
- Comprehensive statistical analysis tools
- Consistent API across all functions

### Can RandomWalker handle big data?

Yes, but:
- Use efficient data structures (tibbles)
- Sample or downsample for visualization
- Consider parallel processing for generation
- Use appropriate hardware

### Is RandomWalker actively maintained?

Yes! The package is actively developed with:
- Regular updates
- Bug fixes
- New features
- Community support

Check [NEWS.md](https://github.com/spsanderson/RandomWalker/blob/master/NEWS.md) for latest updates.

---

**Didn't find your answer?** Check the **[Troubleshooting Guide](Troubleshooting)** or ask on [GitHub Discussions](https://github.com/spsanderson/RandomWalker/discussions)!
