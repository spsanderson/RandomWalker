# Discrete Sampled Walk

The `discrete_walk` function generates multiple random walks over
discrete time periods. Each step in the walk is determined by a
probabilistic sample from specified upper and lower bounds. This
function is useful for simulating stochastic processes, such as stock
price movements or other scenarios where outcomes are determined by a
random process.

## Usage

``` r
discrete_walk(
  .num_walks = 25,
  .n = 100,
  .upper_bound = 1,
  .lower_bound = -1,
  .upper_probability = 0.5,
  .initial_value = 100,
  .dimensions = 1
)
```

## Arguments

- .num_walks:

  Total number of simulations.

- .n:

  Total time of the simulation.

- .upper_bound:

  The upper bound of the random walk.

- .lower_bound:

  The lower bound of the random walk.

- .upper_probability:

  The probability of the upper bound. Default is 0.5. The lower bound is
  calculated as 1 - .upper_probability.

- .initial_value:

  The initial value of the random walk. Default is 100.

- .dimensions:

  The default is 1. Allowable values are 1, 2 and 3.

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

The function `discrete_walk` simulates random walks for a specified
number of simulations (`.num_walks`) over a given total time (`.n`).
Each step in the walk is either the upper bound or the lower bound,
determined by a probability (`.upper_probability`). The initial value of
the walk is set by the user (`.initial_value`), and the cumulative sum,
product, minimum, and maximum of the steps are calculated for each walk.
The results are returned in a tibble with detailed attributes, including
the parameters used for the simulation.

## See also

Other Generator Functions:
[`brownian_motion()`](https://www.spsanderson.com/RandomWalker/reference/brownian_motion.md),
[`custom_walk()`](https://www.spsanderson.com/RandomWalker/reference/custom_walk.md),
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
[`random_poisson_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_poisson_walk.md),
[`random_smirnov_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_smirnov_walk.md),
[`random_t_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_t_walk.md),
[`random_uniform_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_uniform_walk.md),
[`random_weibull_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_weibull_walk.md),
[`random_wilcox_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_wilcox_walk.md),
[`random_wilcoxon_sr_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_wilcoxon_sr_walk.md)

Other Discrete Distribution:
[`random_binomial_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_binomial_walk.md),
[`random_displacement_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_displacement_walk.md),
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
set.seed(123)
discrete_walk()
#> # A tibble: 2,500 × 8
#>    walk_number step_number     y cum_sum_y cum_prod_y cum_min_y cum_max_y
#>    <fct>             <int> <dbl>     <dbl>      <dbl>     <dbl>     <dbl>
#>  1 1                     1    -1        99          0        99        99
#>  2 1                     2     1       100          0        99       101
#>  3 1                     3    -1        99          0        99       101
#>  4 1                     4     1       100          0        99       101
#>  5 1                     5     1       101          0        99       101
#>  6 1                     6    -1       100          0        99       101
#>  7 1                     7     1       101          0        99       101
#>  8 1                     8     1       102          0        99       101
#>  9 1                     9     1       103          0        99       101
#> 10 1                    10    -1       102          0        99       101
#> # ℹ 2,490 more rows
#> # ℹ 1 more variable: cum_mean_y <dbl>

set.seed(123)
discrete_walk(.dimensions = 3) |>
  head() |>
  t()
#>             [,1]        [,2]        [,3]        [,4]        [,5]       
#> walk_number "1"         "1"         "1"         "1"         "1"        
#> step_number "1"         "2"         "3"         "4"         "5"        
#> x           "-1"        " 1"        "-1"        " 1"        " 1"       
#> y           " 1"        "-1"        "-1"        " 1"        "-1"       
#> z           "-1"        " 1"        " 1"        " 1"        "-1"       
#> cum_sum_x   " 99"       "100"       " 99"       "100"       "101"      
#> cum_sum_y   "101"       "100"       " 99"       "100"       " 99"      
#> cum_sum_z   " 99"       "100"       "101"       "102"       "101"      
#> cum_prod_x  "0"         "0"         "0"         "0"         "0"        
#> cum_prod_y  "200"       "  0"       "  0"       "  0"       "  0"      
#> cum_prod_z  "0"         "0"         "0"         "0"         "0"        
#> cum_min_x   "99"        "99"        "99"        "99"        "99"       
#> cum_min_y   "101"       " 99"       " 99"       " 99"       " 99"      
#> cum_min_z   "99"        "99"        "99"        "99"        "99"       
#> cum_max_x   " 99"       "101"       "101"       "101"       "101"      
#> cum_max_y   "101"       "101"       "101"       "101"       "101"      
#> cum_max_z   " 99"       "101"       "101"       "101"       "101"      
#> cum_mean_x  " 99.00000" "100.00000" " 99.66667" "100.00000" "100.20000"
#> cum_mean_y  "101.00000" "100.00000" " 99.66667" "100.00000" " 99.80000"
#> cum_mean_z  " 99.0000"  "100.0000"  "100.3333"  "100.5000"  "100.2000" 
#>             [,6]       
#> walk_number "1"        
#> step_number "6"        
#> x           "-1"       
#> y           " 1"       
#> z           " 1"       
#> cum_sum_x   "100"      
#> cum_sum_y   "100"      
#> cum_sum_z   "102"      
#> cum_prod_x  "0"        
#> cum_prod_y  "  0"      
#> cum_prod_z  "0"        
#> cum_min_x   "99"       
#> cum_min_y   " 99"      
#> cum_min_z   "99"       
#> cum_max_x   "101"      
#> cum_max_y   "101"      
#> cum_max_z   "101"      
#> cum_mean_x  "100.00000"
#> cum_mean_y  "100.00000"
#> cum_mean_z  "100.3333" 
```
