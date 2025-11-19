# Generate Multiple Random Gamma Walks in Multiple Dimensions

The `random_gamma_walk` function generates multiple random walks in 1,
2, or 3 dimensions. Each walk is a sequence of steps where each step is
a random draw from a gamma distribution. The user can specify the number
of walks, the number of steps in each walk, and the parameters of the
gamma distribution (shape, scale, rate). The function also allows for
sampling a proportion of the steps and optionally sampling with
replacement.

## Usage

``` r
random_gamma_walk(
  .num_walks = 25,
  .n = 100,
  .shape = 1,
  .scale = 1,
  .rate = NULL,
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

  An integer specifying the number of steps in each walk. Must be
  greater than 0. Default is 100.

- .shape:

  A positive numeric value for the shape parameter. Default is 1.

- .scale:

  A positive numeric value for the scale parameter. Default is 1.

- .rate:

  A positive numeric value for the rate parameter. Default is NULL
  (ignored if scale is provided).

- .initial_value:

  A numeric value indicating the initial value of the walks. Default is
  0.

- .samp:

  A logical value indicating whether to sample the gamma distribution
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
is drawn from a gamma distribution. The user can control the number of
walks, steps per walk, and the shape, scale, and rate parameters for the
distribution. The function supports 1, 2, or 3 dimensions, and augments
the output with cumulative statistics for each walk. Sampling can be
performed with or without replacement, and a proportion of steps can be
sampled if desired.

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
[`geometric_brownian_motion()`](https://www.spsanderson.com/RandomWalker/reference/geometric_brownian_motion.md),
[`random_beta_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_beta_walk.md),
[`random_cauchy_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_cauchy_walk.md),
[`random_chisquared_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_chisquared_walk.md),
[`random_exponential_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_exponential_walk.md),
[`random_f_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_f_walk.md),
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
random_gamma_walk()
#> # A tibble: 2,000 × 8
#>    walk_number step_number       y cum_sum_y cum_prod_y cum_min_y cum_max_y
#>    <fct>             <int>   <dbl>     <dbl>      <dbl>     <dbl>     <dbl>
#>  1 1                     1 0.0696     0.0696          0   0.0696     0.0696
#>  2 1                     2 0.272      0.342           0   0.0696     0.272 
#>  3 1                     3 0.391      0.733           0   0.0696     0.391 
#>  4 1                     4 0.0334     0.766           0   0.0334     0.391 
#>  5 1                     5 0.00936    0.775           0   0.00936    0.391 
#>  6 1                     6 0.0997     0.875           0   0.00936    0.391 
#>  7 1                     7 0.871      1.75            0   0.00936    0.871 
#>  8 1                     8 0.914      2.66            0   0.00936    0.914 
#>  9 1                     9 0.457      3.12            0   0.00936    0.914 
#> 10 1                    10 0.496      3.61            0   0.00936    0.914 
#> # ℹ 1,990 more rows
#> # ℹ 1 more variable: cum_mean_y <dbl>

set.seed(123)
random_gamma_walk(.dimensions = 3) |>
  head() |>
  t()
#>             [,1]          [,2]          [,3]          [,4]         
#> walk_number "1"           "1"           "1"           "1"          
#> step_number "1"           "2"           "3"           "4"          
#> x           "0.069637100" "0.272250993" "0.390801641" "0.033364752"
#> y           "0.3304056"   "1.5928129"   "0.1615043"   "4.7770780"  
#> z           "0.04561730"  "0.98273360"  "1.66341244"  "0.01161989" 
#> cum_sum_x   "0.0696371"   "0.3418881"   "0.7326897"   "0.7660545"  
#> cum_prod_x  "0"           "0"           "0"           "0"          
#> cum_min_x   "0.069637100" "0.069637100" "0.069637100" "0.033364752"
#> cum_max_x   "0.0696371"   "0.2722510"   "0.3908016"   "0.3908016"  
#> cum_mean_x  "0.0696371"   "0.1709440"   "0.2442299"   "0.1915136"  
#> cum_sum_y   "0.3304056"   "1.9232185"   "2.0847228"   "6.8618008"  
#> cum_prod_y  "0"           "0"           "0"           "0"          
#> cum_min_y   "0.3304056"   "0.3304056"   "0.1615043"   "0.1615043"  
#> cum_max_y   "0.3304056"   "1.5928129"   "1.5928129"   "4.7770780"  
#> cum_mean_y  "0.3304056"   "0.9616092"   "0.6949076"   "1.7154502"  
#> cum_sum_z   "0.0456173"   "1.0283509"   "2.6917633"   "2.7033832"  
#> cum_prod_z  "0"           "0"           "0"           "0"          
#> cum_min_z   "0.04561730"  "0.04561730"  "0.04561730"  "0.01161989" 
#> cum_max_z   "0.0456173"   "0.9827336"   "1.6634124"   "1.6634124"  
#> cum_mean_z  "0.0456173"   "0.5141755"   "0.8972544"   "0.6758458"  
#>             [,5]          [,6]         
#> walk_number "1"           "1"          
#> step_number "5"           "6"          
#> x           "0.009360161" "0.099692785"
#> y           "0.1763265"   "0.5176001"  
#> z           "1.11430547"  "0.36010340" 
#> cum_sum_x   "0.7754146"   "0.8751074"  
#> cum_prod_x  "0"           "0"          
#> cum_min_x   "0.009360161" "0.009360161"
#> cum_max_x   "0.3908016"   "0.3908016"  
#> cum_mean_x  "0.1550829"   "0.1458512"  
#> cum_sum_y   "7.0381272"   "7.5557273"  
#> cum_prod_y  "0"           "0"          
#> cum_min_y   "0.1615043"   "0.1615043"  
#> cum_max_y   "4.7770780"   "4.7770780"  
#> cum_mean_y  "1.4076254"   "1.2592879"  
#> cum_sum_z   "3.8176887"   "4.1777921"  
#> cum_prod_z  "0"           "0"          
#> cum_min_z   "0.01161989"  "0.01161989" 
#> cum_max_z   "1.6634124"   "1.6634124"  
#> cum_mean_z  "0.7635377"   "0.6962987"  
```
