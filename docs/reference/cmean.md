# Cumulative Mean

A function to return the cumulative mean of a vector.

## Usage

``` r
cmean(.x)
```

## Arguments

- .x:

  A numeric vector

## Value

A numeric vector

## Details

A function to return the cumulative mean of a vector. It uses
[`dplyr::cummean()`](https://rdrr.io/pkg/dplyr/man/cumall.html) as the
basis of the function.

## See also

Other Vector Function:
[`cgmean()`](https://www.spsanderson.com/RandomWalker/reference/cgmean.md),
[`chmean()`](https://www.spsanderson.com/RandomWalker/reference/chmean.md),
[`ckurtosis()`](https://www.spsanderson.com/RandomWalker/reference/ckurtosis.md),
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

cmean(x)
#>  [1] 21.00000 21.00000 21.60000 21.55000 20.98000 20.50000 19.61429 20.21250
#>  [9] 20.50000 20.37000 20.13636 19.82500 19.63077 19.31429 18.72000 18.20000
#> [17] 17.99412 18.79444 19.40526 20.13000 20.19524 19.98182 19.77391 19.50417
#> [25] 19.49200 19.79231 20.02222 20.39286 20.23448 20.21667 20.04839 20.09062
```
