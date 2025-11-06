# Distance Calculations

A function to calculate the Euclidean distance between two vectors.

## Usage

``` r
euclidean_distance(.data, .x, .y, .pull_vector = FALSE)
```

## Arguments

- .data:

  A data frame

- .x:

  A numeric vector

- .y:

  A numeric vector

- .pull_vector:

  A boolean of TRUE or FALSE. Default is FALSE which will augment the
  distance to the data frame. TRUE will return a vector of the distances
  as the return.

## Value

A numeric Vector of ditances

## Details

A function to calculate the Euclidean distance between two vectors. It
uses the formula `sqrt((x - lag(x))^2 + (y - lag(y))^2)`. The function
uses augments the data frame with a new column called `distance`.

## See also

Other Vector Function:
[`cgmean()`](https://www.spsanderson.com/RandomWalker/reference/cgmean.md),
[`chmean()`](https://www.spsanderson.com/RandomWalker/reference/chmean.md),
[`ckurtosis()`](https://www.spsanderson.com/RandomWalker/reference/ckurtosis.md),
[`cmean()`](https://www.spsanderson.com/RandomWalker/reference/cmean.md),
[`cmedian()`](https://www.spsanderson.com/RandomWalker/reference/cmedian.md),
[`crange()`](https://www.spsanderson.com/RandomWalker/reference/crange.md),
[`csd()`](https://www.spsanderson.com/RandomWalker/reference/csd.md),
[`cskewness()`](https://www.spsanderson.com/RandomWalker/reference/cskewness.md),
[`cvar()`](https://www.spsanderson.com/RandomWalker/reference/cvar.md),
[`kurtosis_vec()`](https://www.spsanderson.com/RandomWalker/reference/kurtosis_vec.md),
[`rw_range()`](https://www.spsanderson.com/RandomWalker/reference/rw_range.md),
[`skewness_vec()`](https://www.spsanderson.com/RandomWalker/reference/skewness_vec.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
set.seed(123)
df <- rw30()
euclidean_distance(df, step_number, y)
#> # A tibble: 3,000 × 4
#>    walk_number step_number      y distance
#>    <fct>             <int>  <dbl>    <dbl>
#>  1 1                     1  0        NA   
#>  2 1                     2 -0.560     1.15
#>  3 1                     3 -0.791     1.03
#>  4 1                     4  0.768     1.85
#>  5 1                     5  0.839     1.00
#>  6 1                     6  0.968     1.01
#>  7 1                     7  2.68      1.99
#>  8 1                     8  3.14      1.10
#>  9 1                     9  1.88      1.61
#> 10 1                    10  1.19      1.21
#> # ℹ 2,990 more rows
euclidean_distance(df, step_number, y, TRUE) |> head(10)
#>  [1]       NA 1.146356 1.026149 1.851910 1.002483 1.008323 1.985308 1.101110
#>  [9] 1.612569 1.213164
```
