# Cumulative Kurtosis

A function to return the cumulative kurtosis of a vector.

## Usage

``` r
ckurtosis(.x)
```

## Arguments

- .x:

  A numeric vector

## Value

A numeric vector

## Details

A function to return the cumulative kurtosis of a vector.

## See also

Other Vector Function:
[`cgmean()`](https://www.spsanderson.com/RandomWalker/reference/cgmean.md),
[`chmean()`](https://www.spsanderson.com/RandomWalker/reference/chmean.md),
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

ckurtosis(x)
#>  [1]      NaN      NaN 1.500000 2.189216 2.518932 1.786006 2.744467 2.724675
#>  [9] 2.930885 2.988093 2.690270 2.269038 2.176622 1.992044 2.839430 2.481896
#> [17] 2.356826 3.877115 3.174702 2.896931 3.000743 3.091225 3.182071 3.212816
#> [25] 3.352916 3.015952 2.837139 2.535185 2.595908 2.691103 2.738468 2.799467
```
