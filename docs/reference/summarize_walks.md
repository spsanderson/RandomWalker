# Summarize Walks Data

Summarizes random walk data by computing statistical measures.

## Usage

``` r
summarize_walks(.data, .value, .group_var = NULL)

summarise_walks(.data, .value, .group_var = NULL)
```

## Arguments

- .data:

  A data frame or tibble containing random walk data.

- .value:

  A column name (unquoted) representing the value to summarize.

- .group_var:

  An optional column name (unquoted) representing the grouping variable.
  Defaults to `NULL` for one overall summary across all walks.

## Value

A tibble containing the summarized statistics for each group, including
mean, median, range, quantiles, variance, standard deviation, and more.

## Details

This function requires that the input data frame contains a column named
'walk_number' and that the value to summarize is provided. It computes
statistics such as mean, median, variance, and quantiles for the
specified value variable. Omit `.group_var` or set it to `NULL` for an
overall summary, ignoring any existing grouping on the input. Supply a
grouping column to summarize only by that column. Dimension metadata is
read from `dimensions`, falling back to the legacy `dimension`
attribute. If neither is present, `dimensions` is `NA_integer_`.

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

# Summarize by walk
summarize_walks(walk_data, cum_sum_y, walk_number) |>
 glimpse()
#> Rows: 25
#> Columns: 18
#> $ walk_number    <fct> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, …
#> $ fns            <chr> "random_normal_walk", "random_normal_walk", "random_nor…
#> $ fns_name       <chr> "Random Normal Walk", "Random Normal Walk", "Random Nor…
#> $ dimensions     <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1…
#> $ obs            <int> 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, …
#> $ mean_val       <dbl> 100.28223, 100.07428, 99.60103, 100.92237, 100.52388, 9…
#> $ median         <dbl> 100.38746, 100.03188, 99.46622, 100.95986, 100.59073, 9…
#> $ range          <dbl> 1.4112366, 0.7933972, 1.8000254, 1.6746136, 1.2704141, …
#> $ quantile_lo    <dbl> 99.56322, 99.78383, 99.01963, 100.08731, 99.92631, 97.7…
#> $ quantile_hi    <dbl> 100.81114, 100.49322, 100.52730, 101.64598, 101.01788, …
#> $ variance       <dbl> 0.16513629, 0.03658384, 0.21120318, 0.17645077, 0.11650…
#> $ sd             <dbl> 0.4089335, 0.1924758, 0.4624680, 0.4227107, 0.3434863, …
#> $ min_val        <dbl> 99.51558, 99.76337, 98.85992, 100.04337, 99.82228, 97.7…
#> $ max_val        <dbl> 100.92682, 100.55677, 100.65995, 101.71798, 101.09270, …
#> $ harmonic_mean  <dbl> 100.28058, 100.07391, 99.59892, 100.92062, 100.52272, 9…
#> $ geometric_mean <dbl> 100.28141, 100.07409, 99.59997, 100.92150, 100.52330, 9…
#> $ skewness       <dbl> -0.32916650, 0.69240662, 0.69532128, -0.22420951, -0.29…
#> $ kurtosis       <dbl> -1.25959602, -0.17700121, -0.64815886, -0.73025927, -1.…
# Overall summary (omitted grouping and explicit NULL are equivalent)
summarize_walks(walk_data, y) |>
  glimpse()
#> Warning: There was 1 warning in `dplyr::summarize()`.
#> ℹ In argument: `geometric_mean = exp(mean(log(y)))`.
#> Caused by warning in `log()`:
#> ! NaNs produced
#> Rows: 1
#> Columns: 17
#> $ fns            <chr> "random_normal_walk"
#> $ fns_name       <chr> "Random Normal Walk"
#> $ dimensions     <dbl> 1
#> $ obs            <int> 100
#> $ mean_val       <dbl> -0.001307085
#> $ median         <dbl> -0.003502369
#> $ range          <dbl> 0.6536899
#> $ quantile_lo    <dbl> -0.2063977
#> $ quantile_hi    <dbl> 0.1945617
#> $ variance       <dbl> 0.009762381
#> $ sd             <dbl> 0.09882947
#> $ min_val        <dbl> -0.3146528
#> $ max_val        <dbl> 0.3390371
#> $ harmonic_mean  <dbl> 0.06668465
#> $ geometric_mean <dbl> NaN
#> $ skewness       <dbl> 0.0008945441
#> $ kurtosis       <dbl> 0.2597754
summarize_walks(walk_data, y, .group_var = NULL) |>
  glimpse()
#> Warning: There was 1 warning in `dplyr::summarize()`.
#> ℹ In argument: `geometric_mean = exp(mean(log(y)))`.
#> Caused by warning in `log()`:
#> ! NaNs produced
#> Rows: 1
#> Columns: 17
#> $ fns            <chr> "random_normal_walk"
#> $ fns_name       <chr> "Random Normal Walk"
#> $ dimensions     <dbl> 1
#> $ obs            <int> 100
#> $ mean_val       <dbl> -0.001307085
#> $ median         <dbl> -0.003502369
#> $ range          <dbl> 0.6536899
#> $ quantile_lo    <dbl> -0.2063977
#> $ quantile_hi    <dbl> 0.1945617
#> $ variance       <dbl> 0.009762381
#> $ sd             <dbl> 0.09882947
#> $ min_val        <dbl> -0.3146528
#> $ max_val        <dbl> 0.3390371
#> $ harmonic_mean  <dbl> 0.06668465
#> $ geometric_mean <dbl> NaN
#> $ skewness       <dbl> 0.0008945441
#> $ kurtosis       <dbl> 0.2597754

# Example with missing value variable
# summarize_walks(walk_data, NULL, group) # This will trigger an error.
```
