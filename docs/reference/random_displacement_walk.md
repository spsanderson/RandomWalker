# Generate a Random Displacement Walk in 2D

The `random_displacement_walk` function generates a single random walk
in 2 dimensions (x, y), where each step is a random displacement in both
x and y directions, sampled from the provided displacement and distance
spaces. The walk disregards steps where both x and y displacements are
zero.

## Usage

``` r
random_displacement_walk(
  .num_walks = 25,
  .seed = NULL,
  .n = 100,
  .distance_space = c(0, 1, 2, 3, 4),
  .displacement = c(-1, 1),
  .dimensions = 1
)
```

## Arguments

- .num_walks:

  An integer specifying the number of random walks to generate. Default
  is 25.

- .seed:

  An optional value to set the random seed. If NULL, no seed is set.
  Default is NULL.

- .n:

  The number of steps in the walk. Must be \>= 0. Default is 100.

- .distance_space:

  A numeric vector of possible step distances. Default is c(0, 1, 2, 3,
  4).

- .displacement:

  A numeric vector of possible step directions. Default is c(-1, 1).

- .dimensions:

  An integer specifying the number of dimensions (1, 2, or 3). Default
  is 1.

## Value

A tibble with columns depending on the number of dimensions:

- `step_number`: Step index.

- `y`: If `.dimensions = 1`, the value of the walk at each step.

- `x`, `y`: If `.dimensions = 2`, the values of the walk in two
  dimensions.

- `x`, `y`, `z`: If `.dimensions = 3`, the values of the walk in three
  dimensions.

The tibble includes attributes for the function parameters.

## See also

Other Generator Functions:
[`brownian_motion()`](https://www.spsanderson.com/RandomWalker/reference/brownian_motion.md),
[`custom_walk()`](https://www.spsanderson.com/RandomWalker/reference/custom_walk.md),
[`discrete_walk()`](https://www.spsanderson.com/RandomWalker/reference/discrete_walk.md),
[`geometric_brownian_motion()`](https://www.spsanderson.com/RandomWalker/reference/geometric_brownian_motion.md),
[`random_beta_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_beta_walk.md),
[`random_binomial_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_binomial_walk.md),
[`random_cauchy_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_cauchy_walk.md),
[`random_chisquared_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_chisquared_walk.md),
[`random_exponential_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_exponential_walk.md),
[`random_f_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_f_walk.md),
[`random_gamma_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_gamma_walk.md),
[`random_geometric_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_geometric_walk.md),
[`random_hypergeometric_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_hypergeometric_walk.md),
[`random_logistic_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_logistic_walk.md),
[`random_lognormal_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_lognormal_walk.md),
[`random_multinomial_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_multinomial_walk.md),
[`random_negbinomial_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_negbinomial_walk.md),
[`random_normal_drift_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_normal_drift_walk.md),
[`random_normal_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_normal_walk.md),
[`random_poisson_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_poisson_walk.md),
[`random_smirnov_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_smirnov_walk.md),
[`random_t_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_t_walk.md),
[`random_uniform_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_uniform_walk.md),
[`random_weibull_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_weibull_walk.md),
[`random_wilcox_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_wilcox_walk.md),
[`random_wilcoxon_sr_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_wilcoxon_sr_walk.md)

Other Discrete Distribution:
[`discrete_walk()`](https://www.spsanderson.com/RandomWalker/reference/discrete_walk.md),
[`random_binomial_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_binomial_walk.md),
[`random_geometric_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_geometric_walk.md),
[`random_hypergeometric_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_hypergeometric_walk.md),
[`random_multinomial_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_multinomial_walk.md),
[`random_negbinomial_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_negbinomial_walk.md),
[`random_poisson_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_poisson_walk.md),
[`random_smirnov_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_smirnov_walk.md),
[`random_wilcox_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_wilcox_walk.md),
[`random_wilcoxon_sr_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_wilcoxon_sr_walk.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
random_displacement_walk(.n = 10, .seed = Sys.Date())
#> # A tibble: 275 × 3
#>    walk_number step_number     y
#>    <fct>             <dbl> <dbl>
#>  1 1                     1     0
#>  2 1                     2     4
#>  3 1                     3     0
#>  4 1                     4    -1
#>  5 1                     5    -3
#>  6 1                     6    -1
#>  7 1                     7    -3
#>  8 1                     8    -2
#>  9 1                     9    -1
#> 10 1                    10    -4
#> # ℹ 265 more rows
```
