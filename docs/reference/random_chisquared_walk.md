# Generate Multiple Random Chi-Squared Walks in Multiple Dimensions

The `random_chisquared_walk` function generates multiple random walks in
1, 2, or 3 dimensions. Each walk is a sequence of steps where each step
is a random draw from a chi-squared distribution. The user can specify
the number of walks, the number of steps in each walk, and the
parameters of the chi-squared distribution (df and ncp). The function
also allows for sampling a proportion of the steps and optionally
sampling with replacement.

## Usage

``` r
random_chisquared_walk(
  .num_walks = 25,
  .n = 100,
  .df = 5,
  .ncp = 0,
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

- .df:

  Degrees of freedom for the chi-squared distribution. Default is 5.

- .ncp:

  Non-centrality parameter (non-negative). Default is 0.

- .initial_value:

  A numeric value indicating the initial value of the walks. Default is
  0.

- .samp:

  A logical value indicating whether to sample the chi-squared
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
is drawn from a chi-squared distribution. The user can control the
number of walks, steps per walk, degrees of freedom (`df`), and the
non-centrality parameter (`ncp`). The function supports 1, 2, or 3
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
[`geometric_brownian_motion()`](https://www.spsanderson.com/RandomWalker/reference/geometric_brownian_motion.md),
[`random_beta_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_beta_walk.md),
[`random_cauchy_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_cauchy_walk.md),
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
random_chisquared_walk()
#> # A tibble: 2,000 × 8
#>    walk_number step_number     y cum_sum_y cum_prod_y cum_min_y cum_max_y
#>    <fct>             <int> <dbl>     <dbl>      <dbl>     <dbl>     <dbl>
#>  1 1                     1  5.08      5.08          0      5.08      5.08
#>  2 1                     2  5.49     10.6           0      5.08      5.49
#>  3 1                     3  2.74     13.3           0      2.74      5.49
#>  4 1                     4  8.02     21.3           0      2.74      8.02
#>  5 1                     5  8.21     29.5           0      2.74      8.21
#>  6 1                     6  1.22     30.8           0      1.22      8.21
#>  7 1                     7  1.22     32.0           0      1.22      8.21
#>  8 1                     8  2.25     34.2           0      1.22      8.21
#>  9 1                     9  1.29     35.5           0      1.22      8.21
#> 10 1                    10  2.42     37.9           0      1.22      8.21
#> # ℹ 1,990 more rows
#> # ℹ 1 more variable: cum_mean_y <dbl>

set.seed(123)
random_chisquared_walk(.dimensions = 3) |>
  head() |>
  t()
#>             [,1]        [,2]        [,3]        [,4]        [,5]       
#> walk_number "1"         "1"         "1"         "1"         "1"        
#> step_number "1"         "2"         "3"         "4"         "5"        
#> x           "5.082440"  "5.491392"  "2.736640"  "8.018600"  "8.211414" 
#> y           " 6.251703" " 2.808596" "10.032219" " 2.673512" " 7.037088"
#> z           "4.398359"  "4.509466"  "4.602653"  "5.202429"  "2.000208" 
#> cum_sum_x   " 5.08244"  "10.57383"  "13.31047"  "21.32907"  "29.54049" 
#> cum_sum_y   " 6.251703" " 9.060299" "19.092518" "21.766030" "28.803118"
#> cum_sum_z   " 4.398359" " 8.907825" "13.510477" "18.712907" "20.713115"
#> cum_prod_x  "0"         "0"         "0"         "0"         "0"        
#> cum_prod_y  "0"         "0"         "0"         "0"         "0"        
#> cum_prod_z  "0"         "0"         "0"         "0"         "0"        
#> cum_min_x   "5.082440"  "5.082440"  "2.736640"  "2.736640"  "2.736640" 
#> cum_min_y   "6.251703"  "2.808596"  "2.808596"  "2.673512"  "2.673512" 
#> cum_min_z   "4.398359"  "4.398359"  "4.398359"  "4.398359"  "2.000208" 
#> cum_max_x   "5.082440"  "5.491392"  "5.491392"  "8.018600"  "8.211414" 
#> cum_max_y   " 6.251703" " 6.251703" "10.032219" "10.032219" "10.032219"
#> cum_max_z   "4.398359"  "4.509466"  "4.602653"  "5.202429"  "5.202429" 
#> cum_mean_x  "5.082440"  "5.286916"  "4.436824"  "5.332268"  "5.908097" 
#> cum_mean_y  "6.251703"  "4.530150"  "6.364173"  "5.441508"  "5.760624" 
#> cum_mean_z  "4.398359"  "4.453912"  "4.503492"  "4.678227"  "4.142623" 
#>             [,6]       
#> walk_number "1"        
#> step_number "6"        
#> x           "1.222056" 
#> y           " 5.917235"
#> z           "2.784157" 
#> cum_sum_x   "30.76254" 
#> cum_sum_y   "34.720353"
#> cum_sum_z   "23.497272"
#> cum_prod_x  "0"        
#> cum_prod_y  "0"        
#> cum_prod_z  "0"        
#> cum_min_x   "1.222056" 
#> cum_min_y   "2.673512" 
#> cum_min_z   "2.000208" 
#> cum_max_x   "8.211414" 
#> cum_max_y   "10.032219"
#> cum_max_z   "5.202429" 
#> cum_mean_x  "5.127091" 
#> cum_mean_y  "5.786726" 
#> cum_mean_z  "3.916212" 
```
