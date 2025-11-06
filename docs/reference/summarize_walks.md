# Summarize Walks Data

Summarizes random walk data by computing statistical measures.

## Usage

``` r
summarize_walks(.data, .value, .group_var)

summarise_walks(.data, .value, .group_var)
```

## Arguments

- .data:

  A data frame or tibble containing random walk data.

- .value:

  A column name (unquoted) representing the value to summarize.

- .group_var:

  A column name (unquoted) representing the grouping variable.

## Value

A tibble containing the summarized statistics for each group, including
mean, median, range, quantiles, variance, standard deviation, and more.

## Details

This function requires that the input data frame contains a column named
'walk_number' and that the value to summarize is provided. It computes
statistics such as mean, median, variance, and quantiles for the
specified value variable. \#' This function summarizes a data frame
containing random walk data by computing various statistical measures
for a specified value variable, grouped by a specified grouping
variable. It checks for necessary attributes and ensures that the data
frame is structured correctly.

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union

# Example data frame
walk_data <- random_normal_walk(.initial_value = 100)

# Summarize the walks
summarize_walks(walk_data, cum_sum_y, walk_number) |>
 glimpse()
#> Registered S3 method overwritten by 'quantmod':
#>   method            from
#>   as.zoo.data.frame zoo 
#> Rows: 25
#> Columns: 17
#> $ walk_number    <fct> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, …
#> $ fns            <chr> "random_normal_walk", "random_normal_walk", "random_nor…
#> $ fns_name       <chr> "Random Normal Walk", "Random Normal Walk", "Random Nor…
#> $ obs            <int> 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, …
#> $ mean_val       <dbl> 100.60875, 99.57143, 99.98844, 100.58813, 99.83991, 99.…
#> $ median         <dbl> 100.71061, 99.68241, 100.08400, 100.32030, 99.81729, 99…
#> $ range          <dbl> 1.1942200, 1.3788293, 1.6161614, 1.9385922, 0.9016268, …
#> $ quantile_lo    <dbl> 100.03993, 98.75468, 98.96255, 99.81986, 99.42804, 98.7…
#> $ quantile_hi    <dbl> 101.10542, 99.99399, 100.37117, 101.63777, 100.16586, 1…
#> $ variance       <dbl> 0.13592630, 0.13452856, 0.12309330, 0.35242826, 0.04097…
#> $ sd             <dbl> 0.3710079, 0.3690955, 0.3530601, 0.5974022, 0.2037086, …
#> $ min_val        <dbl> 99.91943, 98.69788, 98.83098, 99.80782, 99.37457, 98.76…
#> $ max_val        <dbl> 101.11365, 100.07670, 100.44714, 101.74641, 100.27620, …
#> $ harmonic_mean  <dbl> 100.60740, 99.57008, 99.98721, 100.58464, 99.83950, 99.…
#> $ geometric_mean <dbl> 100.60807, 99.57076, 99.98783, 100.58638, 99.83971, 99.…
#> $ skewness       <dbl> -0.1223257305, -0.8728309611, -1.6176745105, 0.36528053…
#> $ kurtosis       <dbl> -1.56804736, -0.29097886, 2.20696562, -1.37838771, -0.5…
summarize_walks(walk_data, y) |>
  glimpse()
#> Warning: There was 1 warning in `dplyr::summarize()`.
#> ℹ In argument: `geometric_mean = exp(mean(log(y)))`.
#> Caused by warning in `log()`:
#> ! NaNs produced
#> Rows: 1
#> Columns: 16
#> $ fns            <chr> "random_normal_walk"
#> $ fns_name       <chr> "Random Normal Walk"
#> $ obs            <int> 100
#> $ mean_val       <dbl> -0.002675404
#> $ median         <dbl> -0.00689972
#> $ range          <dbl> 0.6998286
#> $ quantile_lo    <dbl> -0.2074207
#> $ quantile_hi    <dbl> 0.1937839
#> $ variance       <dbl> 0.009645782
#> $ sd             <dbl> 0.0982375
#> $ min_val        <dbl> -0.3146528
#> $ max_val        <dbl> 0.3851758
#> $ harmonic_mean  <dbl> 0.04066174
#> $ geometric_mean <dbl> NaN
#> $ skewness       <dbl> 0.02450231
#> $ kurtosis       <dbl> 0.2410395

# Example with missing value variable
# summarize_walks(walk_data, NULL, group) # This will trigger an error.
```
