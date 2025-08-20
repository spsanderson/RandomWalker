
<!-- README.md is generated from README.Rmd. Please edit that file -->

# RandomWalker <img src="man/figures/logo.png" width="147" height="170" align="right" />

<!-- badges: start -->

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/RandomWalker)](https://cran.r-project.org/package=RandomWalker)
![](https://cranlogs.r-pkg.org/badges/RandomWalker)
![](https://cranlogs.r-pkg.org/badges/grand-total/RandomWalker)
[![Lifecycle:
stable](lifecycle-stable.svg)](href%7Bhttps://lifecycle.r-lib.org/articles/stages.html#stable)
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
#>    walk_number step_number      y
#>    <fct>             <int>  <dbl>
#>  1 1                     1  0    
#>  2 1                     2  1.06 
#>  3 1                     3  0.977
#>  4 1                     4  1.86 
#>  5 1                     5  0.859
#>  6 1                     6  1.15 
#>  7 1                     7  0.708
#>  8 1                     8  1.02 
#>  9 1                     9 -1.18 
#> 10 1                    10 -0.772
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
#> 1 rw30  Rw30              1    0.715  0.783  43.6       -10.8        13.3
#> # ℹ 8 more variables: variance <dbl>, sd <dbl>, min_val <dbl>, max_val <dbl>,
#> #   harmonic_mean <dbl>, geometric_mean <dbl>, skewness <dbl>, kurtosis <dbl>

rw30() |>
  summarize_walks(.value = y, .group_var = walk_number)
#> # A tibble: 30 × 17
#>    walk_number fns   fns_name dimensions mean_val median range quantile_lo
#>    <fct>       <chr> <chr>         <dbl>    <dbl>  <dbl> <dbl>       <dbl>
#>  1 1           rw30  Rw30              1     9.18   7.69 21.0       -0.513
#>  2 2           rw30  Rw30              1   -11.2  -11.5  21.3      -19.4  
#>  3 3           rw30  Rw30              1    -3.04  -1.97 13.9       -9.88 
#>  4 4           rw30  Rw30              1     2.28   1.39 14.5       -3.82 
#>  5 5           rw30  Rw30              1    10.9    8.44 20.8        1.88 
#>  6 6           rw30  Rw30              1    -6.00  -5.96 15.2      -14.5  
#>  7 7           rw30  Rw30              1     4.36   4.55  9.30      -0.333
#>  8 8           rw30  Rw30              1    -5.87  -5.96 11.2       -9.81 
#>  9 9           rw30  Rw30              1    -6.68  -6.53 15.5      -14.6  
#> 10 10          rw30  Rw30              1    -6.93  -4.43 22.6      -20.4  
#> # ℹ 20 more rows
#> # ℹ 9 more variables: quantile_hi <dbl>, variance <dbl>, sd <dbl>,
#> #   min_val <dbl>, max_val <dbl>, harmonic_mean <dbl>, geometric_mean <dbl>,
#> #   skewness <dbl>, kurtosis <dbl>
```
