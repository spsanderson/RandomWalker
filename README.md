
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
#>    walk_number     x      y
#>    <fct>       <int>  <dbl>
#>  1 1               1  0    
#>  2 1               2  1.52 
#>  3 1               3  2.02 
#>  4 1               4  1.82 
#>  5 1               5 -0.120
#>  6 1               6  0.588
#>  7 1               7  0.412
#>  8 1               8  0.998
#>  9 1               9  1.37 
#> 10 1              10  0.826
```

Here is a basic visualization of a Random Walk:

``` r
rw30() |>
  visualize_walks()
```

<img src="man/figures/README-random_walk_visual_example-1.png" alt="Visualize a Random Walk of 30 simulations" width="100%" />

Here is a basic summary of the random walks:

``` r
rw30() |>
  summarize_walks(.value = y)
#> # A tibble: 1 × 16
#>   fns   fns_name dimensions mean_val median range quantile_lo quantile_hi
#>   <chr> <chr>         <dbl>    <dbl>  <dbl> <dbl>       <dbl>       <dbl>
#> 1 rw30  Rw30              1   -0.670 -0.132  47.4       -18.3        14.2
#> # ℹ 8 more variables: variance <dbl>, sd <dbl>, min_val <dbl>, max_val <dbl>,
#> #   harmonic_mean <dbl>, geometric_mean <dbl>, skewness <dbl>, kurtosis <dbl>

rw30() |>
  summarize_walks(.value = y, .group_var = walk_number)
#> # A tibble: 30 × 17
#>    walk_number fns   fns_name dimensions mean_val  median range quantile_lo
#>    <fct>       <chr> <chr>         <dbl>    <dbl>   <dbl> <dbl>       <dbl>
#>  1 1           rw30  Rw30              1  -0.951   0.0447 15.6       -10.5 
#>  2 2           rw30  Rw30              1  -0.947  -2.02   13.5        -5.69
#>  3 3           rw30  Rw30              1  -2.91   -3.42   12.9        -8.84
#>  4 4           rw30  Rw30              1  -0.0432  0.299  11.1        -4.63
#>  5 5           rw30  Rw30              1  -4.28   -4.52   12.8        -9.94
#>  6 6           rw30  Rw30              1  -1.77   -1.71   14.6        -9.60
#>  7 7           rw30  Rw30              1  -3.51   -3.43   13.6        -9.47
#>  8 8           rw30  Rw30              1  -4.25   -3.94   20.1       -14.8 
#>  9 9           rw30  Rw30              1   1.93    2.16    7.11       -1.46
#> 10 10          rw30  Rw30              1   0.621   1.20   13.7        -5.59
#> # ℹ 20 more rows
#> # ℹ 9 more variables: quantile_hi <dbl>, variance <dbl>, sd <dbl>,
#> #   min_val <dbl>, max_val <dbl>, harmonic_mean <dbl>, geometric_mean <dbl>,
#> #   skewness <dbl>, kurtosis <dbl>
```
