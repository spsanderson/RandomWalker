# RandomWalker Wiki - Home

![RandomWalker package logo featuring a hexagonal design with abstract
paths representing random walks, symbolizing the package's functionality
for generating and analyzing stochastic
processes.](../reference/figures/logo.png)

Welcome to the **RandomWalker** Wiki! This comprehensive guide will help
you master the RandomWalker R package for generating, visualizing, and
analyzing random walks.

## 📖 What is RandomWalker?

RandomWalker is a comprehensive R package that provides a unified,
tidyverse-compatible interface for generating random walks of various
types. Whether you’re modeling stock prices, simulating particle
movements, or exploring stochastic processes, RandomWalker makes it easy
to:

- Generate random walks from 27+ different probability distributions
- Create walks in 1D, 2D, or 3D space
- Visualize walks with beautiful, interactive plots
- Compute comprehensive statistical summaries
- Work seamlessly with tidyverse tools

## 🚀 Quick Navigation

### Getting Started

- **Installation** - How to install the package
- **Quick Start Guide** - Get up and running in minutes
- **Basic Concepts** - Understanding random walks

### Function Guides

- **Automatic Random Walks** - Using
  [`rw30()`](https://www.spsanderson.com/RandomWalker/reference/rw30.md)
  for instant results
- **Continuous Distributions** - Normal, Brownian, Gamma, Beta, and more
- **Discrete Distributions** - Binomial, Poisson, Geometric, and more
- **Multi-Dimensional Walks** - Working in 2D and 3D space

### Advanced Topics

- **Visualization Guide** - Creating beautiful plots
- **Statistical Analysis Guide** - Computing summary statistics
- **Use Cases and Examples** - Real-world applications

### Reference

- **API Reference** - Complete function documentation
- **FAQ** - Frequently Asked Questions
- **Troubleshooting** - Common issues and solutions

### Contributing

- **Contributing Guide** - How to contribute to the project

## 💡 Key Features

### 🎲 27+ Distribution Types

Generate random walks from a wide variety of probability distributions
including:

- **Continuous**: Normal, Brownian Motion, Geometric Brownian Motion,
  Beta, Cauchy, Chi-Squared, Exponential, F, Gamma, Log-Normal,
  Logistic, Student’s t, Uniform, Weibull
- **Discrete**: Binomial, Discrete, Geometric, Hypergeometric,
  Multinomial, Negative Binomial, Poisson
- **Custom**: Define your own displacement functions

### 📐 Multi-Dimensional Support

- 1D random walks for time series analysis
- 2D random walks for spatial modeling
- 3D random walks for particle physics simulations

### 📊 Rich Visualizations

- Static plots with ggplot2
- Interactive visualizations with ggiraph
- Support for multiple walk comparison
- Customizable aesthetics

### 📈 Statistical Analysis

- Comprehensive summary statistics
- Cumulative functions (sum, product, min, max, mean)
- Confidence intervals
- Running quantiles
- Euclidean distance calculations
- Harmonic and geometric means
- Skewness and kurtosis

### 🔧 Tidyverse Compatible

Works seamlessly with:

- `dplyr` for data manipulation
- `tidyr` for data reshaping
- `ggplot2` for custom visualizations
- Pipe operators (`|>` and `%>%`)

## 📦 Package Information

- **Current Version**: 1.0.0.9000 (development)
- **CRAN Release**: 1.0.0
- **License**: MIT
- **Authors**: Steven P. Sanderson II, MPH & Antti Rask
- **R Version Required**: \>= 4.1.0

## 🔗 External Links

- **Package Website**: <https://www.spsanderson.com/RandomWalker/>
- **GitHub Repository**: <https://github.com/spsanderson/RandomWalker>
- **Issue Tracker**:
  <https://github.com/spsanderson/RandomWalker/issues>
- **CRAN Page**: <https://cran.r-project.org/package=RandomWalker>

## 📚 Learning Path

If you’re new to RandomWalker, we recommend following this learning
path:

1.  **Installation** - Install the package
2.  **Quick Start Guide** - Learn the basics
3.  **Automatic Random Walks** - Use
    [`rw30()`](https://www.spsanderson.com/RandomWalker/reference/rw30.md)
    for quick results
4.  **Continuous Distribution Generators** - Explore different
    distributions
5.  **Visualization Guide** - Create beautiful plots
6.  **Statistical Analysis Guide** - Analyze your walks
7.  **Use Cases and Examples** - See real-world applications

## 🎯 Common Use Cases

- **Finance**: Model stock price movements with Geometric Brownian
  Motion
- **Physics**: Simulate particle diffusion with Brownian Motion
- **Biology**: Model organism movement patterns
- **Computer Science**: Generate test data for algorithms
- **Education**: Teach probability and stochastic processes
- **Research**: Explore theoretical properties of random walks

## 🤝 Getting Help

- **Documentation**: Read the vignettes with
  [`vignette("getting-started")`](https://www.spsanderson.com/RandomWalker/articles/getting-started.md)
  or
  [`vignette("home")`](https://www.spsanderson.com/RandomWalker/articles/home.md)
- **Issues**: Report bugs at the [GitHub
  Issues](https://github.com/spsanderson/RandomWalker/issues) page
- **Discussions**: Ask questions in [GitHub
  Discussions](https://github.com/spsanderson/RandomWalker/discussions)
- **Email**: Contact the maintainer at spsanderson@gmail.com

## 🌟 Citation

If you use RandomWalker in your research, please cite it:

``` r
citation("RandomWalker")
```

## Example: Quick Start

Here’s a quick example to get you started with RandomWalker:

``` r
# Generate 30 random walks
walks <- rw30()

# View the first few rows
head(walks)
#> # A tibble: 6 × 3
#>   walk_number step_number     y
#>   <fct>             <int> <dbl>
#> 1 1                     1  0   
#> 2 1                     2 -1.40
#> 3 1                     3 -1.14
#> 4 1                     4 -3.58
#> 5 1                     5 -3.59
#> 6 1                     6 -2.97
```

``` r
# Visualize the walks
visualize_walks(walks)
```

![Visualization of multiple random walks generated by
rw30()](home_files/figure-html/visualize_example-1.png)

``` r
# Get summary statistics
walks |> 
  summarize_walks(.value = y) |>
  head()
#> Registered S3 method overwritten by 'quantmod':
#>   method            from
#>   as.zoo.data.frame zoo
#> Warning: There was 1 warning in `dplyr::summarize()`.
#> ℹ In argument: `geometric_mean = exp(mean(log(y)))`.
#> Caused by warning in `log()`:
#> ! NaNs produced
#> # A tibble: 1 × 16
#>   fns   fns_name dimensions mean_val median range quantile_lo quantile_hi
#>   <chr> <chr>         <dbl>    <dbl>  <dbl> <dbl>       <dbl>       <dbl>
#> 1 rw30  Rw30              1   -0.479 -0.677  43.4       -13.4        12.8
#> # ℹ 8 more variables: variance <dbl>, sd <dbl>, min_val <dbl>, max_val <dbl>,
#> #   harmonic_mean <dbl>, geometric_mean <dbl>, skewness <dbl>, kurtosis <dbl>
```

------------------------------------------------------------------------

**Ready to get started?** Explore the package documentation and other
vignettes to begin your journey with RandomWalker!
