# Cumulative Range

A function to return the cumulative range of a vector.

## Arguments

- .x:

  A numeric vector

## Value

A numeric vector

## Details

A function to return the cumulative range of a vector. It uses
`max(.x[1:k]) - min(.x[1:k])` as the basis of the function.

## See also

Other Vector Function:
[`cgmean`](https://www.spsanderson.com/RandomWalker/reference/cgmean.md)`()`,
[`chmean`](https://www.spsanderson.com/RandomWalker/reference/chmean.md)`()`,
[`ckurtosis`](https://www.spsanderson.com/RandomWalker/reference/ckurtosis.md)`()`,
[`cmean`](https://www.spsanderson.com/RandomWalker/reference/cmean.md)`()`,
[`cmedian`](https://www.spsanderson.com/RandomWalker/reference/cmedian.md)`()`,
[`csd`](https://www.spsanderson.com/RandomWalker/reference/csd.md)`()`,
[`cskewness`](https://www.spsanderson.com/RandomWalker/reference/cskewness.md)`()`,
[`cvar`](https://www.spsanderson.com/RandomWalker/reference/cvar.md)`()`,
[`kurtosis_vec`](https://www.spsanderson.com/RandomWalker/reference/kurtosis_vec.md)`()`,
[`rw_range`](https://www.spsanderson.com/RandomWalker/reference/rw_range.md)`()`,
[`skewness_vec`](https://www.spsanderson.com/RandomWalker/reference/skewness_vec.md)`()`

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
x <- mtcars$mpg

crange(x)
#>  [1]  0.0  0.0  1.8  1.8  4.1  4.7  8.5 10.1 10.1 10.1 10.1 10.1 10.1 10.1 14.0
#> [16] 14.0 14.0 22.0 22.0 23.5 23.5 23.5 23.5 23.5 23.5 23.5 23.5 23.5 23.5 23.5
#> [31] 23.5 23.5
```
