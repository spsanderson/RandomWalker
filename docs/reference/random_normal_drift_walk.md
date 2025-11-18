# Generate Multiple Random Walks with Drift

This function generates a specified number of random walks, each
consisting of a specified number of steps. The steps are generated from
a normal distribution with a given mean and standard deviation. An
additional drift term is added to each step to introduce a consistent
directional component to the walks.

## Usage

``` r
random_normal_drift_walk(
  .num_walks = 25,
  .n = 100,
  .mu = 0,
  .sd = 1,
  .drift = 0.1,
  .initial_value = 0,
  .dimensions = 1
)
```

## Arguments

- .num_walks:

  Integer. The number of random walks to generate. Default is 25.

- .n:

  Integer. The number of steps in each random walk. Default is 100.

- .mu:

  Numeric. The mean of the normal distribution used for generating
  steps. Default is 0.

- .sd:

  Numeric. The standard deviation of the normal distribution used for
  generating steps. Default is 1.

- .drift:

  Numeric. The drift term to be added to each step. Default is 0.1.

- .initial_value:

  A numeric value indicating the initial value of the walks. Default is
  0.

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

This function generates multiple random walks with a specified drift.
Each walk is generated using a normal distribution for the steps, with
an additional drift term added to each step.

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
[`geometric_brownian_motion()`](https://www.spsanderson.com/RandomWalker/reference/geometric_brownian_motion.md),
[`random_beta_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_beta_walk.md),
[`random_cauchy_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_cauchy_walk.md),
[`random_chisquared_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_chisquared_walk.md),
[`random_exponential_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_exponential_walk.md),
[`random_f_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_f_walk.md),
[`random_gamma_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_gamma_walk.md),
[`random_logistic_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_logistic_walk.md),
[`random_lognormal_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_lognormal_walk.md),
[`random_normal_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_normal_walk.md),
[`random_t_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_t_walk.md),
[`random_uniform_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_uniform_walk.md),
[`random_weibull_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_weibull_walk.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
set.seed(123)
random_normal_drift_walk()
#> # A tibble: 2,500 × 8
#>    walk_number step_number      y cum_sum_y cum_prod_y cum_min_y cum_max_y
#>    <fct>             <int>  <dbl>     <dbl>      <dbl>     <dbl>     <dbl>
#>  1 1                     1 -1.02     -1.02           0     -1.02    -1.02 
#>  2 1                     2 -0.821    -1.84           0     -1.02    -0.821
#>  3 1                     3  2.63      0.785          0     -1.02     2.63 
#>  4 1                     4  1.31      2.09           0     -1.02     2.63 
#>  5 1                     5  1.60      3.69           0     -1.02     2.63 
#>  6 1                     6  5.00      8.69           0     -1.02     5.00 
#>  7 1                     7  4.30     13.0            0     -1.02     5.00 
#>  8 1                     8  1.41     14.4            0     -1.02     5.00 
#>  9 1                     9  1.41     15.8            0     -1.02     5.00 
#> 10 1                    10  1.30     17.1            0     -1.02     5.00 
#> # ℹ 2,490 more rows
#> # ℹ 1 more variable: cum_mean_y <dbl>

set.seed(123)
random_normal_drift_walk(.dimensions = 3) |>
  head() |>
  t()
#>             [,1]           [,2]           [,3]           [,4]          
#> walk_number "1"            "1"            "1"            "1"           
#> step_number "1"            "2"            "3"            "4"           
#> x           "-1.0209513"   "-0.8208306"   " 2.6267635"   " 1.3090720"  
#> y           "-1.320813127" " 0.003360855" "-0.646906611" "-0.995299932"
#> z           "4.497621"     "5.023636"     "3.280933"     "4.732466"    
#> cum_sum_x   "-1.0209513"   "-1.8417819"   " 0.7849816"   " 2.0940535"  
#> cum_sum_y   "-1.320813"    "-1.317452"    "-1.964359"    "-2.959659"   
#> cum_sum_z   " 4.497621"    " 9.521257"    "12.802190"    "17.534657"   
#> cum_prod_x  "0"            "0"            "0"            "0"           
#> cum_prod_y  "0"            "0"            "0"            "0"           
#> cum_prod_z  "0"            "0"            "0"            "0"           
#> cum_min_x   "-1.020951"    "-1.020951"    "-1.020951"    "-1.020951"   
#> cum_min_y   "-1.320813"    "-1.320813"    "-1.320813"    "-1.320813"   
#> cum_min_z   "4.497621"     "4.497621"     "3.280933"     "3.280933"    
#> cum_max_x   "-1.0209513"   "-0.8208306"   " 2.6267635"   " 2.6267635"  
#> cum_max_y   "-1.320813127" " 0.003360855" " 0.003360855" " 0.003360855"
#> cum_max_z   "4.497621"     "5.023636"     "5.023636"     "5.023636"    
#> cum_mean_x  "-1.0209513"   "-0.9208910"   " 0.2616605"   " 0.5235134"  
#> cum_mean_y  "-1.3208131"   "-0.6587261"   "-0.6547863"   "-0.7399147"  
#> cum_mean_z  "4.497621"     "4.760628"     "4.267397"     "4.383664"    
#>             [,5]           [,6]          
#> walk_number "1"            "1"           
#> step_number "5"            "6"           
#> x           " 1.5971390"   " 4.9979813"  
#> y           "-2.450994467" "-1.489431349"
#> z           "3.460592"     "3.022439"    
#> cum_sum_x   " 3.6911926"   " 8.6891739"  
#> cum_sum_y   "-5.410653"    "-6.900085"   
#> cum_sum_z   "20.995249"    "24.017688"   
#> cum_prod_x  "0"            "0"           
#> cum_prod_y  "0"            "0"           
#> cum_prod_z  "0"            "0"           
#> cum_min_x   "-1.020951"    "-1.020951"   
#> cum_min_y   "-2.450994"    "-2.450994"   
#> cum_min_z   "3.280933"     "3.022439"    
#> cum_max_x   " 2.6267635"   " 4.9979813"  
#> cum_max_y   " 0.003360855" " 0.003360855"
#> cum_max_z   "5.023636"     "5.023636"    
#> cum_mean_x  " 0.7382385"   " 1.4481956"  
#> cum_mean_y  "-1.0821307"   "-1.1500141"  
#> cum_mean_z  "4.199050"     "4.002948"    
```
