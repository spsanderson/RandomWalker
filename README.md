
<!-- README.md is generated from README.Rmd. Please edit that file -->

# RandomWalker <img src="man/figures/logo.png" width="147" height="170" align="right" />

<!-- badges: start -->

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/RandomWalker)](https://cran.r-project.org/package=RandomWalker)
![](https://cranlogs.r-pkg.org/badges/RandomWalker)
![](https://cranlogs.r-pkg.org/badges/grand-total/RandomWalker)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html##experimental)
[![PRs
Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](https://makeapullrequest.com)
<!-- badges: end -->

The goal of RandomWalker is to allow users to easily create Random Walks
of different types that are compatible with the `tidyverse` suite of
packages. The package is currently in the experimental stage of
development.

## Installation

You can install the released version of {TidyDensity} from CRAN with:

``` r
install.packages("RandomWalker")
```

You can install the development version of RandomWalker from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("spsanderson/RandomWalker")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(RandomWalker)
## basic example code
rw30() |>
  head(10)
#> # A tibble: 10 × 3
#>    walk_number     x       y
#>    <fct>       <int>   <dbl>
#>  1 1               1  0     
#>  2 1               2  0.609 
#>  3 1               3  1.11  
#>  4 1               4  0.344 
#>  5 1               5 -0.627 
#>  6 1               6 -1.67  
#>  7 1               7 -0.713 
#>  8 1               8  0.0888
#>  9 1               9 -0.151 
#> 10 1              10 -0.534
```

Here is a basic visualization of a Random Walk:

``` r
rw30() |>
  visualize_walks()
```

<img src="man/figures/README-random_walk_visual_example-1.png" width="100%" />
