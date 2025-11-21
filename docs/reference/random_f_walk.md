# Generate Multiple Random F Walks in Multiple Dimensions

The `random_f_walk` function generates multiple random walks in 1, 2, or
3 dimensions. Each walk is a sequence of steps where each step is a
random draw from an F distribution. The user can specify the number of
walks, the number of steps in each walk, and the parameters of the F
distribution (df1, df2, ncp). The function also allows for sampling a
proportion of the steps and optionally sampling with replacement.

## Usage

``` r
random_f_walk(
  .num_walks = 25,
  .n = 100,
  .df1 = 5,
  .df2 = 5,
  .ncp = NULL,
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

- .df1:

  Degrees of freedom 1 for the F distribution. Default is 5.

- .df2:

  Degrees of freedom 2 for the F distribution. Default is 5.

- .ncp:

  Non-centrality parameter. Default is NULL (central F).

- .initial_value:

  A numeric value indicating the initial value of the walks. Default is
  0.

- .samp:

  A logical value indicating whether to sample the F distribution
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
is drawn from an F distribution. The user can control the number of
walks, steps per walk, degrees of freedom (df1, df2), and optionally the
non-centrality parameter (`ncp`). If `.ncp` is left as NULL, the
function generates F values using the ratio of chi-squared distributions
as described in base R documentation. The function supports 1, 2, or 3
dimensions, and augments the output with cumulative statistics for each
walk. Sampling can be performed with or without replacement, and a
proportion of steps can be sampled if desired.

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
[`geometric_brownian_motion()`](https://www.spsanderson.com/RandomWalker/reference/geometric_brownian_motion.md),
[`random_beta_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_beta_walk.md),
[`random_cauchy_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_cauchy_walk.md),
[`random_chisquared_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_chisquared_walk.md),
[`random_exponential_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_exponential_walk.md),
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
random_f_walk()
#> # A tibble: 2,000 × 8
#>    walk_number step_number      y cum_sum_y cum_prod_y cum_min_y cum_max_y
#>    <fct>             <int>  <dbl>     <dbl>      <dbl>     <dbl>     <dbl>
#>  1 1                     1 0.0883    0.0883          0    0.0883    0.0883
#>  2 1                     2 1.05      1.14            0    0.0883    1.05  
#>  3 1                     3 0.646     1.78            0    0.0883    1.05  
#>  4 1                     4 0.713     2.50            0    0.0883    1.05  
#>  5 1                     5 3.35      5.84            0    0.0883    3.35  
#>  6 1                     6 5.57     11.4             0    0.0883    5.57  
#>  7 1                     7 0.672    12.1             0    0.0883    5.57  
#>  8 1                     8 1.64     13.7             0    0.0883    5.57  
#>  9 1                     9 1.10     14.8             0    0.0883    5.57  
#> 10 1                    10 1.93     16.8             0    0.0883    5.57  
#> # ℹ 1,990 more rows
#> # ℹ 1 more variable: cum_mean_y <dbl>

set.seed(123)
random_f_walk(.dimensions = 3) |>
  head() |>
  t()
#>             [,1]         [,2]         [,3]         [,4]         [,5]        
#> walk_number "1"          "1"          "1"          "1"          "1"         
#> step_number "1"          "2"          "3"          "4"          "5"         
#> x           "0.0883253"  "1.0496683"  "0.6458774"  "0.7125566"  "3.3457817" 
#> y           "0.6773043"  "0.3860944"  "0.5132422"  "1.2349983"  "1.3562964" 
#> z           "2.2560923"  "2.6302610"  "2.2560923"  "0.1960185"  "0.2801917" 
#> cum_sum_x   " 0.0883253" " 1.1379936" " 1.7838709" " 2.4964275" " 5.8422092"
#> cum_sum_y   "0.6773043"  "1.0633987"  "1.5766409"  "2.8116392"  "4.1679356" 
#> cum_sum_z   "2.256092"   "4.886353"   "7.142446"   "7.338464"   "7.618656"  
#> cum_prod_x  "0"          "0"          "0"          "0"          "0"         
#> cum_prod_y  "0"          "0"          "0"          "0"          "0"         
#> cum_prod_z  "0"          "0"          "0"          "0"          "0"         
#> cum_min_x   "0.0883253"  "0.0883253"  "0.0883253"  "0.0883253"  "0.0883253" 
#> cum_min_y   "0.6773043"  "0.3860944"  "0.3860944"  "0.3860944"  "0.3860944" 
#> cum_min_z   "2.2560923"  "2.2560923"  "2.2560923"  "0.1960185"  "0.1960185" 
#> cum_max_x   "0.0883253"  "1.0496683"  "1.0496683"  "1.0496683"  "3.3457817" 
#> cum_max_y   "0.6773043"  "0.6773043"  "0.6773043"  "1.2349983"  "1.3562964" 
#> cum_max_z   "2.256092"   "2.630261"   "2.630261"   "2.630261"   "2.630261"  
#> cum_mean_x  "0.0883253"  "0.5689968"  "0.5946236"  "0.6241069"  "1.1684418" 
#> cum_mean_y  "0.6773043"  "0.5316993"  "0.5255470"  "0.7029098"  "0.8335871" 
#> cum_mean_z  "2.256092"   "2.443177"   "2.380815"   "1.834616"   "1.523731"  
#>             [,6]        
#> walk_number "1"         
#> step_number "6"         
#> x           "5.5738147" 
#> y           "0.4892022" 
#> z           "0.7969134" 
#> cum_sum_x   "11.4160239"
#> cum_sum_y   "4.6571378" 
#> cum_sum_z   "8.415569"  
#> cum_prod_x  "0"         
#> cum_prod_y  "0"         
#> cum_prod_z  "0"         
#> cum_min_x   "0.0883253" 
#> cum_min_y   "0.3860944" 
#> cum_min_z   "0.1960185" 
#> cum_max_x   "5.5738147" 
#> cum_max_y   "1.3562964" 
#> cum_max_z   "2.630261"  
#> cum_mean_x  "1.9026707" 
#> cum_mean_y  "0.7761896" 
#> cum_mean_z  "1.402595"  
```
