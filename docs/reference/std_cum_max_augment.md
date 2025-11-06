# Augment Cumulative Maximum

This function augments a data frame by adding cumulative maximum columns
for specified variables.

## Usage

``` r
std_cum_max_augment(.data, .value, .names = "auto", .initial_value = 0)
```

## Arguments

- .data:

  A data frame to augment.

- .value:

  A column name or names for which to compute the cumulative maximum.

- .names:

  Optional. A character vector of names for the new cumulative maximum
  columns. Defaults to "auto", which generates names based on the
  original column names.

- .initial_value:

  A numeric value to start the cumulative maximum from. Defaults to 0.

## Value

A tibble with the original data and additional columns containing the
cumulative maximums.

## Details

The function takes a data frame and a column name (or names) and
computes the cumulative maximum for each specified column, starting from
an initial value. If the column names are not provided, it will throw an
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
[`std_cum_mean_augment()`](https://www.spsanderson.com/RandomWalker/reference/std_cum_mean_augment.md),
[`std_cum_min_augment()`](https://www.spsanderson.com/RandomWalker/reference/std_cum_min_augment.md),
[`std_cum_prod_augment()`](https://www.spsanderson.com/RandomWalker/reference/std_cum_prod_augment.md),
[`std_cum_sum_augment()`](https://www.spsanderson.com/RandomWalker/reference/std_cum_sum_augment.md),
[`subset_walks()`](https://www.spsanderson.com/RandomWalker/reference/subset_walks.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
df <- data.frame(x = c(1, 3, 2, 5, 4), y = c(10, 7, 6, 12, 5))
std_cum_max_augment(df, .value = x)
#> # A tibble: 5 × 3
#>       x     y cum_max_x
#>   <dbl> <dbl>     <dbl>
#> 1     1    10         1
#> 2     3     7         3
#> 3     2     6         3
#> 4     5    12         5
#> 5     4     5         5
std_cum_max_augment(df, .value = y, .names = c("cummax_y"))
#> # A tibble: 5 × 3
#>       x     y cummax_y
#>   <dbl> <dbl>    <dbl>
#> 1     1    10       10
#> 2     3     7       10
#> 3     2     6       10
#> 4     5    12       12
#> 5     4     5       12
```
