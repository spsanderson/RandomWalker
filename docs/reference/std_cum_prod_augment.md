# Augment Cumulative Product

This function augments a data frame by adding cumulative product columns
for specified variables.

## Usage

``` r
std_cum_prod_augment(.data, .value, .names = "auto", .initial_value = 1)
```

## Arguments

- .data:

  A data frame to augment.

- .value:

  A column name or names for which to compute the cumulative product.

- .names:

  Optional. A character vector of names for the new cumulative product
  columns. Defaults to "auto", which generates names based on the
  original column names.

- .initial_value:

  A numeric value to start the cumulative product from. Defaults to 1.

## Value

A tibble with the original data and additional columns containing the
cumulative products.

## Details

The function takes a data frame and a column name (or names) and
computes the cumulative product for each specified column, starting from
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
[`std_cum_max_augment()`](https://www.spsanderson.com/RandomWalker/reference/std_cum_max_augment.md),
[`std_cum_mean_augment()`](https://www.spsanderson.com/RandomWalker/reference/std_cum_mean_augment.md),
[`std_cum_min_augment()`](https://www.spsanderson.com/RandomWalker/reference/std_cum_min_augment.md),
[`std_cum_sum_augment()`](https://www.spsanderson.com/RandomWalker/reference/std_cum_sum_augment.md),
[`subset_walks()`](https://www.spsanderson.com/RandomWalker/reference/subset_walks.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
df <- data.frame(x = 1:5, y = 6:10)
std_cum_prod_augment(df, .value = x)
#> # A tibble: 5 × 3
#>       x     y cum_prod_x
#>   <int> <int>      <dbl>
#> 1     1     6          2
#> 2     2     7          6
#> 3     3     8         24
#> 4     4     9        120
#> 5     5    10        720
std_cum_prod_augment(df, .value = y, .names = c("cumprod_y"))
#> # A tibble: 5 × 3
#>       x     y cumprod_y
#>   <int> <int>     <dbl>
#> 1     1     6         7
#> 2     2     7        56
#> 3     3     8       504
#> 4     4     9      5040
#> 5     5    10     55440
```
