
<!-- README.md is generated from README.Rmd. Please edit that file -->

# RandomWalker

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
rw30()
#> # A tibble: 3,000 × 3
#>    walk       x value
#>    <fct>  <int> <dbl>
#>  1 walk_1     1 0    
#>  2 walk_1     2 0.916
#>  3 walk_1     3 1.26 
#>  4 walk_1     4 1.84 
#>  5 walk_1     5 2.53 
#>  6 walk_1     6 1.39 
#>  7 walk_1     7 1.94 
#>  8 walk_1     8 2.42 
#>  9 walk_1     9 1.86 
#> 10 walk_1    10 2.27 
#> # ℹ 2,990 more rows
```
