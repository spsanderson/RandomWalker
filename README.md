---
output: github_document
---

<!-- README.md is generated from README.Rmd. Please edit that file -->



# RandomWalker <img src="man/figures/logo.png" width="147" height="170" align="right" />

<!-- badges: start -->
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/RandomWalker)](https://cran.r-project.org/package=RandomWalker)
![](https://cranlogs.r-pkg.org/badges/RandomWalker)
![](https://cranlogs.r-pkg.org/badges/grand-total/RandomWalker)
[![Lifecycle: stable](lifecycle-stable.svg)](href{https://lifecycle.r-lib.org/articles/stages.html#stable)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](https://kentcdodds.github.io/makeapullrequest.com/)
<!-- badges: end -->

The goal of RandomWalker is to allow users to easily create Random Walks of different
types that are compatible with the `tidyverse` suite of packages. The package is
currently in the experimental stage of development.

## Installation

You can install the released version of {TidyDensity} from CRAN with:

```r
install.packages("RandomWalker")
```

You can install the development version of RandomWalker from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("spsanderson/RandomWalker")
```

## Example

This is a basic example which shows you how to solve a common problem:


```r
library(RandomWalker)
#> Error in library(RandomWalker): there is no package called 'RandomWalker'
## basic example code
rw30() |>
  head(10)
#> Error in rw30(): could not find function "rw30"
```

Here is a basic visualization of a Random Walk:


```r
rw30() |>
  visualize_walks()
#> Error in visualize_walks(rw30()): could not find function "visualize_walks"
```

Here is a basic summary of the random walks:


```r
rw30() |>
  summarize_walks(.value = y)
#> Error in summarize_walks(rw30(), .value = y): could not find function "summarize_walks"

rw30() |>
  summarize_walks(.value = y, .group_var = walk_number)
#> Error in summarize_walks(rw30(), .value = y, .group_var = walk_number): could not find function "summarize_walks"
```
