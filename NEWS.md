---
editor_options: 
  markdown: 
    wrap: 72
---

# RandomWalker (development version)

## Breaking Changes

None

## New Features

1.  Fix #179 - Add function `random_wilcox_walk()` to generate a random
    walk using the Wilcoxon signed-rank test.
2.  Fix #178 - Add function `random_weibull_walk()` to generate a random
    walk using the Weibull distribution.
3.  Fix #177 - Add function `random_uniform_walk()` to generate a random
    walk using the Uniform distribution.
4.  Fix #176 - Add function `random_t_walk()` to generate a random walk
    using the Student's t-distribution.
5.  Fix #175 - Add function `random_smirnov_walk()` to generate a random
    walk using the Smirnov distribution.
6.  Fix #174 - Add function `random_wilcoxon_sr_walk()` to generate a
    random walk using the Wilcoxon signed-rank test with a specified
    number of steps.
7.  Fix #173 - Add function `random_poisson_walk()` to generate a
    random walk using the Poisson distribution.
8.  Fix #172 - Add function `random_negbinomial_walk()` to generate a
    random walk using the Negative Binomial distribution.
9.  Fix #171 - Add function `random_multinomial_walk()` to generate a 
    random walk using the Multinomial distribution.
10. Fix #170 - Add function `random_logistic_walk()` to generate a random
    walk using the Logistic distribution.
11. Fix #169 - Add function `random_lognormal_walk()` to generate a random
    walk using the Log-Normal distribution.
12. Fix #168 - Add function `random_hypergeometric_walk()` to generate a 
    walk using the Hypergeometric distribution.
13. Fix #167 - Add function `random_geometric_walk()` to generate a
    random walk using the geometric distribution.
14. Fix #166 - Add function `random_f_walk()` to generate a random walk using
    the F-distribution.
15. Fix #165 - Add function `random_chisquared_walk()` to generate a random walk
    using the Chi-Squared distribution.
16. Fix #164 - Add function `random_binomial_walk()` to generate a random walk using
    the Binomial distribution.
17. Fix #163 - Add function `random_gamma_walk()` to generate a random walk using
    the Gamma distribution.
18. Fix #162 - Add function `random_exponential_walk()` to generate a random walk using
    the Exponential distribution.

## Minor Fixes and Improvements

None

# RandomWalker 0.3.0

## Breaking Changes

1.  Fix #107 - This change allows for the generation of random walks
    with up to 3 dimensions. Due to this what was the `x` column is now
    called `step_number` for all random walk functions including rw30().
    The `x` column is now the first dimension of a 2D/3D random walk.

## New Features

1.  Fix #105 - Add internal function `rand_walk_column_names()` to
    generate column names for random walks.
2.  Fix #142 - Add vector function `confidence_interval()` to generate
    confidence interval tibble.
3.  Fix #71 - Add function subset_walks() to subset random walks by max
    or min value.

## Minor Fixes and Improvements

1.  Fix #107 - Add `.dimensions` parameter to random walk functions to
    allow for the generation of random walks with up to 3 dimensions!

## Release Blog Post

<https://www.spsanderson.com/steveondata/posts/2025-05-09/>

# RandomWalker 0.2.0

## Breaking Changes

None

## New Features

1.  Fix #92 - Add Function `std_cum_sum_augment()` to calculate the
    cumulative sum of a random walk.
2.  Fix #93 - Add Function `std_cum_prod_augment()` to calculate the
    cumulative product of a random walk.
3.  Fix #94 - Add Function `std_cum_min_augment()` to calculate the
    cumulative minimum of a random walk.
4.  Fix #95 - Add Function `std_cum_max_augment()` to calculate the
    cumulative maximum of a random walk.
5.  Fix #96 - Add Function `std_cum_mean_augment()` to calculate the
    cumulative mean of a random walk.
6.  Fix #113 - Add Function `get_attributes()` to get attributes without
    the `row.names`
7.  Fix #123 - Add Function `running_quantile()` to calculate the
    running quantile of a given vector.

## Minor Improvements and Fixes

1.  Fix #117 - Add `.interactive` parameter to `visualize_walks()` to
    allow for interactive plots.
2.  Fix #120 - Add `.pluck` parameter to `visualize_walks()` to allow
    for plucking of specific graph of walks.

## Release Blog Post

<https://www.spsanderson.com/steveondata/posts/2024-10-24/>

# RandomWalker 0.1.0

## Breaking Changes

None

## New Features

1.  Fix #9 - Add Function `rw30()` to generate 30 random walks of 100
    steps each
2.  Fix #17 - Add Function `geometric_brownian_motion()` to generate
    Geometric Brownian Motion
3.  Fix #18 - Add Function `random_normal_drift_walk()` to generate
    Random Walk with Drift
4.  Fix #16 - Add Function `brownian_motion()` to generate Brownian
    Motion
5.  Fix #13 - Add Function `random_normal_walk()` to generate Random
    Walk
6.  Fix #30 - Add Function `discrete_walk()` to generate Discrete Random
    Walk
7.  Fix #43 - Add vectorized functions
8.  Fix #44 - Add Function `internal_rand_walk_helper()` to help
    generate common columns for random walks.
9.  Fix #34 - Add Function `euclidean_distance()` to calculate the
    Euclidean distance of a random walk.
10. Fix #33 - Add Function `visualize_walks()` to visualize random
    walks.
11. Fix #66 - Add Function `summarize_walks()` to summarize random
    walks.

## Minor Improvements and Fixes

None
