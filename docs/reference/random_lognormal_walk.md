# Generate Multiple Random Lognormal Walks in Multiple Dimensions

The `random_lognormal_walk` function generates multiple random walks in
1, 2, or 3 dimensions. Each walk is a sequence of steps where each step
is a random draw from a lognormal distribution. The user can specify the
number of walks, the number of steps in each walk, and the parameters of
the lognormal distribution (meanlog and sdlog). The function also allows
for sampling a proportion of the steps and optionally sampling with
replacement.

## Usage

``` r
random_lognormal_walk(
  .num_walks = 25,
  .n = 100,
  .meanlog = 0,
  .sdlog = 1,
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

- .meanlog:

  A numeric value indicating the meanlog parameter of the lognormal
  distribution. Default is 0.

- .sdlog:

  A numeric value indicating the sdlog parameter of the lognormal
  distribution. Default is 1.

- .initial_value:

  A numeric value indicating the initial value of the walks. Default is
  0.

- .samp:

  A logical value indicating whether to sample the lognormal
  distribution values. Default is TRUE.

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
is drawn from a lognormal distribution. The user can control the number
of walks, steps per walk, and the meanlog and sdlog parameters for the
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
[`random_logistic_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_logistic_walk.md),
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
[`random_logistic_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_logistic_walk.md),
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
random_lognormal_walk()
#> # A tibble: 2,000 × 8
#>    walk_number step_number     y cum_sum_y cum_prod_y cum_min_y cum_max_y
#>    <fct>             <int> <dbl>     <dbl>      <dbl>     <dbl>     <dbl>
#>  1 1                     1 3.50       3.50          0     3.50       3.50
#>  2 1                     2 0.534      4.04          0     0.534      3.50
#>  3 1                     3 0.722      4.76          0     0.534      3.50
#>  4 1                     4 5.97      10.7           0     0.534      5.97
#>  5 1                     5 1.55      12.3           0     0.534      5.97
#>  6 1                     6 3.93      16.2           0     0.534      5.97
#>  7 1                     7 0.503     16.7           0     0.503      5.97
#>  8 1                     8 0.627     17.3           0     0.503      5.97
#>  9 1                     9 0.623     18.0           0     0.503      5.97
#> 10 1                    10 1.57      19.5           0     0.503      5.97
#> # ℹ 1,990 more rows
#> # ℹ 1 more variable: cum_mean_y <dbl>

set.seed(123)
random_lognormal_walk(.dimensions = 2) |>
  head() |>
  t()
#>             [,1]        [,2]        [,3]        [,4]        [,5]       
#> walk_number "1"         "1"         "1"         "1"         "1"        
#> step_number "1"         "2"         "3"         "4"         "5"        
#> x           "3.5036838" "0.5337082" "0.7218546" "5.9709924" "1.5452435"
#> y           "1.8899865" "0.8062346" "1.1266462" "0.8874061" "0.5143921"
#> cum_sum_x   " 3.503684" " 4.037392" " 4.759247" "10.730239" "12.275482"
#> cum_prod_x  "0"         "0"         "0"         "0"         "0"        
#> cum_min_x   "3.5036838" "0.5337082" "0.5337082" "0.5337082" "0.5337082"
#> cum_max_x   "3.503684"  "3.503684"  "3.503684"  "5.970992"  "5.970992" 
#> cum_mean_x  "3.503684"  "2.018696"  "1.586416"  "2.682560"  "2.455096" 
#> cum_sum_y   "1.889986"  "2.696221"  "3.822867"  "4.710273"  "5.224665" 
#> cum_prod_y  "0"         "0"         "0"         "0"         "0"        
#> cum_min_y   "1.8899865" "0.8062346" "0.8062346" "0.8062346" "0.5143921"
#> cum_max_y   "1.889986"  "1.889986"  "1.889986"  "1.889986"  "1.889986" 
#> cum_mean_y  "1.889986"  "1.348111"  "1.274289"  "1.177568"  "1.044933" 
#>             [,6]       
#> walk_number "1"        
#> step_number "6"        
#> x           "3.9298540"
#> y           "0.7895599"
#> cum_sum_x   "16.205336"
#> cum_prod_x  "0"        
#> cum_min_x   "0.5337082"
#> cum_max_x   "5.970992" 
#> cum_mean_x  "2.700889" 
#> cum_sum_y   "6.014225" 
#> cum_prod_y  "0"        
#> cum_min_y   "0.5143921"
#> cum_max_y   "1.889986" 
#> cum_mean_y  "1.002371" 
```
