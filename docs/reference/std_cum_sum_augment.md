# Augment Cumulative Sum

This function augments a data frame by adding cumulative sum columns for
specified variables.

## Usage

``` r
std_cum_sum_augment(.data, .value, .names = "auto", .initial_value = 0)
```

## Arguments

- .data:

  A data frame to augment.

- .value:

  A column name or names for which to compute the cumulative sum.

- .names:

  Optional. A character vector of names for the new cumulative sum
  columns. Defaults to "auto", which generates names based on the
  original column names.

- .initial_value:

  A numeric value to start the cumulative sum from. Defaults to 0.

## Value

A tibble with the original data and additional columns containing the
cumulative sums.

## Details

The function takes a data frame and a column name (or names) and
computes the cumulative sum for each specified column, starting from an
initial value. If the column names are not provided, it will throw an
error.

## See also

Other Utility Functions:
[`confidence_interval()`](https://www.spsanderson.com/RandomWalker/reference/confidence_interval.md),
[`convert_snake_to_title_case()`](https://www.spsanderson.com/RandomWalker/reference/convert_snake_to_title_case.md),
[`generate_caption()`](https://www.spsanderson.com/RandomWalker/reference/generate_caption.md),
[`get_attributes()`](https://www.spsanderson.com/RandomWalker/reference/get_attributes.md),
[`rand_walk_column_names()`](https://www.spsanderson.com/RandomWalker/reference/rand_walk_column_names.md),
[`rand_walk_helper()`](https://www.spsanderson.com/RandomWalker/reference/rand_walk_helper.md),
[`running_quantile()`](https://www.spsanderson.com/RandomWalker/reference/running_quantile.md),
[`std_cum_max_augment()`](https://www.spsanderson.com/RandomWalker/reference/std_cum_max_augment.md),
[`std_cum_mean_augment()`](https://www.spsanderson.com/RandomWalker/reference/std_cum_mean_augment.md),
[`std_cum_min_augment()`](https://www.spsanderson.com/RandomWalker/reference/std_cum_min_augment.md),
[`std_cum_prod_augment()`](https://www.spsanderson.com/RandomWalker/reference/std_cum_prod_augment.md),
[`subset_walks()`](https://www.spsanderson.com/RandomWalker/reference/subset_walks.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
df <- data.frame(x = 1:5, y = 6:10)
std_cum_sum_augment(df, .value = x)
#> # A tibble: 5 × 3
#>       x     y cum_sum_x
#>   <int> <int>     <dbl>
#> 1     1     6         1
#> 2     2     7         3
#> 3     3     8         6
#> 4     4     9        10
#> 5     5    10        15
std_cum_sum_augment(df, .value = y, .names = c("cumsum_y"))
#> # A tibble: 5 × 3
#>       x     y cumsum_y
#>   <int> <int>    <dbl>
#> 1     1     6        6
#> 2     2     7       13
#> 3     3     8       21
#> 4     4     9       30
#> 5     5    10       40
```
