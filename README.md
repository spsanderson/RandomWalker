
<!-- README.md is generated from README.Rmd. Please edit that file -->

# RandomWalker <img src="man/figures/logo.png" width="147" height="170" align="right" />

<!-- badges: start -->

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/RandomWalker)](https://cran.r-project.org/package=RandomWalker)
![](https://cranlogs.r-pkg.org/badges/RandomWalker)
![](https://cranlogs.r-pkg.org/badges/grand-total/RandomWalker)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html##experimental)
[![PRs
Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](https://kentcdodds.github.io/makeapullrequest.com/)
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
#>    walk_number step_number        y
#>    <fct>             <int>    <dbl>
#>  1 1                     1  0      
#>  2 1                     2 -0.644  
#>  3 1                     3 -0.619  
#>  4 1                     4  0.209  
#>  5 1                     5  0.885  
#>  6 1                     6 -0.00949
#>  7 1                     7  0.339  
#>  8 1                     8 -0.763  
#>  9 1                     9 -2.33   
#> 10 1                    10 -1.10
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
#> 1 rw30  Rw30              1   -0.189      0  36.5       -12.5        11.8
#> # ℹ 8 more variables: variance <dbl>, sd <dbl>, min_val <dbl>, max_val <dbl>,
#> #   harmonic_mean <dbl>, geometric_mean <dbl>, skewness <dbl>, kurtosis <dbl>

rw30() |>
  summarize_walks(.value = y, .group_var = walk_number)
#> # A tibble: 30 × 17
#>    walk_number fns   fns_name dimensions mean_val  median range quantile_lo
#>    <fct>       <chr> <chr>         <dbl>    <dbl>   <dbl> <dbl>       <dbl>
#>  1 1           rw30  Rw30              1  -3.25   -4.14   17.2       -8.78 
#>  2 2           rw30  Rw30              1  -1.85   -0.0795 18.6      -14.5  
#>  3 3           rw30  Rw30              1   8.01    7.73   16.4        0.408
#>  4 4           rw30  Rw30              1  -1.68   -1.53   12.1       -6.82 
#>  5 5           rw30  Rw30              1  -0.0203 -0.472  11.7       -3.46 
#>  6 6           rw30  Rw30              1  -1.25   -0.268  19.8      -12.7  
#>  7 7           rw30  Rw30              1  -6.32   -6.51   18.3      -15.3  
#>  8 8           rw30  Rw30              1  -6.37   -8.92   15.2      -13.3  
#>  9 9           rw30  Rw30              1   0.327   0.0489  9.36      -2.55 
#> 10 10          rw30  Rw30              1  -1.63    1.68   25.6      -16.1  
#> # ℹ 20 more rows
#> # ℹ 9 more variables: quantile_hi <dbl>, variance <dbl>, sd <dbl>,
#> #   min_val <dbl>, max_val <dbl>, harmonic_mean <dbl>, geometric_mean <dbl>,
#> #   skewness <dbl>, kurtosis <dbl>
```
