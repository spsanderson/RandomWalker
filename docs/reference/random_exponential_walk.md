# Generate Multiple Random Exponential Walks in Multiple Dimensions

The `random_exponential_walk` function generates multiple random walks
in 1, 2, or 3 dimensions. Each walk is a sequence of steps where each
step is a random draw from an exponential distribution.

## Usage

``` r
random_exponential_walk(
  .num_walks = 25,
  .n = 100,
  .rate = 1,
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

  An integer specifying the number of steps in each walk. Must be \>= 1.
  Default is 100.

- .rate:

  A numeric value or vector indicating the rate parameter(s) of the
  exponential distribution. Default is 1.

- .initial_value:

  A numeric value indicating the initial value of the walks. Default is
  0.

- .samp:

  A logical value indicating whether to sample the exponential
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

The `rate` parameter can be a single value or a vector of length equal
to the number of dimensions. If a vector is provided, each dimension
uses its corresponding rate.

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
[`random_chisquared_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_chisquared_walk.md),
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
random_exponential_walk()
#> # A tibble: 2,000 × 8
#>    walk_number step_number     y cum_sum_y cum_prod_y cum_min_y cum_max_y
#>    <fct>             <int> <dbl>     <dbl>      <dbl>     <dbl>     <dbl>
#>  1 1                     1 1.35       1.35          0     1.35       1.35
#>  2 1                     2 0.507      1.85          0     0.507      1.35
#>  3 1                     3 0.843      2.70          0     0.507      1.35
#>  4 1                     4 0.975      3.67          0     0.507      1.35
#>  5 1                     5 0.380      4.05          0     0.380      1.35
#>  6 1                     6 0.791      4.84          0     0.380      1.35
#>  7 1                     7 4.50       9.34          0     0.380      4.50
#>  8 1                     8 1.46      10.8           0     0.380      4.50
#>  9 1                     9 0.589     11.4           0     0.380      4.50
#> 10 1                    10 0.314     11.7           0     0.314      4.50
#> # ℹ 1,990 more rows
#> # ℹ 1 more variable: cum_mean_y <dbl>

set.seed(123)
random_exponential_walk(.dimensions = 3, .rate = c(0.1, 0.1, 0.2)) |>
  head() |>
  t()
#>             [,1]         [,2]         [,3]         [,4]         [,5]        
#> walk_number "1"          "1"          "1"          "1"          "1"         
#> step_number "1"          "2"          "3"          "4"          "5"         
#> x           "13.480445"  " 5.066157"  " 8.431497"  " 9.746402"  " 3.800142" 
#> y           "22.2990710" " 0.5155942" " 6.9884174" "12.4596584" " 0.6865056"
#> z           "4.4760881"  "1.6670516"  "8.5325075"  "9.5378353"  "5.0188816" 
#> cum_sum_x   "13.48044"   "18.54660"   "26.97810"   "36.72450"   "40.52464"  
#> cum_prod_x  "0"          "0"          "0"          "0"          "0"         
#> cum_min_x   "13.480445"  " 5.066157"  " 5.066157"  " 5.066157"  " 3.800142" 
#> cum_max_x   "13.48044"   "13.48044"   "13.48044"   "13.48044"   "13.48044"  
#> cum_mean_x  "13.480445"  " 9.273301"  " 8.992700"  " 9.181125"  " 8.104929" 
#> cum_sum_y   "22.29907"   "22.81467"   "29.80308"   "42.26274"   "42.94925"  
#> cum_prod_y  "0"          "0"          "0"          "0"          "0"         
#> cum_min_y   "22.2990710" " 0.5155942" " 0.5155942" " 0.5155942" " 0.5155942"
#> cum_max_y   "22.29907"   "22.29907"   "22.29907"   "22.29907"   "22.29907"  
#> cum_mean_y  "22.299071"  "11.407333"  " 9.934361"  "10.565685"  " 8.589849" 
#> cum_sum_z   " 4.476088"  " 6.143140"  "14.675647"  "24.213483"  "29.232364" 
#> cum_prod_z  "0"          "0"          "0"          "0"          "0"         
#> cum_min_z   "4.4760881"  "1.6670516"  "1.6670516"  "1.6670516"  "1.6670516" 
#> cum_max_z   "4.476088"   "4.476088"   "8.532507"   "9.537835"   "9.537835"  
#> cum_mean_z  "4.476088"   "3.071570"   "4.891882"   "6.053371"   "5.846473"  
#>             [,6]        
#> walk_number "1"         
#> step_number "6"         
#> x           " 7.906818" 
#> y           " 4.7559481"
#> z           "0.9383849" 
#> cum_sum_x   "48.43146"  
#> cum_prod_x  "0"         
#> cum_min_x   " 3.800142" 
#> cum_max_x   "13.48044"  
#> cum_mean_x  " 8.071910" 
#> cum_sum_y   "47.70519"  
#> cum_prod_y  "0"         
#> cum_min_y   " 0.5155942"
#> cum_max_y   "22.29907"  
#> cum_mean_y  " 7.950866" 
#> cum_sum_z   "30.170749" 
#> cum_prod_z  "0"         
#> cum_min_z   "0.9383849" 
#> cum_max_z   "9.537835"  
#> cum_mean_z  "5.028458"  
```
