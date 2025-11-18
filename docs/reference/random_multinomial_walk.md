# Generate Multiple Random Multinomial Walks

A multinomial random walk is a stochastic process in which each step is
drawn from the multinomial distribution. This function allows for the
simulation of multiple independent random walks in one, two, or three
dimensions, with user control over the number of walks, steps, trials,
probabilities, and dimensions. Sampling options allow for further
customization, including the ability to sample a proportion of steps and
to sample with or without replacement. The resulting data frame includes
cumulative statistics for each walk.

## Usage

``` r
random_multinomial_walk(
  .num_walks = 25,
  .n = 100,
  .size = 3,
  .prob = rep(1/3, .n),
  .initial_value = 0,
  .samp = TRUE,
  .replace = TRUE,
  .sample_size = 0.8,
  .dimensions = 1
)
```

## Arguments

- .num_walks:

  Integer. Number of random walks to generate. Default is 25.

- .n:

  Integer. Length of each walk (number of steps). Default is 100.

- .size:

  Integer. Number of trials for each multinomial draw. Default is 3.

- .prob:

  Numeric vector. Probabilities for each outcome. Default is rep(1/3,
  .n).

- .initial_value:

  Numeric. Starting value of the walk. Default is 0.

- .samp:

  Logical. Whether to sample the steps. Default is TRUE.

- .replace:

  Logical. Whether sampling is with replacement. Default is TRUE.

- .sample_size:

  Numeric. Proportion of steps to sample (0-1). Default is 0.8.

- .dimensions:

  Integer. Number of dimensions (1, 2, or 3). Default is 1.

## Value

A tibble containing the generated random walks with columns:

- `walk_number`: Factor representing the walk number.

- `step_number`: Step index.

- `value`: Value of the walk at each step.

- Cumulative statistics: cum_sum, cum_prod, cum_min, cum_max, cum_mean.

The following are also returned based upon how many dimensions there are
and could be any of x, y and or z:

- `cum_sum`: Cumulative sum of `dplyr::all_of(.dimensions)`.

- `cum_prod`: Cumulative product of `dplyr::all_of(.dimensions)`.

- `cum_min`: Cumulative minimum of `dplyr::all_of(.dimensions)`.

- `cum_max`: Cumulative maximum of `dplyr::all_of(.dimensions)`.

- `cum_mean`: Cumulative mean of `dplyr::all_of(.dimensions)`.

## Details

The `random_multinomial_walk` function generates multiple random walks
using the multinomial distribution via
[`stats::rmultinom()`](https://rdrr.io/r/stats/Multinom.html). Each walk
is a sequence of steps where each step is a random draw from the
multinomial distribution. The user can specify the number of walks,
steps, trials per step, and the probability vector. Sampling options
allow for further customization, including the ability to sample a
proportion of steps and to sample with or without replacement. The
resulting data frame includes cumulative statistics for each walk,
making it suitable for simulation studies and visualization.

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
[`random_geometric_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_geometric_walk.md),
[`random_hypergeometric_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_hypergeometric_walk.md),
[`random_logistic_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_logistic_walk.md),
[`random_lognormal_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_lognormal_walk.md),
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
[`random_geometric_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_geometric_walk.md),
[`random_hypergeometric_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_hypergeometric_walk.md),
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
random_multinomial_walk()
#> # A tibble: 2,000 × 8
#>    walk_number step_number     y cum_sum_y cum_prod_y cum_min_y cum_max_y
#>    <fct>             <int> <int>     <dbl>      <dbl>     <dbl>     <dbl>
#>  1 25                    1     0         0          0         0         0
#>  2 25                    2     0         0          0         0         0
#>  3 25                    3     0         0          0         0         0
#>  4 25                    4     0         0          0         0         0
#>  5 25                    5     0         0          0         0         0
#>  6 25                    6     0         0          0         0         0
#>  7 25                    7     1         1          0         0         1
#>  8 25                    8     0         1          0         0         1
#>  9 25                    9     0         1          0         0         1
#> 10 25                   10     0         1          0         0         1
#> # ℹ 1,990 more rows
#> # ℹ 1 more variable: cum_mean_y <dbl>

set.seed(123)
random_multinomial_walk(.dimensions = 3) |>
  head() |>
  t()
#>             [,1] [,2] [,3] [,4] [,5] [,6]
#> walk_number "25" "25" "25" "25" "25" "25"
#> step_number "1"  "2"  "3"  "4"  "5"  "6" 
#> x           "0"  "0"  "0"  "0"  "0"  "0" 
#> y           "0"  "0"  "0"  "0"  "0"  "0" 
#> z           "0"  "0"  "0"  "0"  "0"  "0" 
#> cum_sum_x   "0"  "0"  "0"  "0"  "0"  "0" 
#> cum_sum_y   "0"  "0"  "0"  "0"  "0"  "0" 
#> cum_sum_z   "0"  "0"  "0"  "0"  "0"  "0" 
#> cum_prod_x  "0"  "0"  "0"  "0"  "0"  "0" 
#> cum_prod_y  "0"  "0"  "0"  "0"  "0"  "0" 
#> cum_prod_z  "0"  "0"  "0"  "0"  "0"  "0" 
#> cum_min_x   "0"  "0"  "0"  "0"  "0"  "0" 
#> cum_min_y   "0"  "0"  "0"  "0"  "0"  "0" 
#> cum_min_z   "0"  "0"  "0"  "0"  "0"  "0" 
#> cum_max_x   "0"  "0"  "0"  "0"  "0"  "0" 
#> cum_max_y   "0"  "0"  "0"  "0"  "0"  "0" 
#> cum_max_z   "0"  "0"  "0"  "0"  "0"  "0" 
#> cum_mean_x  "0"  "0"  "0"  "0"  "0"  "0" 
#> cum_mean_y  "0"  "0"  "0"  "0"  "0"  "0" 
#> cum_mean_z  "0"  "0"  "0"  "0"  "0"  "0" 
```
