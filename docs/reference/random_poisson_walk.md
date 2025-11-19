# Generate Multiple Random Poisson Walks

A Poisson random walk is a stochastic process in which each step is
drawn from the Poisson distribution, commonly used for modeling count
data. This function allows for the simulation of multiple independent
random walks in one, two, or three dimensions, with user control over
the number of walks, steps, and the lambda parameter for the
distribution. Sampling options allow for further customization,
including the ability to sample a proportion of steps and to sample with
or without replacement. The resulting data frame includes cumulative
statistics for each walk, making it suitable for simulation studies and
visualization.

## Usage

``` r
random_poisson_walk(
  .num_walks = 25,
  .n = 100,
  .lambda = 1,
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

  Integer. Number of random variables to return for each walk. Default
  is 100.

- .lambda:

  Numeric or vector. Mean(s) for the Poisson distribution. Default is 1.

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

## Details

The `random_poisson_walk` function generates multiple random walks in 1,
2, or 3 dimensions. Each walk is a sequence of steps where each step is
a random draw from the Poisson distribution using `base::rpois()`. The
user can specify the number of samples in each walk (`n`), the lambda
parameter for the Poisson distribution, and the number of dimensions.
The function also allows for sampling a proportion of the steps and
optionally sampling with replacement.

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
[`random_multinomial_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_multinomial_walk.md),
[`random_negbinomial_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_negbinomial_walk.md),
[`random_normal_drift_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_normal_drift_walk.md),
[`random_normal_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_normal_walk.md),
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
[`random_multinomial_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_multinomial_walk.md),
[`random_negbinomial_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_negbinomial_walk.md),
[`random_smirnov_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_smirnov_walk.md),
[`random_wilcox_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_wilcox_walk.md),
[`random_wilcoxon_sr_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_wilcoxon_sr_walk.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
set.seed(123)
random_poisson_walk()
#> # A tibble: 2,000 × 8
#>    walk_number step_number     y cum_sum_y cum_prod_y cum_min_y cum_max_y
#>    <fct>             <int> <int>     <dbl>      <dbl>     <dbl>     <dbl>
#>  1 1                     1     1         1          0         1         1
#>  2 1                     2     1         2          0         1         1
#>  3 1                     3     1         3          0         1         1
#>  4 1                     4     2         5          0         1         2
#>  5 1                     5     2         7          0         1         2
#>  6 1                     6     1         8          0         1         2
#>  7 1                     7     4        12          0         1         4
#>  8 1                     8     0        12          0         0         4
#>  9 1                     9     0        12          0         0         4
#> 10 1                    10     0        12          0         0         4
#> # ℹ 1,990 more rows
#> # ℹ 1 more variable: cum_mean_y <dbl>

set.seed(123)
random_poisson_walk(.dimensions = 3, .lambda = c(1, 2, 3)) |>
   head() |>
   t()
#>             [,1]       [,2]       [,3]       [,4]       [,5]       [,6]      
#> walk_number "1"        "1"        "1"        "1"        "1"        "1"       
#> step_number "1"        "2"        "3"        "4"        "5"        "6"       
#> x           "1"        "1"        "1"        "4"        "4"        "1"       
#> y           "1"        "2"        "4"        "3"        "0"        "1"       
#> z           "2"        "3"        "0"        "2"        "3"        "3"       
#> cum_sum_x   " 1"       " 2"       " 3"       " 7"       "11"       "12"      
#> cum_prod_x  "0"        "0"        "0"        "0"        "0"        "0"       
#> cum_min_x   "1"        "1"        "1"        "1"        "1"        "1"       
#> cum_max_x   "1"        "1"        "1"        "4"        "4"        "4"       
#> cum_mean_x  "1.00"     "1.00"     "1.00"     "1.75"     "2.20"     "2.00"    
#> cum_sum_y   " 1"       " 3"       " 7"       "10"       "10"       "11"      
#> cum_prod_y  "0"        "0"        "0"        "0"        "0"        "0"       
#> cum_min_y   "1"        "1"        "1"        "1"        "0"        "0"       
#> cum_max_y   "1"        "2"        "4"        "4"        "4"        "4"       
#> cum_mean_y  "1.000000" "1.500000" "2.333333" "2.500000" "2.000000" "1.833333"
#> cum_sum_z   " 2"       " 5"       " 5"       " 7"       "10"       "13"      
#> cum_prod_z  "0"        "0"        "0"        "0"        "0"        "0"       
#> cum_min_z   "2"        "2"        "0"        "0"        "0"        "0"       
#> cum_max_z   "2"        "3"        "3"        "3"        "3"        "3"       
#> cum_mean_z  "2.000000" "2.500000" "1.666667" "1.750000" "2.000000" "2.166667"
```
