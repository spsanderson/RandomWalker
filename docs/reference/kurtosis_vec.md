# Compute Kurtosis of a Vector

This function takes in a vector as it's input and will return the
kurtosis of that vector. The length of this vector must be at least four
numbers. The kurtosis explains the sharpness of the peak of a
distribution of data.

`((1/n) * sum(x - mu})^4) / ((()1/n) * sum(x - mu)^2)^2`

## Usage

``` r
kurtosis_vec(.x)
```

## Arguments

- .x:

  A numeric vector of length four or more.

## Value

The kurtosis of a vector

## Details

A function to return the kurtosis of a vector.

## See also

<https://en.wikipedia.org/wiki/Kurtosis>

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
[`rw_range()`](https://www.spsanderson.com/RandomWalker/reference/rw_range.md),
[`skewness_vec()`](https://www.spsanderson.com/RandomWalker/reference/skewness_vec.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
set.seed(123)
kurtosis_vec(rnorm(100, 3, 2))
#> [1] 2.838947
```
