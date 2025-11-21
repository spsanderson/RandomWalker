# Brownian Motion

Create a Brownian Motion Tibble

## Usage

``` r
brownian_motion(
  .num_walks = 25,
  .n = 100,
  .delta_time = 1,
  .initial_value = 0,
  .dimensions = 1
)
```

## Arguments

- .num_walks:

  Total number of simulations.

- .n:

  Total time of the simulation.

- .delta_time:

  Time step size.

- .initial_value:

  Integer representing the initial value.

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

Brownian Motion, also known as the Wiener process, is a continuous-time
random process that describes the random movement of particles suspended
in a fluid. It is named after the physicist Robert Brown, who first
described the phenomenon in 1827.

The equation for Brownian Motion can be represented as:

    W(t) = W(0) + sqrt(t) * Z

Where W(t) is the Brownian motion at time t, W(0) is the initial value
of the Brownian motion, sqrt(t) is the square root of time, and Z is a
standard normal random variable.

Brownian Motion has numerous applications, including modeling stock
prices in financial markets, modeling particle movement in fluids, and
modeling random walk processes in general. It is a useful tool in
probability theory and statistical analysis.

## See also

Other Generator Functions:
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
[`random_poisson_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_poisson_walk.md),
[`random_smirnov_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_smirnov_walk.md),
[`random_t_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_t_walk.md),
[`random_uniform_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_uniform_walk.md),
[`random_weibull_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_weibull_walk.md),
[`random_wilcox_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_wilcox_walk.md),
[`random_wilcoxon_sr_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_wilcoxon_sr_walk.md)

Other Continuous Distribution:
[`geometric_brownian_motion()`](https://www.spsanderson.com/RandomWalker/reference/geometric_brownian_motion.md),
[`random_beta_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_beta_walk.md),
[`random_cauchy_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_cauchy_walk.md),
[`random_chisquared_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_chisquared_walk.md),
[`random_exponential_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_exponential_walk.md),
[`random_f_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_f_walk.md),
[`random_gamma_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_gamma_walk.md),
[`random_logistic_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_logistic_walk.md),
[`random_lognormal_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_lognormal_walk.md),
[`random_normal_drift_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_normal_drift_walk.md),
[`random_normal_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_normal_walk.md),
[`random_t_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_t_walk.md),
[`random_uniform_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_uniform_walk.md),
[`random_weibull_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_weibull_walk.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
set.seed(123)
brownian_motion()
#> # A tibble: 2,500 × 8
#>    walk_number step_number       y cum_sum_y cum_prod_y cum_min_y cum_max_y
#>    <fct>             <int>   <dbl>     <dbl>      <dbl>     <dbl>     <dbl>
#>  1 1                     1 -0.560     -0.560          0    -0.560    -0.560
#>  2 1                     2 -0.230     -0.791          0    -0.560    -0.230
#>  3 1                     3  1.56       0.768          0    -0.560     1.56 
#>  4 1                     4  0.0705     0.839          0    -0.560     1.56 
#>  5 1                     5  0.129      0.968          0    -0.560     1.56 
#>  6 1                     6  1.72       2.68           0    -0.560     1.72 
#>  7 1                     7  0.461      3.14           0    -0.560     1.72 
#>  8 1                     8 -1.27       1.88           0    -1.27      1.72 
#>  9 1                     9 -0.687      1.19           0    -1.27      1.72 
#> 10 1                    10 -0.446      0.746          0    -1.27      1.72 
#> # ℹ 2,490 more rows
#> # ℹ 1 more variable: cum_mean_y <dbl>

set.seed(123)
brownian_motion(.dimensions = 3) |>
  head() |>
  t()
#>             [,1]          [,2]          [,3]          [,4]         
#> walk_number "1"           "1"           "1"           "1"          
#> step_number "1"           "2"           "3"           "4"          
#> x           "-0.56047565" "-0.23017749" " 1.55870831" " 0.07050839"
#> y           "-0.71040656" " 0.25688371" "-0.24669188" "-0.34754260"
#> z           " 2.1988103"  " 1.3124130"  "-0.2651451"  " 0.5431941" 
#> cum_sum_x   "-0.5604756"  "-0.7906531"  " 0.7680552"  " 0.8385636" 
#> cum_sum_y   "-0.7104066"  "-0.4535229"  "-0.7002147"  "-1.0477573" 
#> cum_sum_z   "2.198810"    "3.511223"    "3.246078"    "3.789272"   
#> cum_prod_x  "0"           "0"           "0"           "0"          
#> cum_prod_y  "0"           "0"           "0"           "0"          
#> cum_prod_z  "0"           "0"           "0"           "0"          
#> cum_min_x   "-0.5604756"  "-0.5604756"  "-0.5604756"  "-0.5604756" 
#> cum_min_y   "-0.7104066"  "-0.7104066"  "-0.7104066"  "-0.7104066" 
#> cum_min_z   " 2.1988103"  " 1.3124130"  "-0.2651451"  "-0.2651451" 
#> cum_max_x   "-0.5604756"  "-0.2301775"  " 1.5587083"  " 1.5587083" 
#> cum_max_y   "-0.7104066"  " 0.2568837"  " 0.2568837"  " 0.2568837" 
#> cum_max_z   "2.19881"     "2.19881"     "2.19881"     "2.19881"    
#> cum_mean_x  "-0.5604756"  "-0.3953266"  " 0.2560184"  " 0.2096409" 
#> cum_mean_y  "-0.7104066"  "-0.2267614"  "-0.2334049"  "-0.2619393" 
#> cum_mean_z  "2.1988103"   "1.7556117"   "1.0820261"   "0.9473181"  
#>             [,5]          [,6]         
#> walk_number "1"           "1"          
#> step_number "5"           "6"          
#> x           " 0.12928774" " 1.71506499"
#> y           "-0.95161857" "-0.04502772"
#> z           "-0.4143399"  "-0.4762469" 
#> cum_sum_x   " 0.9678513"  " 2.6829163" 
#> cum_sum_y   "-1.9993759"  "-2.0444036" 
#> cum_sum_z   "3.374932"    "2.898685"   
#> cum_prod_x  "0"           "0"          
#> cum_prod_y  "0"           "0"          
#> cum_prod_z  "0"           "0"          
#> cum_min_x   "-0.5604756"  "-0.5604756" 
#> cum_min_y   "-0.9516186"  "-0.9516186" 
#> cum_min_z   "-0.4143399"  "-0.4762469" 
#> cum_max_x   " 1.5587083"  " 1.7150650" 
#> cum_max_y   " 0.2568837"  " 0.2568837" 
#> cum_max_z   "2.19881"     "2.19881"    
#> cum_mean_x  " 0.1935703"  " 0.4471527" 
#> cum_mean_y  "-0.3998752"  "-0.3407339" 
#> cum_mean_z  "0.6749865"   "0.4831142"  
```
