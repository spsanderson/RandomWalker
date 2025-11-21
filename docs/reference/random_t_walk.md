# Generate Multiple Random t-Distributed Walks in Multiple Dimensions

The `random_t_walk` function generates multiple random walks in 1, 2, or
3 dimensions. Each walk is a sequence of steps where each step is a
random draw from a t-distribution. The user can specify the number of
walks, the number of steps in each walk, and the degrees of freedom for
the t-distribution. The function also allows for sampling a proportion
of the steps and optionally sampling with replacement.

## Usage

``` r
random_t_walk(
  .num_walks = 25,
  .n = 100,
  .df = 5,
  .initial_value = 0,
  .ncp = 0,
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

- .df:

  Degrees of freedom for the t-distribution. Default is 5.

- .initial_value:

  A numeric value indicating the initial value of the walks. Default is
  0.

- .ncp:

  A numeric value for the non-centrality parameter for the
  t-distribution. Default is 0.

- .samp:

  A logical value indicating whether to sample the t-distribution
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
is drawn from a t-distribution. The user can control the number of
walks, steps per walk, degrees of freedom, and optionally the
non-centrality parameter (`ncp`). If `.ncp` is left blank, the function
uses the default behavior of
[`rt()`](https://rdrr.io/r/stats/TDist.html) from base R, which sets
`ncp = 0`. The function supports 1, 2, or 3 dimensions, and augments the
output with cumulative statistics for each walk. Sampling can be
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
[`random_normal_drift_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_normal_drift_walk.md),
[`random_normal_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_normal_walk.md),
[`random_uniform_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_uniform_walk.md),
[`random_weibull_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_weibull_walk.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
set.seed(123)
random_t_walk()
#> # A tibble: 2,000 × 8
#>    walk_number step_number       y cum_sum_y cum_prod_y cum_min_y cum_max_y
#>    <fct>             <int>   <dbl>     <dbl>      <dbl>     <dbl>     <dbl>
#>  1 1                     1  1.63       1.63           0     1.63       1.63
#>  2 1                     2 -0.201      1.43           0    -0.201      1.63
#>  3 1                     3 -1.18       0.243          0    -1.18       1.63
#>  4 1                     4 -1.56      -1.31           0    -1.56       1.63
#>  5 1                     5  1.49       0.176          0    -1.56       1.63
#>  6 1                     6  1.85       2.03           0    -1.56       1.85
#>  7 1                     7  0.849      2.87           0    -1.56       1.85
#>  8 1                     8 -0.0532     2.82           0    -1.56       1.85
#>  9 1                     9  0.819      3.64           0    -1.56       1.85
#> 10 1                    10 -0.186      3.45           0    -1.56       1.85
#> # ℹ 1,990 more rows
#> # ℹ 1 more variable: cum_mean_y <dbl>

set.seed(123)
random_t_walk(.dimensions = 3) |>
  head() |>
  t()
#>             [,1]          [,2]          [,3]          [,4]         
#> walk_number "1"           "1"           "1"           "1"          
#> step_number "1"           "2"           "3"           "4"          
#> x           " 1.6277162"  "-0.2008853"  "-1.1841513"  "-1.5574288" 
#> y           "-2.2621208"  "-2.7235161"  "-0.2551528"  " 1.1082730" 
#> z           " 1.2219381"  " 1.4370475"  "-1.6094411"  "-0.5404590" 
#> cum_sum_x   " 1.6277162"  " 1.4268309"  " 0.2426796"  "-1.3147493" 
#> cum_sum_y   "-2.262121"   "-4.985637"   "-5.240790"   "-4.132517"  
#> cum_sum_z   "1.2219381"   "2.6589856"   "1.0495445"   "0.5090855"  
#> cum_prod_x  "0"           "0"           "0"           "0"          
#> cum_prod_y  "0"           "0"           "0"           "0"          
#> cum_prod_z  "0"           "0"           "0"           "0"          
#> cum_min_x   " 1.6277162"  "-0.2008853"  "-1.1841513"  "-1.5574288" 
#> cum_min_y   "-2.262121"   "-2.723516"   "-2.723516"   "-2.723516"  
#> cum_min_z   " 1.221938"   " 1.221938"   "-1.609441"   "-1.609441"  
#> cum_max_x   "1.627716"    "1.627716"    "1.627716"    "1.627716"   
#> cum_max_y   "-2.2621208"  "-2.2621208"  "-0.2551528"  " 1.1082730" 
#> cum_max_z   "1.221938"    "1.437048"    "1.437048"    "1.437048"   
#> cum_mean_x  " 1.62771622" " 0.71341546" " 0.08089319" "-0.32868732"
#> cum_mean_y  "-2.262121"   "-2.492818"   "-1.746930"   "-1.033129"  
#> cum_mean_z  "1.22193807"  "1.32949281"  "0.34984816"  "0.12727137" 
#>             [,5]          [,6]         
#> walk_number "1"           "1"          
#> step_number "5"           "6"          
#> x           " 1.4908605"  " 1.8491933" 
#> y           "-1.7036063"  "-1.0350036" 
#> z           " 0.6329316"  "-0.6073508" 
#> cum_sum_x   " 0.1761113"  " 2.0253045" 
#> cum_sum_y   "-5.836123"   "-6.871127"  
#> cum_sum_z   "1.1420170"   "0.5346663"  
#> cum_prod_x  "0"           "0"          
#> cum_prod_y  "0"           "0"          
#> cum_prod_z  "0"           "0"          
#> cum_min_x   "-1.5574288"  "-1.5574288" 
#> cum_min_y   "-2.723516"   "-2.723516"  
#> cum_min_z   "-1.609441"   "-1.609441"  
#> cum_max_x   "1.627716"    "1.849193"   
#> cum_max_y   " 1.1082730"  " 1.1082730" 
#> cum_max_z   "1.437048"    "1.437048"   
#> cum_mean_x  " 0.03522225" " 0.33755076"
#> cum_mean_y  "-1.167225"   "-1.145188"  
#> cum_mean_z  "0.22840341"  "0.08911104" 
```
