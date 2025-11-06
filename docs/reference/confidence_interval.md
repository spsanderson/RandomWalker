# Confidence Interval

Calculate the confidence interval

## Usage

``` r
confidence_interval(.vector, .interval = 0.95)
```

## Arguments

- .vector:

  A numeric vector of data points

- .interval:

  A numeric value representing the confidence level (e.g., 0.95 for 95%
  confidence interval) The default is 0.95

## Value

A named vector with the lower and upper bounds of the confidence
interval

## Details

This function calculates the confidence interval for a given vector and
interval.

## See also

Other Utility Functions:
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
[`std_cum_sum_augment()`](https://www.spsanderson.com/RandomWalker/reference/std_cum_sum_augment.md),
[`subset_walks()`](https://www.spsanderson.com/RandomWalker/reference/subset_walks.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
confidence_interval(rnorm(100), 0.95)
#> # A tibble: 1 × 2
#>    lower upper
#>    <dbl> <dbl>
#> 1 -0.285 0.134
```
