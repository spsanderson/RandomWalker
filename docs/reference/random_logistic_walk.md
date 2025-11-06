# Generate Multiple Random Logistic Walks in Multiple Dimensions

The `random_logistic_walk` function generates multiple random walks in
1, 2, or 3 dimensions. Each walk is a sequence of steps where each step
is a random draw from a logistic distribution. The user can specify the
number of walks, the number of steps in each walk, and the parameters of
the logistic distribution (location and scale). The function also allows
for sampling a proportion of the steps and optionally sampling with
replacement.

## Usage

``` r
random_logistic_walk(
  .num_walks = 25,
  .n = 100,
  .location = 0,
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

  An integer specifying the number of random walks to generate. Default
  is 25.

- .n:

  An integer specifying the number of steps in each walk. Default is
  100.

- .location:

  A numeric value indicating the location parameter of the logistic
  distribution. Default is 0.

- .scale:

  A numeric value indicating the scale parameter of the logistic
  distribution. Default is 1.

- .initial_value:

  A numeric value indicating the initial value of the walks. Default is
  0.

- .samp:

  A logical value indicating whether to sample the logistic distribution
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
is drawn from a logistic distribution. The user can control the number
of walks, steps per walk, and the location and scale parameters for the
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
[`random_gamma_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_gamma_walk.md),
[`random_geometric_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_geometric_walk.md),
[`random_hypergeometric_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_hypergeometric_walk.md),
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
[`random_gamma_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_gamma_walk.md),
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
random_logistic_walk()
#> # A tibble: 2,000 × 8
#>    walk_number step_number      y cum_sum_y cum_prod_y cum_min_y cum_max_y
#>    <fct>             <int>  <dbl>     <dbl>      <dbl>     <dbl>     <dbl>
#>  1 1                     1  0.644     0.644          0     0.644     0.644
#>  2 1                     2 -0.232     0.412          0    -0.232     0.644
#>  3 1                     3  0.813     1.23           0    -0.232     0.813
#>  4 1                     4  2.06      3.28           0    -0.232     2.06 
#>  5 1                     5  2.22      5.50           0    -0.232     2.22 
#>  6 1                     6  0.644     6.15           0    -0.232     2.22 
#>  7 1                     7  4.18     10.3            0    -0.232     4.18 
#>  8 1                     8 -3.68      6.65           0    -3.68      4.18 
#>  9 1                     9 -1.20      5.45           0    -3.68      4.18 
#> 10 1                    10 -1.76      3.69           0    -3.68      4.18 
#> # ℹ 1,990 more rows
#> # ℹ 1 more variable: cum_mean_y <dbl>

set.seed(123)
random_logistic_walk(.dimensions = 2) |>
  head() |>
  t()
#>             [,1]          [,2]          [,3]          [,4]         
#> walk_number "1"           "1"           "1"           "1"          
#> step_number "1"           "2"           "3"           "4"          
#> x           " 0.6442157"  "-0.2322379"  " 0.8132584"  " 2.0551708" 
#> y           "-2.78832098" " 0.16872058" " 2.38509370" " 0.48255588"
#> cum_sum_x   "0.6442157"   "0.4119778"   "1.2252361"   "3.2804070"  
#> cum_prod_x  "0"           "0"           "0"           "0"          
#> cum_min_x   " 0.6442157"  "-0.2322379"  "-0.2322379"  "-0.2322379" 
#> cum_max_x   "0.6442157"   "0.6442157"   "0.8132584"   "2.0551708"  
#> cum_mean_x  "0.6442157"   "0.2059889"   "0.4084120"   "0.8201017"  
#> cum_sum_y   "-2.7883210"  "-2.6196004"  "-0.2345067"  " 0.2480492" 
#> cum_prod_y  "0"           "0"           "0"           "0"          
#> cum_min_y   "-2.788321"   "-2.788321"   "-2.788321"   "-2.788321"  
#> cum_max_y   "-2.7883210"  " 0.1687206"  " 2.3850937"  " 2.3850937" 
#> cum_mean_y  "-2.78832098" "-1.30980020" "-0.07816890" " 0.06201229"
#>             [,5]          [,6]         
#> walk_number "1"           "1"          
#> step_number "5"           "6"          
#> x           " 2.2230347"  " 0.6442157" 
#> y           "-2.85101045" "-0.07186049"
#> cum_sum_x   "5.5034416"   "6.1476573"  
#> cum_prod_x  "0"           "0"          
#> cum_min_x   "-0.2322379"  "-0.2322379" 
#> cum_max_x   "2.2230347"   "2.2230347"  
#> cum_mean_x  "1.1006883"   "1.0246096"  
#> cum_sum_y   "-2.6029613"  "-2.6748218" 
#> cum_prod_y  "0"           "0"          
#> cum_min_y   "-2.851010"   "-2.851010"  
#> cum_max_y   " 2.3850937"  " 2.3850937" 
#> cum_mean_y  "-0.52059226" "-0.44580363"
```
