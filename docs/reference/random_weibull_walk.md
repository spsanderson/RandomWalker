# Generate Multiple Random Weibull Walks in Multiple Dimensions

A Weibull random walk is a stochastic process in which each step is
drawn from the Weibull distribution, a flexible distribution commonly
used to model lifetimes, reliability, and extreme values. This function
allows for the simulation of multiple independent random walks in one,
two, or three dimensions, with user control over the number of walks,
steps, and the shape and scale parameters of the Weibull distribution.
Sampling options allow for further customization, including the ability
to sample a proportion of steps and to sample with or without
replacement. The resulting data frame includes cumulative statistics for
each walk, making it suitable for simulation studies and visualization.

## Usage

``` r
random_weibull_walk(
  .num_walks = 25,
  .n = 100,
  .shape = 1,
  .scale = 1,
  .initial_value = 0,
  .samp = TRUE,
  .replace = TRUE,
  .sample_size = 0.8,
  .dimensions = 1
)
```

## Arguments

- .num_walks:

  Integer. Number of walks to generate. Default is 25.

- .n:

  Integer. Number of steps in each walk. Default is 100.

- .shape:

  Numeric. Shape parameter of the Weibull distribution. Default is 1.

- .scale:

  Numeric. Scale parameter of the Weibull distribution. Default is 1.

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

A data frame with the random walks and cumulative statistics as columns.

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

The `random_weibull_walk` function generates multiple random walks in 1,
2, or 3 dimensions. Each walk is a sequence of steps where each step is
a random draw from the Weibull distribution using
[`stats::rweibull()`](https://rdrr.io/r/stats/Weibull.html). The user
can specify the number of walks, the number of steps in each walk, and
the parameters `.shape` and `.scale` for the Weibull distribution. The
function also allows for sampling a proportion of the steps and
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
[`random_poisson_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_poisson_walk.md),
[`random_smirnov_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_smirnov_walk.md),
[`random_t_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_t_walk.md),
[`random_uniform_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_uniform_walk.md),
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
[`random_normal_drift_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_normal_drift_walk.md),
[`random_normal_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_normal_walk.md),
[`random_t_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_t_walk.md),
[`random_uniform_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_uniform_walk.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
set.seed(123)
random_weibull_walk()
#> # A tibble: 2,000 × 8
#>    walk_number step_number      y cum_sum_y cum_prod_y cum_min_y cum_max_y
#>    <fct>             <int>  <dbl>     <dbl>      <dbl>     <dbl>     <dbl>
#>  1 1                     1 0.422      0.422          0    0.422      0.422
#>  2 1                     2 0.816      1.24           0    0.422      0.816
#>  3 1                     3 0.367      1.61           0    0.367      0.816
#>  4 1                     4 0.121      1.73           0    0.121      0.816
#>  5 1                     5 0.103      1.83           0    0.103      0.816
#>  6 1                     6 0.422      2.25           0    0.103      0.816
#>  7 1                     7 0.0152     2.27           0    0.0152     0.816
#>  8 1                     8 3.70       5.97           0    0.0152     3.70 
#>  9 1                     9 1.46       7.43           0    0.0152     3.70 
#> 10 1                    10 1.92       9.35           0    0.0152     3.70 
#> # ℹ 1,990 more rows
#> # ℹ 1 more variable: cum_mean_y <dbl>

set.seed(123)
random_weibull_walk(.dimensions = 3) |>
   head() |>
   t()
#>             [,1]         [,2]         [,3]         [,4]         [,5]        
#> walk_number "1"          "1"          "1"          "1"          "1"         
#> step_number "1"          "2"          "3"          "4"          "5"         
#> x           "0.4220431"  "0.8159928"  "0.3670090"  "0.1205091"  "0.1028093" 
#> y           "2.84802700" "0.61234101" "0.08808446" "0.48069865" "2.90718840"
#> z           "1.02706319" "0.55112373" "7.67272276" "1.53631719" "0.05063955"
#> cum_sum_x   "0.4220431"  "1.2380359"  "1.6050449"  "1.7255540"  "1.8283632" 
#> cum_prod_x  "0"          "0"          "0"          "0"          "0"         
#> cum_min_x   "0.4220431"  "0.4220431"  "0.3670090"  "0.1205091"  "0.1028093" 
#> cum_max_x   "0.4220431"  "0.8159928"  "0.8159928"  "0.8159928"  "0.8159928" 
#> cum_mean_x  "0.4220431"  "0.6190180"  "0.5350150"  "0.4313885"  "0.3656726" 
#> cum_sum_y   "2.848027"   "3.460368"   "3.548452"   "4.029151"   "6.936340"  
#> cum_prod_y  "0"          "0"          "0"          "0"          "0"         
#> cum_min_y   "2.84802700" "0.61234101" "0.08808446" "0.08808446" "0.08808446"
#> cum_max_y   "2.848027"   "2.848027"   "2.848027"   "2.848027"   "2.907188"  
#> cum_mean_y  "2.848027"   "1.730184"   "1.182817"   "1.007288"   "1.387268"  
#> cum_sum_z   " 1.027063"  " 1.578187"  " 9.250910"  "10.787227"  "10.837866" 
#> cum_prod_z  "0"          "0"          "0"          "0"          "0"         
#> cum_min_z   "1.02706319" "0.55112373" "0.55112373" "0.55112373" "0.05063955"
#> cum_max_z   "1.027063"   "1.027063"   "7.672723"   "7.672723"   "7.672723"  
#> cum_mean_z  "1.0270632"  "0.7890935"  "3.0836366"  "2.6968067"  "2.1675733" 
#>             [,6]        
#> walk_number "1"         
#> step_number "6"         
#> x           "0.4220431" 
#> y           "0.72972278"
#> z           "0.20846750"
#> cum_sum_x   "2.2504063" 
#> cum_prod_x  "0"         
#> cum_min_x   "0.1028093" 
#> cum_max_x   "0.8159928" 
#> cum_mean_x  "0.3750677" 
#> cum_sum_y   "7.666062"  
#> cum_prod_y  "0"         
#> cum_min_y   "0.08808446"
#> cum_max_y   "2.907188"  
#> cum_mean_y  "1.277677"  
#> cum_sum_z   "11.046334" 
#> cum_prod_z  "0"         
#> cum_min_z   "0.05063955"
#> cum_max_z   "7.672723"  
#> cum_mean_z  "1.8410557" 
```
