# Generate Multiple Random Uniform Walks in Multiple Dimensions

The `random_uniform_walk` function generates multiple random walks in 1,
2, or 3 dimensions. Each walk is a sequence of steps where each step is
a random draw from a uniform distribution. The user can specify the
number of walks, the number of steps in each walk, and the parameters of
the uniform distribution (min and max). The function also allows for
sampling a proportion of the steps and optionally sampling with
replacement.

## Usage

``` r
random_uniform_walk(
  .num_walks = 25,
  .n = 100,
  .min = 0,
  .max = 1,
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

  An integer specifying the number of steps in each walk. Default is
  100.

- .min:

  A numeric value indicating the minimum of the uniform distribution.
  Default is 0.

- .max:

  A numeric value indicating the maximum of the uniform distribution.
  Default is 1.

- .initial_value:

  A numeric value indicating the initial value of the walks. Default is
  0.

- .samp:

  A logical value indicating whether to sample the uniform distribution
  values. Default is TRUE.

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

This function is a flexible generator for random walks where each step
is drawn from a uniform distribution. The user can control the number of
walks, steps per walk, and the minimum and maximum values for the
uniform distribution. The function supports 1, 2, or 3 dimensions, and
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
[`random_normal_drift_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_normal_drift_walk.md),
[`random_normal_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_normal_walk.md),
[`random_t_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_t_walk.md),
[`random_weibull_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_weibull_walk.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
set.seed(123)
random_uniform_walk()
#> # A tibble: 2,000 × 8
#>    walk_number step_number      y cum_sum_y cum_prod_y cum_min_y cum_max_y
#>    <fct>             <int>  <dbl>     <dbl>      <dbl>     <dbl>     <dbl>
#>  1 1                     1 0.656      0.656          0    0.656      0.656
#>  2 1                     2 0.442      1.10           0    0.442      0.656
#>  3 1                     3 0.693      1.79           0    0.442      0.693
#>  4 1                     4 0.886      2.68           0    0.442      0.886
#>  5 1                     5 0.902      3.58           0    0.442      0.902
#>  6 1                     6 0.656      4.24           0    0.442      0.902
#>  7 1                     7 0.985      5.22           0    0.442      0.985
#>  8 1                     8 0.0246     5.24           0    0.0246     0.985
#>  9 1                     9 0.232      5.48           0    0.0246     0.985
#> 10 1                    10 0.147      5.62           0    0.0246     0.985
#> # ℹ 1,990 more rows
#> # ℹ 1 more variable: cum_mean_y <dbl>

set.seed(123)
random_uniform_walk(.dimensions = 3) |>
  head() |>
  t()
#>             [,1]           [,2]           [,3]           [,4]          
#> walk_number "1"            "1"            "1"            "1"           
#> step_number "1"            "2"            "3"            "4"           
#> x           "0.6557058"    "0.4422001"    "0.6928034"    "0.8864691"   
#> y           "0.05795856"   "0.54208037"   "0.91568354"   "0.61835123"  
#> z           "0.3580569634" "0.5763018376" "0.0004653491" "0.2151720827"
#> cum_sum_x   "0.6557058"    "1.0979059"    "1.7907093"    "2.6771783"   
#> cum_prod_x  "0"            "0"            "0"            "0"           
#> cum_min_x   "0.6557058"    "0.4422001"    "0.4422001"    "0.4422001"   
#> cum_max_x   "0.6557058"    "0.6557058"    "0.6928034"    "0.8864691"   
#> cum_mean_x  "0.6557058"    "0.5489529"    "0.5969031"    "0.6692946"   
#> cum_sum_y   "0.05795856"   "0.60003893"   "1.51572247"   "2.13407369"  
#> cum_prod_y  "0"            "0"            "0"            "0"           
#> cum_min_y   "0.05795856"   "0.05795856"   "0.05795856"   "0.05795856"  
#> cum_max_y   "0.05795856"   "0.54208037"   "0.91568354"   "0.91568354"  
#> cum_mean_y  "0.05795856"   "0.30001946"   "0.50524082"   "0.53351842"  
#> cum_sum_z   "0.3580570"    "0.9343588"    "0.9348242"    "1.1499962"   
#> cum_prod_z  "0"            "0"            "0"            "0"           
#> cum_min_z   "0.3580569634" "0.3580569634" "0.0004653491" "0.0004653491"
#> cum_max_z   "0.3580570"    "0.5763018"    "0.5763018"    "0.5763018"   
#> cum_mean_z  "0.3580570"    "0.4671794"    "0.3116081"    "0.2874991"   
#>             [,5]           [,6]          
#> walk_number "1"            "1"           
#> step_number "5"            "6"           
#> x           "0.9022990"    "0.6557058"   
#> y           "0.05462911"   "0.48204261"  
#> z           "0.9506212641" "0.8118274161"
#> cum_sum_x   "3.5794774"    "4.2351832"   
#> cum_prod_x  "0"            "0"           
#> cum_min_x   "0.4422001"    "0.4422001"   
#> cum_max_x   "0.9022990"    "0.9022990"   
#> cum_mean_x  "0.7158955"    "0.7058639"   
#> cum_sum_y   "2.18870280"   "2.67074541"  
#> cum_prod_y  "0"            "0"           
#> cum_min_y   "0.05462911"   "0.05462911"  
#> cum_max_y   "0.91568354"   "0.91568354"  
#> cum_mean_y  "0.43774056"   "0.44512423"  
#> cum_sum_z   "2.1006175"    "2.9124449"   
#> cum_prod_z  "0"            "0"           
#> cum_min_z   "0.0004653491" "0.0004653491"
#> cum_max_z   "0.9506213"    "0.9506213"   
#> cum_mean_z  "0.4201235"    "0.4854075"   
```
