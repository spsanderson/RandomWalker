# Get Attributes

The `get_attributes` function takes an R object as input and returns its
attributes, omitting the row.names attribute.

## Usage

``` r
get_attributes(.data)
```

## Arguments

- .data:

  An R object from which attributes are to be extracted.

## Value

A list of attributes of the input R object, excluding row.names.

## Details

This function retrieves the attributes of a given R object, excluding
the row.names attribute.

## See also

Other Utility Functions:
[`confidence_interval()`](https://www.spsanderson.com/RandomWalker/reference/confidence_interval.md),
[`convert_snake_to_title_case()`](https://www.spsanderson.com/RandomWalker/reference/convert_snake_to_title_case.md),
[`generate_caption()`](https://www.spsanderson.com/RandomWalker/reference/generate_caption.md),
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
get_attributes(rw30())
#> $names
#> [1] "walk_number" "step_number" "y"          
#> 
#> $class
#> [1] "tbl_df"     "tbl"        "data.frame"
#> 
#> $num_walks
#> [1] 30
#> 
#> $num_steps
#> [1] 100
#> 
#> $mu
#> [1] 0
#> 
#> $sd
#> [1] 1
#> 
#> $fns
#> [1] "rw30"
#> 
#> $dimension
#> [1] 1
#> 
get_attributes(iris)
#> $names
#> [1] "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width"  "Species"     
#> 
#> $class
#> [1] "data.frame"
#> 
get_attributes(mtcars)
#> $names
#>  [1] "mpg"  "cyl"  "disp" "hp"   "drat" "wt"   "qsec" "vs"   "am"   "gear"
#> [11] "carb"
#> 
#> $class
#> [1] "data.frame"
#> 
```
