# Cumulative Geometric Mean

A function to return the cumulative geometric mean of a vector.

## Usage

``` r
cgmean(.x)
```

## Arguments

- .x:

  A numeric vector

## Value

A numeric vector

## Details

A function to return the cumulative geometric mean of a vector.
`exp(cummean(log(.x)))`

## See also

Other Vector Function:
[`chmean()`](https://www.spsanderson.com/RandomWalker/reference/chmean.md),
[`ckurtosis()`](https://www.spsanderson.com/RandomWalker/reference/ckurtosis.md),
[`cmean()`](https://www.spsanderson.com/RandomWalker/reference/cmean.md),
[`cmedian()`](https://www.spsanderson.com/RandomWalker/reference/cmedian.md),
[`crange()`](https://www.spsanderson.com/RandomWalker/reference/crange.md),
[`csd()`](https://www.spsanderson.com/RandomWalker/reference/csd.md),
[`cskewness()`](https://www.spsanderson.com/RandomWalker/reference/cskewness.md),
[`cvar()`](https://www.spsanderson.com/RandomWalker/reference/cvar.md),
[`euclidean_distance()`](https://www.spsanderson.com/RandomWalker/reference/euclidean_distance.md),
[`kurtosis_vec()`](https://www.spsanderson.com/RandomWalker/reference/kurtosis_vec.md),
[`rw_range()`](https://www.spsanderson.com/RandomWalker/reference/rw_range.md),
[`skewness_vec()`](https://www.spsanderson.com/RandomWalker/reference/skewness_vec.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
x <- mtcars$mpg

cgmean(x)
#>  [1] 21.00000 21.00000 21.58363 21.53757 20.93755 20.43547 19.41935 19.98155
#>  [9] 20.27666 20.16633 19.93880 19.61678 19.42805 19.09044 18.33287 17.69470
#> [17] 17.50275 18.11190 18.61236 19.17879 19.28342 19.09293 18.90457 18.62961
#> [25] 18.65210 18.92738 19.15126 19.46993 19.33021 19.34242 19.18443 19.25006
```
