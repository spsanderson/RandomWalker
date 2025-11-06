# Helper function to generate a caption string based on provided attributes

Generates a caption string based on provided attributes.

## Usage

``` r
generate_caption(attributes)
```

## Arguments

- attributes:

  A list containing various attributes that may include `dimension`,
  `num_steps`, `mu`, and `sd`.

## Value

A character string representing the generated caption. If no attributes
are provided, it returns an empty string.

## Details

This function is useful for creating descriptive captions for plots or
outputs based on the attributes provided. It ensures that only non-null
attributes are included in the caption. This function constructs a
caption string by checking various attributes provided in a list. It
formats the caption based on the presence of specific attributes, such
as dimensions, number of steps, and statistical parameters like mu and
standard deviation (sd).

## See also

Other Utility Functions:
[`confidence_interval()`](https://www.spsanderson.com/RandomWalker/reference/confidence_interval.md),
[`convert_snake_to_title_case()`](https://www.spsanderson.com/RandomWalker/reference/convert_snake_to_title_case.md),
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

Antti Lennart Rask

## Examples

``` r
attrs <- list(dimension = 3, num_steps = 100, mu = 0.5, sd = 1.2)
generate_caption(attrs) # "3 dimensions, 100 steps, mu = 0.5, sd = 1.2."
#> [1] "3 dimensions, 100 steps, mu = 0.5, sd = 1.2."

attrs <- list(dimension = NULL, num_steps = 50, mu = NULL, sd = 2.0)
generate_caption(attrs) # "50 steps, sd = 2.0."
#> [1] "50 steps, sd = 2."
```
