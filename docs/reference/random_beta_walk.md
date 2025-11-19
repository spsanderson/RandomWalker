# Generate Multiple Random Beta Walks in Multiple Dimensions

The `random_beta_walk` function generates multiple random walks in 1, 2,
or 3 dimensions. Each walk is a sequence of steps where each step is a
random draw from a Beta distribution. The user can specify the number of
walks, the number of steps in each walk, and the parameters of the Beta
distribution (shape1, shape2, ncp). The function also allows for
sampling a proportion of the steps and optionally sampling with
replacement.

## Usage

``` r
random_beta_walk(
  .num_walks = 25,
  .n = 100,
  .shape1 = 2,
  .shape2 = 2,
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

  An integer specifying the number of steps in each walk. Must be \>= 1.
  Default is 100.

- .shape1:

  Non-negative parameter of the Beta distribution. Default is 2.

- .shape2:

  Non-negative parameter of the Beta distribution. Default is 2.

- .ncp:

  Non-centrality parameter (ncp \>= 0). Default is 0.

- .initial_value:

  A numeric value indicating the initial value of the walks. Default is
  0.

- .samp:

  A logical value indicating whether to sample the Beta distribution
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

The `shape1`, `shape2`, and `ncp` parameters can be single values or
vectors of length equal to the number of dimensions. If vectors are
provided, each dimension uses its corresponding value.

## See also

Other Generator Functions:
[`brownian_motion()`](https://www.spsanderson.com/RandomWalker/reference/brownian_motion.md),
[`custom_walk()`](https://www.spsanderson.com/RandomWalker/reference/custom_walk.md),
[`discrete_walk()`](https://www.spsanderson.com/RandomWalker/reference/discrete_walk.md),
[`geometric_brownian_motion()`](https://www.spsanderson.com/RandomWalker/reference/geometric_brownian_motion.md),
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
[`random_wilcox_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_wilcox_walk.md),
[`random_wilcoxon_sr_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_wilcoxon_sr_walk.md)

Other Continuous Distribution:
[`brownian_motion()`](https://www.spsanderson.com/RandomWalker/reference/brownian_motion.md),
[`geometric_brownian_motion()`](https://www.spsanderson.com/RandomWalker/reference/geometric_brownian_motion.md),
[`random_cauchy_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_cauchy_walk.md),
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
random_beta_walk()
#> # A tibble: 2,000 × 8
#>    walk_number step_number      y cum_sum_y cum_prod_y cum_min_y cum_max_y
#>    <fct>             <int>  <dbl>     <dbl>      <dbl>     <dbl>     <dbl>
#>  1 1                     1 0.0544    0.0544          0    0.0544    0.0544
#>  2 1                     2 0.514     0.569           0    0.0544    0.514 
#>  3 1                     3 0.374     0.942           0    0.0544    0.514 
#>  4 1                     4 0.404     1.35            0    0.0544    0.514 
#>  5 1                     5 0.811     2.16            0    0.0544    0.811 
#>  6 1                     6 0.893     3.05            0    0.0544    0.893 
#>  7 1                     7 0.391     3.44            0    0.0544    0.893 
#>  8 1                     8 0.636     4.08            0    0.0544    0.893 
#>  9 1                     9 0.529     4.61            0    0.0544    0.893 
#> 10 1                    10 0.695     5.30            0    0.0544    0.893 
#> # ℹ 1,990 more rows
#> # ℹ 1 more variable: cum_mean_y <dbl>

set.seed(123)
random_beta_walk(.dimensions = 3, .shape1 = c(2, 3, 4), .shape2 = c(2, 3, 4), .ncp = c(0, 1, 2)) |>
  head() |>
  t()
#>             [,1]         [,2]         [,3]         [,4]         [,5]        
#> walk_number "1"          "1"          "1"          "1"          "1"         
#> step_number "1"          "2"          "3"          "4"          "5"         
#> x           "0.05442085" "0.51430835" "0.37350549" "0.40391599" "0.81096384"
#> y           "0.8236399"  "0.7161976"  "0.6063538"  "0.5281700"  "0.5634105" 
#> z           "0.5827135"  "0.5404688"  "0.8781755"  "0.2436878"  "0.5542260" 
#> cum_sum_x   "0.05442085" "0.56872920" "0.94223469" "1.34615068" "2.15711452"
#> cum_prod_x  "0"          "0"          "0"          "0"          "0"         
#> cum_min_x   "0.05442085" "0.05442085" "0.05442085" "0.05442085" "0.05442085"
#> cum_max_x   "0.05442085" "0.51430835" "0.51430835" "0.51430835" "0.81096384"
#> cum_mean_x  "0.05442085" "0.28436460" "0.31407823" "0.33653767" "0.43142290"
#> cum_sum_y   "0.8236399"  "1.5398375"  "2.1461913"  "2.6743613"  "3.2377718" 
#> cum_prod_y  "0"          "0"          "0"          "0"          "0"         
#> cum_min_y   "0.8236399"  "0.7161976"  "0.6063538"  "0.5281700"  "0.5281700" 
#> cum_max_y   "0.8236399"  "0.8236399"  "0.8236399"  "0.8236399"  "0.8236399" 
#> cum_mean_y  "0.8236399"  "0.7699187"  "0.7153971"  "0.6685903"  "0.6475544" 
#> cum_sum_z   "0.5827135"  "1.1231823"  "2.0013579"  "2.2450457"  "2.7992717" 
#> cum_prod_z  "0"          "0"          "0"          "0"          "0"         
#> cum_min_z   "0.5827135"  "0.5404688"  "0.5404688"  "0.2436878"  "0.2436878" 
#> cum_max_z   "0.5827135"  "0.5827135"  "0.8781755"  "0.8781755"  "0.8781755" 
#> cum_mean_z  "0.5827135"  "0.5615912"  "0.6671193"  "0.5612614"  "0.5598543" 
#>             [,6]        
#> walk_number "1"         
#> step_number "6"         
#> x           "0.89256825"
#> y           "0.5944902" 
#> z           "0.3135386" 
#> cum_sum_x   "3.04968277"
#> cum_prod_x  "0"         
#> cum_min_x   "0.05442085"
#> cum_max_x   "0.89256825"
#> cum_mean_x  "0.50828046"
#> cum_sum_y   "3.8322619" 
#> cum_prod_y  "0"         
#> cum_min_y   "0.5281700" 
#> cum_max_y   "0.8236399" 
#> cum_mean_y  "0.6387103" 
#> cum_sum_z   "3.1128104" 
#> cum_prod_z  "0"         
#> cum_min_z   "0.2436878" 
#> cum_max_z   "0.8781755" 
#> cum_mean_z  "0.5188017" 
```
