# Helper function to convert a snake_case string to Title Case

Converts a snake_case string to Title Case.

## Usage

``` r
convert_snake_to_title_case(string)
```

## Arguments

- string:

  A character string in snake_case format.

## Value

A character string converted to Title Case.

## Details

This function is useful for formatting strings in a more readable way,
especially when dealing with variable names or identifiers that use
snake_case. This function takes a snake_case string and converts it to
Title Case. It replaces underscores with spaces, capitalizes the first
letter of each word, and replaces the substring "cum" with "cumulative"
for better readability.

## See also

Other Utility Functions:
[`confidence_interval()`](https://www.spsanderson.com/RandomWalker/reference/confidence_interval.md),
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

Antti Lennart Rask

## Examples

``` r
convert_snake_to_title_case("hello_world") # "Hello World"
#> [1] "Hello World"
convert_snake_to_title_case("this_is_a_test") # "This Is A Test"
#> [1] "This Is A Test"
convert_snake_to_title_case("cumulative_sum") # "Cumulative Sum"
#> [1] "Cumulative Sum"
```
