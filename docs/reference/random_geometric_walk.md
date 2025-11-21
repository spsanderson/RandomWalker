# Generate Multiple Random Geometric Walks in Multiple Dimensions

The `random_geometric_walk` function generates multiple random walks
using the geometric distribution via
[`rgeom()`](https://rdrr.io/r/stats/Geometric.html). The user can
specify the number of walks, the number of steps in each walk, and the
probability of success in each trial. The function also allows for
sampling a proportion of the steps and optionally sampling with
replacement.

## Usage

``` r
random_geometric_walk(
  .num_walks = 25,
  .n = 100,
  .prob = 0.5,
  .initial_value = 0,
  .samp = TRUE,
  .replace = TRUE,
  .sample_size = 0.8,
  .dimensions = 1
)
```

## Arguments

- .num_walks:

  An integer specifying the number of random walks to generate. Default
  is 25.

- .n:

  An integer specifying the number of observations per walk. Default is
  100.

- .prob:

  A numeric value specifying the probability of success in each trial.
  Must be 0 \< .prob \<= 1. Default is 0.5.

- .initial_value:

  A numeric value indicating the initial value of the walks. Default is
  0.

- .samp:

  A logical value indicating whether to sample the geometric values.
  Default is TRUE.

- .replace:

  A logical value indicating whether sampling is with replacement.
  Default is TRUE.

- .sample_size:

  A numeric value between 0 and 1 specifying the proportion of `.n` to
  sample. Default is 0.8.

- .dimensions:

  An integer specifying the number of dimensions (1, 2, or 3). Default
  is 1.

## Value

A tibble containing the generated random walks with columns depending on
the number of dimensions:

- `walk_number`: Factor representing the walk number.

- `step_number`: Step index.

- `y`: If `.dimensions = 1`, the value of the walk at each step.

- `x`, `y`: If `.dimensions = 2`, the values of the walk in two
  dimensions.

- `x`, `y`, `z`: If `.dimensions = 3`, the values of the walk in three
  dimensions.

The following are also returned based upon how many dimensions there are
and could be any of x, y and or z:

- `cum_sum`: Cumulative sum of `dplyr::all_of(.dimensions)`.

- `cum_prod`: Cumulative product of `dplyr::all_of(.dimensions)`.

- `cum_min`: Cumulative minimum of `dplyr::all_of(.dimensions)`.

- `cum_max`: Cumulative maximum of `dplyr::all_of(.dimensions)`.

- `cum_mean`: Cumulative mean of `dplyr::all_of(.dimensions)`.

The tibble includes attributes for the function parameters.

## Details

This function generates random walks where each step is drawn from the
geometric distribution using
[`rgeom()`](https://rdrr.io/r/stats/Geometric.html). The user can
control the number of walks, steps per walk, and the probability of
success (`prob`). The function supports 1, 2, or 3 dimensions, and
augments the output with cumulative statistics for each walk. Sampling
can be performed with or without replacement, and a proportion of steps
can be sampled if desired.

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
[`random_displacement_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_displacement_walk.md),
[`random_exponential_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_exponential_walk.md),
[`random_f_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_f_walk.md),
[`random_gamma_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_gamma_walk.md),
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
[`random_displacement_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_displacement_walk.md),
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
set.seed(123)
random_geometric_walk()
#> # A tibble: 2,000 × 8
#>    walk_number step_number     y cum_sum_y cum_prod_y cum_min_y cum_max_y
#>    <fct>             <int> <int>     <dbl>      <dbl>     <dbl>     <dbl>
#>  1 1                     1     1         1          0         1         1
#>  2 1                     2     3         4          0         1         3
#>  3 1                     3     1         5          0         1         3
#>  4 1                     4     0         5          0         0         3
#>  5 1                     5     0         5          0         0         3
#>  6 1                     6     3         8          0         0         3
#>  7 1                     7     0         8          0         0         3
#>  8 1                     8     0         8          0         0         3
#>  9 1                     9     1         9          0         0         3
#> 10 1                    10     0         9          0         0         3
#> # ℹ 1,990 more rows
#> # ℹ 1 more variable: cum_mean_y <dbl>

set.seed(123)
random_geometric_walk(.dimensions = 2) |>
  head() |>
  t()
#>             [,1]       [,2]       [,3]       [,4]       [,5]       [,6]      
#> walk_number "1"        "1"        "1"        "1"        "1"        "1"       
#> step_number "1"        "2"        "3"        "4"        "5"        "6"       
#> x           "1"        "3"        "1"        "0"        "0"        "3"       
#> y           "0"        "0"        "0"        "0"        "0"        "0"       
#> cum_sum_x   "1"        "4"        "5"        "5"        "5"        "8"       
#> cum_sum_y   "0"        "0"        "0"        "0"        "0"        "0"       
#> cum_prod_x  "0"        "0"        "0"        "0"        "0"        "0"       
#> cum_prod_y  "0"        "0"        "0"        "0"        "0"        "0"       
#> cum_min_x   "1"        "1"        "1"        "0"        "0"        "0"       
#> cum_min_y   "0"        "0"        "0"        "0"        "0"        "0"       
#> cum_max_x   "1"        "3"        "3"        "3"        "3"        "3"       
#> cum_max_y   "0"        "0"        "0"        "0"        "0"        "0"       
#> cum_mean_x  "1.000000" "2.000000" "1.666667" "1.250000" "1.000000" "1.333333"
#> cum_mean_y  "0"        "0"        "0"        "0"        "0"        "0"       
```
