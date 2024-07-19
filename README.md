
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
#>    walk_number     x      y
#>    <fct>       <int>  <dbl>
#>  1 1               1  0    
#>  2 1               2 -0.821
#>  3 1               3 -0.969
#>  4 1               4 -2.08 
#>  5 1               5 -3.58 
#>  6 1               6 -2.50 
#>  7 1               7 -4.65 
#>  8 1               8 -4.68 
#>  9 1               9 -5.75 
#> 10 1              10 -6.49
```
