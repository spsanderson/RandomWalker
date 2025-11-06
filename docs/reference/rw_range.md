# Range

A function to return the range of a vector.

## Usage

``` r
rw_range(.x)
```

## Arguments

- .x:

  A numeric vector

## Value

A numeric vector

## Details

A function to return the range of a vector. It uses `max(.x) - min(.x)`
as the basis of the function.

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
[`euclidean_distance()`](https://www.spsanderson.com/RandomWalker/reference/euclidean_distance.md),
[`kurtosis_vec()`](https://www.spsanderson.com/RandomWalker/reference/kurtosis_vec.md),
[`skewness_vec()`](https://www.spsanderson.com/RandomWalker/reference/skewness_vec.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
x <- mtcars$mpg

rw_range(x)
#> [1] 23.5
```
