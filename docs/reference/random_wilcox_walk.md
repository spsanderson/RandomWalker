# Generate Multiple Random Wilcoxon Walks in Multiple Dimensions

The `random_wilcox_walk` function generates multiple random walks in 1,
2, or 3 dimensions. Each walk is a sequence of steps where each step is
a random draw from the Wilcoxon distribution using
[`stats::rwilcox()`](https://rdrr.io/r/stats/Wilcoxon.html). The user
can specify the number of walks, the number of steps in each walk, and
the parameters `.m` and `.n` for the Wilcoxon distribution. The function
also allows for sampling a proportion of the steps and optionally
sampling with replacement.

## Usage

``` r
random_wilcox_walk(
  .num_walks = 25,
  .n = 100,
  .m = 10,
  .k = 10,
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

  An integer specifying the number of steps in each walk. Default
  is 100. (Maps to `nn` in
  [`rwilcox()`](https://rdrr.io/r/stats/Wilcoxon.html))

- .m:

  Number of observations in the first sample for Wilcoxon. Default is
  10.

- .k:

  Number of observations in the second sample for Wilcoxon. Default is
  10.

- .initial_value:

  A numeric value indicating the initial value of the walks. Default is
  0.

- .samp:

  A logical value indicating whether to sample the Wilcoxon values.
  Default is TRUE.

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
[`random_normal_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_normal_walk.md),
[`random_poisson_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_poisson_walk.md),
[`random_smirnov_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_smirnov_walk.md),
[`random_t_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_t_walk.md),
[`random_uniform_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_uniform_walk.md),
[`random_weibull_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_weibull_walk.md),
[`random_wilcoxon_sr_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_wilcoxon_sr_walk.md)

Other Discrete Distribution:
[`discrete_walk()`](https://www.spsanderson.com/RandomWalker/reference/discrete_walk.md),
[`random_binomial_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_binomial_walk.md),
[`random_displacement_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_displacement_walk.md),
[`random_geometric_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_geometric_walk.md),
[`random_hypergeometric_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_hypergeometric_walk.md),
[`random_multinomial_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_multinomial_walk.md),
[`random_negbinomial_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_negbinomial_walk.md),
[`random_poisson_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_poisson_walk.md),
[`random_smirnov_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_smirnov_walk.md),
[`random_wilcoxon_sr_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_wilcoxon_sr_walk.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
set.seed(123)
random_wilcox_walk()
#> # A tibble: 2,000 × 8
#>    walk_number step_number     y cum_sum_y cum_prod_y cum_min_y cum_max_y
#>    <fct>             <int> <int>     <dbl>      <dbl>     <dbl>     <dbl>
#>  1 1                     1    35        35          0        35        35
#>  2 1                     2    26        61          0        26        35
#>  3 1                     3    74       135          0        26        74
#>  4 1                     4    59       194          0        26        74
#>  5 1                     5    46       240          0        26        74
#>  6 1                     6    38       278          0        26        74
#>  7 1                     7    53       331          0        26        74
#>  8 1                     8    54       385          0        26        74
#>  9 1                     9    19       404          0        19        74
#> 10 1                    10    55       459          0        19        74
#> # ℹ 1,990 more rows
#> # ℹ 1 more variable: cum_mean_y <dbl>

set.seed(123)
random_wilcox_walk(.dimensions = 2) |>
  head() |>
  t()
#>             [,1]       [,2]       [,3]       [,4]       [,5]       [,6]      
#> walk_number "1"        "1"        "1"        "1"        "1"        "1"       
#> step_number "1"        "2"        "3"        "4"        "5"        "6"       
#> x           "35"       "26"       "74"       "59"       "46"       "38"      
#> y           "50"       "39"       "54"       "30"       "51"       "51"      
#> cum_sum_x   " 35"      " 61"      "135"      "194"      "240"      "278"     
#> cum_sum_y   " 50"      " 89"      "143"      "173"      "224"      "275"     
#> cum_prod_x  "0"        "0"        "0"        "0"        "0"        "0"       
#> cum_prod_y  "0"        "0"        "0"        "0"        "0"        "0"       
#> cum_min_x   "35"       "26"       "26"       "26"       "26"       "26"      
#> cum_min_y   "50"       "39"       "39"       "30"       "30"       "30"      
#> cum_max_x   "35"       "35"       "74"       "74"       "74"       "74"      
#> cum_max_y   "50"       "50"       "54"       "54"       "54"       "54"      
#> cum_mean_x  "35.00000" "30.50000" "45.00000" "48.50000" "48.00000" "46.33333"
#> cum_mean_y  "50.00000" "44.50000" "47.66667" "43.25000" "44.80000" "45.83333"
```
