# Cumulative Skewness

A function to return the cumulative skewness of a vector.

## Usage

``` r
cskewness(.x)
```

## Arguments

- .x:

  A numeric vector

## Value

A numeric vector

## Details

A function to return the cumulative skewness of a vector.

## See also

Other Vector Function:
[`cgmean()`](https://www.spsanderson.com/RandomWalker/reference/cgmean.md),
[`chmean()`](https://www.spsanderson.com/RandomWalker/reference/chmean.md),
[`ckurtosis()`](https://www.spsanderson.com/RandomWalker/reference/ckurtosis.md),
[`cmean()`](https://www.spsanderson.com/RandomWalker/reference/cmean.md),
[`cmedian()`](https://www.spsanderson.com/RandomWalker/reference/cmedian.md),
[`crange()`](https://www.spsanderson.com/RandomWalker/reference/crange.md),
[`csd()`](https://www.spsanderson.com/RandomWalker/reference/csd.md),
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

cskewness(x)
#>  [1]          NaN          NaN  0.707106781  0.997869718 -0.502052297
#>  [6] -0.258803244 -0.867969171 -0.628239920 -0.808101715 -0.695348960
#> [11] -0.469220594 -0.256323338 -0.091505282  0.002188142 -0.519593266
#> [16] -0.512660692 -0.379598706  0.614549281  0.581410573  0.649357202
#> [21]  0.631855977  0.706212631  0.775750182  0.821447605  0.844413861
#> [26]  0.716010069  0.614326432  0.525141032  0.582528820  0.601075783
#> [31]  0.652552397  0.640439864
```
