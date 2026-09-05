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
#>  1 1               1 -0.499     99.5   50.1      99.5    99.5     99.5
#>  2 1               2 -2.09      97.4  -54.4      97.9    99.5     98.7
#>  3 1               3 -0.168     97.2  -45.2      97.9    99.8     99.1
#>  4 1               4 -0.890     96.4   -4.95     97.9    99.8     99.1
#>  5 1               5  0.272     96.6   -6.30     97.9   100.      99.3
#>  6 1               6  0.874     97.5  -11.8      97.9   101.      99.6
#>  7 1               7 -0.775     96.7   -2.66     97.9   101.      99.5
#>  8 1               8  0.497     97.2   -3.98     97.9   101.      99.7
#>  9 1               9 -0.887     96.3   -0.450    97.9   101.      99.6
#> 10 1              10 -0.0622    96.3   -0.422    97.9   101.      99.6
#> # ℹ 740 more rows
```
