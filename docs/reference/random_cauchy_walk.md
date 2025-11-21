# Generate Multiple Random Cauchy Walks in Multiple Dimensions

The `random_cauchy_walk` function generates multiple random walks in 1,
2, or 3 dimensions. Each walk is a sequence of steps where each step is
a random draw from a Cauchy distribution. The user can specify the
number of walks, the number of steps in each walk, and the parameters of
the Cauchy distribution (location and scale). The function also allows
for sampling a proportion of the steps and optionally sampling with
replacement.

## Usage

``` r
random_cauchy_walk(
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

  A numeric value indicating the location parameter of the Cauchy
  distribution. Default is 0.

- .scale:

  A numeric value indicating the scale parameter of the Cauchy
  distribution. Default is 1.

- .initial_value:

  A numeric value indicating the initial value of the walks. Default is
  0.

- .samp:

  A logical value indicating whether to sample the Cauchy distribution
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

The `location` and `scale` parameters can be single values or vectors of
length equal to the number of dimensions. If vectors are provided, each
dimension uses its corresponding value.

## See also

Other Generator Functions:
[`brownian_motion()`](https://www.spsanderson.com/RandomWalker/reference/brownian_motion.md),
[`custom_walk()`](https://www.spsanderson.com/RandomWalker/reference/custom_walk.md),
[`discrete_walk()`](https://www.spsanderson.com/RandomWalker/reference/discrete_walk.md),
[`geometric_brownian_motion()`](https://www.spsanderson.com/RandomWalker/reference/geometric_brownian_motion.md),
[`random_beta_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_beta_walk.md),
[`random_binomial_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_binomial_walk.md),
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
[`random_weibull_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_weibull_walk.md),
[`random_wilcox_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_wilcox_walk.md),
[`random_wilcoxon_sr_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_wilcoxon_sr_walk.md)

Other Continuous Distribution:
[`brownian_motion()`](https://www.spsanderson.com/RandomWalker/reference/brownian_motion.md),
[`geometric_brownian_motion()`](https://www.spsanderson.com/RandomWalker/reference/geometric_brownian_motion.md),
[`random_beta_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_beta_walk.md),
[`random_chisquared_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_chisquared_walk.md),
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
random_cauchy_walk()
#> # A tibble: 2,000 × 8
#>    walk_number step_number       y cum_sum_y cum_prod_y cum_min_y cum_max_y
#>    <fct>             <int>   <dbl>     <dbl>      <dbl>     <dbl>     <dbl>
#>  1 1                     1   1.27      1.27           0     1.27       1.27
#>  2 1                     2  -0.784     0.485          0    -0.784      1.27
#>  3 1                     3   3.40      3.89           0    -0.784      3.40
#>  4 1                     4  -0.385     3.50           0    -0.784      3.40
#>  5 1                     5  -0.189     3.31           0    -0.784      3.40
#>  6 1                     6   0.144     3.46           0    -0.784      3.40
#>  7 1                     7 -11.3      -7.84           0   -11.3        3.40
#>  8 1                     8  -0.351    -8.19           0   -11.3        3.40
#>  9 1                     9  -6.13    -14.3            0   -11.3        3.40
#> 10 1                    10   7.29     -7.03           0   -11.3        7.29
#> # ℹ 1,990 more rows
#> # ℹ 1 more variable: cum_mean_y <dbl>

set.seed(123)
random_cauchy_walk(.dimensions = 3, .location = c(0, 1, 2), .scale = c(1, 2, 3)) |>
  head() |>
  t()
#>             [,1]          [,2]          [,3]          [,4]         
#> walk_number "1"           "1"           "1"           "1"          
#> step_number "1"           "2"           "3"           "4"          
#> x           " 1.2691296"  "-0.7842432"  " 3.4011811"  "-0.3850032" 
#> y           " 2.9213852"  "-2.4294558"  " 8.5571019"  "-0.5695959" 
#> z           "-413.258437" "   8.070792" "  -3.888510" "   9.224272"
#> cum_sum_x   "1.2691296"   "0.4848863"   "3.8860675"   "3.5010642"  
#> cum_sum_y   " 2.9213852"  " 0.4919294"  " 9.0490313"  " 8.4794355" 
#> cum_sum_z   "-413.2584"   "-405.1876"   "-409.0762"   "-399.8519"  
#> cum_prod_x  "0"           "0"           "0"           "0"          
#> cum_prod_y  "0"           "0"           "0"           "0"          
#> cum_prod_z  "0"           "0"           "0"           "0"          
#> cum_min_x   " 1.2691296"  "-0.7842432"  "-0.7842432"  "-0.7842432" 
#> cum_min_y   " 2.921385"   "-2.429456"   "-2.429456"   "-2.429456"  
#> cum_min_z   "-413.2584"   "-413.2584"   "-413.2584"   "-413.2584"  
#> cum_max_x   "1.269130"    "1.269130"    "3.401181"    "3.401181"   
#> cum_max_y   " 2.921385"   " 2.921385"   " 8.557102"   " 8.557102"  
#> cum_max_z   "-413.258437" "   8.070792" "   8.070792" "   9.224272"
#> cum_mean_x  "1.2691296"   "0.2424432"   "1.2953558"   "0.8752661"  
#> cum_mean_y  "2.9213852"   "0.2459647"   "3.0163438"   "2.1198589"  
#> cum_mean_z  "-413.25844"  "-202.59382"  "-136.35872"  " -99.96297" 
#>             [,5]          [,6]         
#> walk_number "1"           "1"          
#> step_number "5"           "6"          
#> x           "-0.1892392"  " 0.1441052" 
#> y           " 1.6697976"  "10.6412732" 
#> z           "   8.145512" " -26.240418"
#> cum_sum_x   "3.3118250"   "3.4559303"  
#> cum_sum_y   "10.1492330"  "20.7905062" 
#> cum_sum_z   "-391.7064"   "-417.9468"  
#> cum_prod_x  "0"           "0"          
#> cum_prod_y  "0"           "0"          
#> cum_prod_z  "0"           "0"          
#> cum_min_x   "-0.7842432"  "-0.7842432" 
#> cum_min_y   "-2.429456"   "-2.429456"  
#> cum_min_z   "-413.2584"   "-413.2584"  
#> cum_max_x   "3.401181"    "3.401181"   
#> cum_max_y   " 8.557102"   "10.641273"  
#> cum_max_z   "   9.224272" "   9.224272"
#> cum_mean_x  "0.6623650"   "0.5759884"  
#> cum_mean_y  "2.0298466"   "3.4650844"  
#> cum_mean_z  " -78.34127"  " -69.65780" 
```
