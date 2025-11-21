# Generate Multiple Random Wilcoxon Signed-Rank Walks

A Wilcoxon signed-rank random walk is a stochastic process in which each
step is drawn from the Wilcoxon signed-rank distribution, commonly used
in nonparametric statistics. This function allows for the simulation of
multiple independent random walks in one, two, or three dimensions, with
user control over the number of walks, steps, and the sample size
parameter for the distribution. Sampling options allow for further
customization, including the ability to sample a proportion of steps and
to sample with or without replacement. The resulting data frame includes
cumulative statistics for each walk, making it suitable for simulation
studies and visualization.

## Usage

``` r
random_wilcoxon_sr_walk(
  .num_walks = 25,
  .nn = 100,
  .n = 1,
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

- .nn:

  An integer specifying the number of steps in each walk. Default is
  100.

- .n:

  Integer or vector. Number(s) of observations in the sample(s) for
  rsignrank. Default is 1.

- .initial_value:

  Numeric. Starting value of the walk. Default is 0.

- .samp:

  Logical. Whether to sample the steps. Default is TRUE.

- .replace:

  Logical. Whether sampling is with replacement. Default is TRUE.

- .sample_size:

  Numeric. Proportion of steps to sample (0-1). Default is 0.8.

- .dimensions:

  Integer. Number of dimensions (1, 2, or 3). Default is 1.

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

## Details

The `random_wilcoxon_sr_walk` function generates multiple random walks
in 1, 2, or 3 dimensions. Each walk is a sequence of steps where each
step is a random draw from the Wilcoxon signed-rank distribution using
[`stats::rsignrank()`](https://rdrr.io/r/stats/SignRank.html). The user
can specify the number of steps/periods (`nn`), the number of samples in
each walk (`n`), and the number of dimensions. The function also allows
for sampling a proportion of the steps and optionally sampling with
replacement.

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
[`random_wilcox_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_wilcox_walk.md)

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
[`random_wilcox_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_wilcox_walk.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
set.seed(123)
random_wilcoxon_sr_walk()
#> # A tibble: 2,000 × 8
#>    walk_number step_number     y cum_sum_y cum_prod_y cum_min_y cum_max_y
#>    <fct>             <int> <int>     <dbl>      <dbl>     <dbl>     <dbl>
#>  1 1                     1     1         1          0         1         1
#>  2 1                     2     0         1          0         0         1
#>  3 1                     3     1         2          0         0         1
#>  4 1                     4     1         3          0         0         1
#>  5 1                     5     1         4          0         0         1
#>  6 1                     6     1         5          0         0         1
#>  7 1                     7     1         6          0         0         1
#>  8 1                     8     0         6          0         0         1
#>  9 1                     9     0         6          0         0         1
#> 10 1                    10     0         6          0         0         1
#> # ℹ 1,990 more rows
#> # ℹ 1 more variable: cum_mean_y <dbl>

set.seed(123)
random_wilcoxon_sr_walk(.dimensions = 3) |>
   head() |>
   t()
#>             [,1]        [,2]        [,3]        [,4]        [,5]       
#> walk_number "1"         "1"         "1"         "1"         "1"        
#> step_number "1"         "2"         "3"         "4"         "5"        
#> x           "1"         "0"         "1"         "1"         "1"        
#> y           "0"         "1"         "1"         "1"         "0"        
#> z           "0"         "1"         "0"         "0"         "1"        
#> cum_sum_x   "1"         "1"         "2"         "3"         "4"        
#> cum_sum_y   "0"         "1"         "2"         "3"         "3"        
#> cum_sum_z   "0"         "1"         "1"         "1"         "2"        
#> cum_prod_x  "0"         "0"         "0"         "0"         "0"        
#> cum_prod_y  "0"         "0"         "0"         "0"         "0"        
#> cum_prod_z  "0"         "0"         "0"         "0"         "0"        
#> cum_min_x   "1"         "0"         "0"         "0"         "0"        
#> cum_min_y   "0"         "0"         "0"         "0"         "0"        
#> cum_min_z   "0"         "0"         "0"         "0"         "0"        
#> cum_max_x   "1"         "1"         "1"         "1"         "1"        
#> cum_max_y   "0"         "1"         "1"         "1"         "1"        
#> cum_max_z   "0"         "1"         "1"         "1"         "1"        
#> cum_mean_x  "1.0000000" "0.5000000" "0.6666667" "0.7500000" "0.8000000"
#> cum_mean_y  "0.0000000" "0.5000000" "0.6666667" "0.7500000" "0.6000000"
#> cum_mean_z  "0.0000000" "0.5000000" "0.3333333" "0.2500000" "0.4000000"
#>             [,6]       
#> walk_number "1"        
#> step_number "6"        
#> x           "1"        
#> y           "0"        
#> z           "1"        
#> cum_sum_x   "5"        
#> cum_sum_y   "3"        
#> cum_sum_z   "3"        
#> cum_prod_x  "0"        
#> cum_prod_y  "0"        
#> cum_prod_z  "0"        
#> cum_min_x   "0"        
#> cum_min_y   "0"        
#> cum_min_z   "0"        
#> cum_max_x   "1"        
#> cum_max_y   "1"        
#> cum_max_z   "1"        
#> cum_mean_x  "0.8333333"
#> cum_mean_y  "0.5000000"
#> cum_mean_z  "0.5000000"
```
