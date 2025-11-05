# RandomWalker Wiki

<img src="../man/figures/logo.png" width="147" height="170" align="right" />

Welcome to the **RandomWalker** Wiki! This comprehensive guide will help you master the RandomWalker R package for generating, visualizing, and analyzing random walks.

## 📖 What is RandomWalker?

RandomWalker is a comprehensive R package that provides a unified, tidyverse-compatible interface for generating random walks of various types. Whether you're modeling stock prices, simulating particle movements, or exploring stochastic processes, RandomWalker makes it easy to:

- Generate random walks from 27+ different probability distributions
- Create walks in 1D, 2D, or 3D space
- Visualize walks with beautiful, interactive plots
- Compute comprehensive statistical summaries
- Work seamlessly with tidyverse tools

## 🚀 Quick Navigation

### Getting Started
- **[Installation](Installation.md)** - How to install the package
- **[Quick Start Guide](Quick-Start-Guide.md)** - Get up and running in minutes
- **[Basic Concepts](Basic-Concepts.md)** - Understanding random walks

### Function Guides
- **[Automatic Random Walks](Automatic-Random-Walks.md)** - Using `rw30()` for instant results
- **[Continuous Distributions](Continuous-Distribution-Generators.md)** - Normal, Brownian, Gamma, Beta, and more
- **[Discrete Distributions](Discrete-Distribution-Generators.md)** - Binomial, Poisson, Geometric, and more
- **[Multi-Dimensional Walks](Multi-Dimensional-Walks.md)** - Working in 2D and 3D space

### Advanced Topics
- **[Visualization Guide](Visualization-Guide.md)** - Creating beautiful plots
- **[Statistical Analysis Guide](Statistical-Analysis-Guide.md)** - Computing summary statistics
- **[Use Cases and Examples](Use-Cases-and-Examples.md)** - Real-world applications

### Reference
- **[API Reference](API-Reference.md)** - Complete function documentation
- **[FAQ](FAQ.md)** - Frequently Asked Questions
- **[Troubleshooting](Troubleshooting.md)** - Common issues and solutions

### Contributing
- **[Contributing Guide](Contributing-Guide.md)** - How to contribute to the project

## 💡 Key Features

### 🎲 27+ Distribution Types
Generate random walks from a wide variety of probability distributions including:
- **Continuous**: Normal, Brownian Motion, Geometric Brownian Motion, Beta, Cauchy, Chi-Squared, Exponential, F, Gamma, Log-Normal, Logistic, Student's t, Uniform, Weibull
- **Discrete**: Binomial, Discrete, Geometric, Hypergeometric, Multinomial, Negative Binomial, Poisson
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
- **R Version Required**: >= 4.1.0

## 🔗 External Links

- **Package Website**: https://www.spsanderson.com/RandomWalker/
- **GitHub Repository**: https://github.com/spsanderson/RandomWalker
- **Issue Tracker**: https://github.com/spsanderson/RandomWalker/issues
- **CRAN Page**: https://cran.r-project.org/package=RandomWalker

## 📚 Learning Path

If you're new to RandomWalker, we recommend following this learning path:

1. **[Installation](Installation.md)** - Install the package
2. **[Quick Start Guide](Quick-Start-Guide.md)** - Learn the basics
3. **[Automatic Random Walks](Automatic-Random-Walks.md)** - Use `rw30()` for quick results
4. **[Continuous Distribution Generators](Continuous-Distribution-Generators.md)** - Explore different distributions
5. **[Visualization Guide](Visualization-Guide.md)** - Create beautiful plots
6. **[Statistical Analysis Guide](Statistical-Analysis-Guide.md)** - Analyze your walks
7. **[Use Cases and Examples](Use-Cases-and-Examples.md)** - See real-world applications

## 🎯 Common Use Cases

- **Finance**: Model stock price movements with Geometric Brownian Motion
- **Physics**: Simulate particle diffusion with Brownian Motion
- **Biology**: Model organism movement patterns
- **Computer Science**: Generate test data for algorithms
- **Education**: Teach probability and stochastic processes
- **Research**: Explore theoretical properties of random walks

## 🤝 Getting Help

- **Documentation**: Read the vignettes with `vignette("getting-started")`
- **Issues**: Report bugs at the [GitHub Issues](https://github.com/spsanderson/RandomWalker/issues) page
- **Discussions**: Ask questions in [GitHub Discussions](https://github.com/spsanderson/RandomWalker/discussions)
- **Email**: Contact the maintainer at spsanderson@gmail.com

## 🌟 Citation

If you use RandomWalker in your research, please cite it:

```r
citation("RandomWalker")
```

---

**Ready to get started?** Head over to the **[Installation](Installation.md)** page to begin your journey with RandomWalker!
