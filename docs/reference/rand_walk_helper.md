# Random Walk Helper

A function to help build random walks by mutating a data frame.

## Usage

``` r
rand_walk_helper(.data, .value)
```

## Arguments

- .data:

  The data frame to mutate.

- .value:

  The .initial_value to use. This is passed from the random walk
  function being called by the end user.

## Value

A modified data frame/tibble with the following columns added:

- `cum_sum`: Cumulative sum of `y`.

- `cum_prod`: Cumulative product of `y`.

- `cum_min`: Cumulative minimum of `y`.

- `cum_max`: Cumulative maximum of `y`.

- `cum_mean`: Cumulative mean of `y`.

## Details

A function to help build random walks by mutating a data frame. This
mutation adds the following columns to the data frame: `cum_sum`,
`cum_prod`, `cum_min`, `cum_max`, and `cum_mean`. The function is used
internally by certain functions that generate random walks.

## See also

Other Utility Functions:
[`confidence_interval()`](https://www.spsanderson.com/RandomWalker/reference/confidence_interval.md),
[`convert_snake_to_title_case()`](https://www.spsanderson.com/RandomWalker/reference/convert_snake_to_title_case.md),
[`generate_caption()`](https://www.spsanderson.com/RandomWalker/reference/generate_caption.md),
[`get_attributes()`](https://www.spsanderson.com/RandomWalker/reference/get_attributes.md),
[`rand_walk_column_names()`](https://www.spsanderson.com/RandomWalker/reference/rand_walk_column_names.md),
[`running_quantile()`](https://www.spsanderson.com/RandomWalker/reference/running_quantile.md),
[`std_cum_max_augment()`](https://www.spsanderson.com/RandomWalker/reference/std_cum_max_augment.md),
[`std_cum_mean_augment()`](https://www.spsanderson.com/RandomWalker/reference/std_cum_mean_augment.md),
[`std_cum_min_augment()`](https://www.spsanderson.com/RandomWalker/reference/std_cum_min_augment.md),
[`std_cum_prod_augment()`](https://www.spsanderson.com/RandomWalker/reference/std_cum_prod_augment.md),
[`std_cum_sum_augment()`](https://www.spsanderson.com/RandomWalker/reference/std_cum_sum_augment.md),
[`subset_walks()`](https://www.spsanderson.com/RandomWalker/reference/subset_walks.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
df <- data.frame(
  walk_number = factor(rep(1L:25L, each = 30L)),
  x = rep(1L:30L, 25L),
  y = rnorm(750L, 0L, 1L)
  )

rand_walk_helper(df, 100)
#> # A tibble: 750 × 8
#>    walk_number     x       y cum_sum cum_prod cum_min cum_max cum_mean
#>    <fct>       <int>   <dbl>   <dbl>    <dbl>   <dbl>   <dbl>    <dbl>
#>  1 1               1 -2.09      97.9 -109.       97.9    97.9     97.9
#>  2 1               2 -0.168     97.7  -90.3      97.9    99.8     98.9
#>  3 1               3 -0.890     96.9   -9.90     97.9    99.8     99.0
#>  4 1               4  0.272     97.1  -12.6      97.9   100.      99.3
#>  5 1               5  0.874     98.0  -23.6      97.9   101.      99.6
#>  6 1               6 -0.775     97.2   -5.32     97.9   101.      99.5
#>  7 1               7  0.497     97.7   -7.96     97.9   101.      99.7
#>  8 1               8 -0.887     96.8   -0.899    97.9   101.      99.6
#>  9 1               9 -0.0622    96.8   -0.844    97.9   101.      99.6
#> 10 1              10 -1.31      95.5    0.259    97.9   101.      99.5
#> # ℹ 740 more rows
```
