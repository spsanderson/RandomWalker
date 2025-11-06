# Compute Skewness of a Vector

This function takes in a vector as it's input and will return the
skewness of that vector. The length of this vector must be at least four
numbers. The skewness explains the 'tailedness' of the distribution of
data.

`((1/n) * sum(x - mu})^3) / ((()1/n) * sum(x - mu)^2)^(3/2)`

## Usage

``` r
skewness_vec(.x)
```

## Arguments

- .x:

  A numeric vector of length four or more.

## Value

The skewness of a vector

## Details

A function to return the skewness of a vector.

## See also

<https://en.wikipedia.org/wiki/Skewness>

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
[`rw_range()`](https://www.spsanderson.com/RandomWalker/reference/rw_range.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
set.seed(123)
skewness_vec(rnorm(100, 3, 2))
#> [1] 0.06049948
```
