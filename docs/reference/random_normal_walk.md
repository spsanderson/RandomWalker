# Generate Multiple Random Normal Walks in Multiple Dimensions

The `random_normal_walk` function generates multiple random walks in 1,
2, or 3 dimensions. Each walk is a sequence of steps where each step is
a random draw from a normal distribution. The user can specify the
number of walks, the number of steps in each walk, and the parameters of
the normal distribution (mean and standard deviation). The function also
allows for sampling a proportion of the steps and optionally sampling
with replacement.

## Usage

``` r
random_normal_walk(
  .num_walks = 25,
  .n = 100,
  .mu = 0,
  .sd = 0.1,
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

- .mu:

  A numeric value indicating the mean of the normal distribution.
  Default is 0.

- .sd:

  A numeric value indicating the standard deviation of the normal
  distribution. Default is 0.1.

- .initial_value:

  A numeric value indicating the initial value of the walks. Default is
  0.

- .samp:

  A logical value indicating whether to sample the normal distribution
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
[`random_normal_drift_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_normal_drift_walk.md),
[`random_t_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_t_walk.md),
[`random_uniform_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_uniform_walk.md),
[`random_weibull_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_weibull_walk.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
set.seed(123)
random_normal_walk()
#> # A tibble: 2,000 × 8
#>    walk_number step_number       y cum_sum_y cum_prod_y cum_min_y cum_max_y
#>    <fct>             <int>   <dbl>     <dbl>      <dbl>     <dbl>     <dbl>
#>  1 1                     1  0.125     0.125           0    0.125      0.125
#>  2 1                     2 -0.0628    0.0626          0   -0.0628     0.125
#>  3 1                     3 -0.0326    0.0300          0   -0.0628     0.125
#>  4 1                     4  0.179     0.209           0   -0.0628     0.179
#>  5 1                     5  0.0435    0.252           0   -0.0628     0.179
#>  6 1                     6  0.137     0.389           0   -0.0628     0.179
#>  7 1                     7 -0.0688    0.320           0   -0.0688     0.179
#>  8 1                     8 -0.0467    0.274           0   -0.0688     0.179
#>  9 1                     9 -0.0473    0.226           0   -0.0688     0.179
#> 10 1                    10  0.0448    0.271           0   -0.0688     0.179
#> # ℹ 1,990 more rows
#> # ℹ 1 more variable: cum_mean_y <dbl>

set.seed(123)
random_normal_walk(.dimensions = 3) |>
  head() |>
  t()
#>             [,1]           [,2]           [,3]           [,4]          
#> walk_number "1"            "1"            "1"            "1"           
#> step_number "1"            "2"            "3"            "4"           
#> x           " 0.12538149"  "-0.06279061"  "-0.03259316"  " 0.17869131" 
#> y           " 0.06365697"  "-0.02153805"  " 0.01192452"  "-0.01194526" 
#> z           "-0.12586486"  " 0.13785701"  "-0.19927485"  " 0.09590054" 
#> cum_sum_x   "0.12538149"   "0.06259088"   "0.02999773"   "0.20868904"  
#> cum_prod_x  "0"            "0"            "0"            "0"           
#> cum_min_x   " 0.12538149"  "-0.06279061"  "-0.06279061"  "-0.06279061" 
#> cum_max_x   "0.1253815"    "0.1253815"    "0.1253815"    "0.1786913"   
#> cum_mean_x  "0.125381492"  "0.031295442"  "0.009999242"  "0.052172260" 
#> cum_sum_y   " 0.06365697"  " 0.04211892"  " 0.05404344"  " 0.04209818" 
#> cum_prod_y  "0"            "0"            "0"            "0"           
#> cum_min_y   " 0.06365697"  "-0.02153805"  "-0.02153805"  "-0.02153805" 
#> cum_max_y   "0.06365697"   "0.06365697"   "0.06365697"   "0.06365697"  
#> cum_mean_y  " 0.063656967" " 0.021059458" " 0.018014480" " 0.010524545"
#> cum_sum_z   "-0.12586486"  " 0.01199215"  "-0.18728270"  "-0.09138216" 
#> cum_prod_z  "0"            "0"            "0"            "0"           
#> cum_min_z   "-0.1258649"   "-0.1258649"   "-0.1992748"   "-0.1992748"  
#> cum_max_z   "-0.1258649"   " 0.1378570"   " 0.1378570"   " 0.1378570"  
#> cum_mean_z  "-0.125864863" " 0.005996075" "-0.062427566" "-0.022845540"
#>             [,5]           [,6]          
#> walk_number "1"            "1"           
#> step_number "5"            "6"           
#> x           " 0.04351815"  " 0.13686023" 
#> y           "-0.06647694"  "-0.02362796" 
#> z           " 0.03461036"  "-0.02007810" 
#> cum_sum_x   "0.25220719"   "0.38906742"  
#> cum_prod_x  "0"            "0"           
#> cum_min_x   "-0.06279061"  "-0.06279061" 
#> cum_max_x   "0.1786913"    "0.1786913"   
#> cum_mean_x  "0.050441438"  "0.064844570" 
#> cum_sum_y   "-0.02437876"  "-0.04800672" 
#> cum_prod_y  "0"            "0"           
#> cum_min_y   "-0.06647694"  "-0.06647694" 
#> cum_max_y   "0.06365697"   "0.06365697"  
#> cum_mean_y  "-0.004875753" "-0.008001120"
#> cum_sum_z   "-0.05677180"  "-0.07684990" 
#> cum_prod_z  "0"            "0"           
#> cum_min_z   "-0.1992748"   "-0.1992748"  
#> cum_max_z   " 0.1378570"   " 0.1378570"  
#> cum_mean_z  "-0.011354360" "-0.012808317"
```
