# Geometric Brownian Motion

Create a Geometric Brownian Motion.

## Usage

``` r
geometric_brownian_motion(
  .num_walks = 25,
  .n = 100,
  .mu = 0,
  .sigma = 0.1,
  .initial_value = 100,
  .delta_time = 0.003,
  .dimensions = 1
)
```

## Arguments

- .num_walks:

  Total number of simulations.

- .n:

  Total time of the simulation, how many `n` points in time.

- .mu:

  Expected return

- .sigma:

  Volatility

- .initial_value:

  Integer representing the initial value.

- .delta_time:

  Time step size.

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

Geometric Brownian Motion (GBM) is a statistical method for modeling the
evolution of a given financial asset over time. It is a type of
stochastic process, which means that it is a system that undergoes
random changes over time.

GBM is widely used in the field of finance to model the behavior of
stock prices, foreign exchange rates, and other financial assets. It is
based on the assumption that the asset's price follows a random walk,
meaning that it is influenced by a number of unpredictable factors such
as market trends, news events, and investor sentiment.

The equation for GBM is:

     dS/S = mdt + sdW

where S is the price of the asset, t is time, m is the expected return
on the asset, s is the volatility of the asset, and dW is a small random
change in the asset's price.

GBM can be used to estimate the likelihood of different outcomes for a
given asset, and it is often used in conjunction with other statistical
methods to make more accurate predictions about the future performance
of an asset.

This function provides the ability of simulating and estimating the
parameters of a GBM process. It can be used to analyze the behavior of
financial assets and to make informed investment decisions.

## See also

Other Generator Functions:
[`brownian_motion()`](https://www.spsanderson.com/RandomWalker/reference/brownian_motion.md),
[`custom_walk()`](https://www.spsanderson.com/RandomWalker/reference/custom_walk.md),
[`discrete_walk()`](https://www.spsanderson.com/RandomWalker/reference/discrete_walk.md),
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
[`brownian_motion()`](https://www.spsanderson.com/RandomWalker/reference/brownian_motion.md),
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
geometric_brownian_motion()
#> # A tibble: 2,500 × 8
#>    walk_number step_number     y cum_sum_y cum_prod_y cum_min_y cum_max_y
#>    <fct>             <int> <dbl>     <dbl>      <dbl>     <dbl>     <dbl>
#>  1 1                     1 0.997      101.       200.      101.      101.
#>  2 1                     2 0.996      102.       399.      101.      101.
#>  3 1                     3 1.00       103.       799.      101.      101.
#>  4 1                     4 1.00       104.      1601.      101.      101.
#>  5 1                     5 1.01       105.      3210.      101.      101.
#>  6 1                     6 1.01       106.      6468.      101.      101.
#>  7 1                     7 1.02       107.     13048.      101.      101.
#>  8 1                     8 1.01       108.     26229.      101.      101.
#>  9 1                     9 1.01       109.     52626.      101.      101.
#> 10 1                    10 1.00       110.    105460.      101.      101.
#> # ℹ 2,490 more rows
#> # ℹ 1 more variable: cum_mean_y <dbl>

set.seed(123)
geometric_brownian_motion(.dimensions = 3) |>
  head() |>
  t()
#>             [,1]        [,2]        [,3]        [,4]        [,5]       
#> walk_number "1"         "1"         "1"         "1"         "1"        
#> step_number "1"         "2"         "3"         "4"         "5"        
#> x           "0.9969199" "0.9956489" "1.0041705" "1.0045433" "1.0052398"
#> y           "0.9961016" "0.9974891" "0.9961273" "0.9942180" "0.9890345"
#> z           "1.012101"  "1.019387"  "1.017893"  "1.020910"  "1.018581" 
#> cum_sum_x   "100.9969"  "101.9926"  "102.9967"  "104.0013"  "105.0065" 
#> cum_prod_x  " 199.6920" " 398.5151" " 798.6922" "1601.0131" "3210.4152"
#> cum_min_x   "100.9969"  "100.9956"  "100.9956"  "100.9956"  "100.9956" 
#> cum_max_x   "100.9969"  "100.9969"  "101.0042"  "101.0045"  "101.0052" 
#> cum_mean_x  "100.9969"  "100.9963"  "100.9989"  "101.0003"  "101.0013" 
#> cum_sum_y   "100.9961"  "101.9936"  "102.9897"  "103.9839"  "104.9730" 
#> cum_prod_y  " 199.6102" " 398.7191" " 795.8941" "1587.1863" "3156.9684"
#> cum_min_y   "100.9961"  "100.9961"  "100.9961"  "100.9942"  "100.9890" 
#> cum_max_y   "100.9961"  "100.9975"  "100.9975"  "100.9975"  "100.9975" 
#> cum_mean_y  "100.9961"  "100.9968"  "100.9966"  "100.9960"  "100.9946" 
#> cum_sum_z   "101.0121"  "102.0315"  "103.0494"  "104.0703"  "105.0889" 
#> cum_prod_z  " 201.2101" " 406.3211" " 819.9124" "1656.9695" "3344.7267"
#> cum_min_z   "101.0121"  "101.0121"  "101.0121"  "101.0121"  "101.0121" 
#> cum_max_z   "101.0121"  "101.0194"  "101.0194"  "101.0209"  "101.0209" 
#> cum_mean_z  "101.0121"  "101.0157"  "101.0165"  "101.0176"  "101.0178" 
#>             [,6]       
#> walk_number "1"        
#> step_number "6"        
#> x           "1.0147121"
#> y           "0.9887758"
#> z           "1.015912" 
#> cum_sum_x   "106.0212" 
#> cum_prod_x  "6468.0624"
#> cum_min_x   "100.9956" 
#> cum_max_x   "101.0147" 
#> cum_mean_x  "101.0035" 
#> cum_sum_y   "105.9617" 
#> cum_prod_y  "6278.5024"
#> cum_min_y   "100.9888" 
#> cum_max_y   "100.9975" 
#> cum_mean_y  "100.9936" 
#> cum_sum_z   "106.1048" 
#> cum_prod_z  "6742.6749"
#> cum_min_z   "101.0121" 
#> cum_max_z   "101.0209" 
#> cum_mean_z  "101.0175" 
```
