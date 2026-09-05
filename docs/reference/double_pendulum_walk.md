# Double Pendulum Walk

Simulate a planar frictionless double pendulum with massless rigid rods
and point masses. Randomness enters only through starting angles;
subsequent continuous-time motion is deterministic.

## Usage

``` r
double_pendulum_walk(
  .num_walks = 5,
  .n = 401,
  .delta_time = 0.05,
  .theta1 = pi/2,
  .theta2 = pi/2,
  .omega1 = 0,
  .omega2 = 0,
  .angle_sd = 0.01,
  .m1 = 1,
  .m2 = 1,
  .l1 = 1,
  .l2 = 1,
  .gravity = 9.81
)
```

## Arguments

- .num_walks:

  Positive integer number of trajectories.

- .n:

  Integer number of observations, including time zero (at least two).

- .delta_time:

  Positive sampling interval in seconds, not the solver step.

- .theta1, .theta2:

  Initial angles in radians from vertically downward.

- .omega1, .omega2:

  Initial angular velocities in radians per second.

- .angle_sd:

  Nonnegative standard deviation of independent normal angle
  perturbations. Zero consumes no random numbers. Use
  [`set.seed()`](https://rdrr.io/r/base/Random.html) for repeatability.

- .m1, .m2:

  Positive bob masses in kilograms.

- .l1, .l2:

  Positive rod lengths in meters.

- .gravity:

  Positive gravitational acceleration in meters per second squared.

## Value

An ungrouped tibble with factor `walk_number`, integer `step_number`,
`time`, angles `theta1`, `theta2`, angular velocities `omega1`,
`omega2`, first bob coordinates `x1`, `y1`, and second bob coordinates
`x`, `y`. Coordinates are positions, not increments; no cumulative
columns are added. Attributes contain parameters, `initial_states`,
`fns`, `n`, `num_steps`, `num_walks`, `delta_time`, and
`dimensions = 2`.

## Details

Uses optional package deSolve and adaptive LSODA integration with
relative and absolute tolerances of 1e-9. Times are
`(0:(.n - 1)) * .delta_time`. The default covers 20 seconds. Angles are
absolute, not relative to the other rod; positive angles move toward
positive x from downward vertical. The pivot is at the origin and y
increases upward. This is an ensemble of randomized initial conditions,
not a process with random forces or random waiting times.

## References

Equations:
<https://www.myphysicslab.com/pendulum/double-pendulum-en.html>.

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
[`random_normal_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_normal_walk.md),
[`random_t_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_t_walk.md),
[`random_uniform_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_uniform_walk.md),
[`random_weibull_walk()`](https://www.spsanderson.com/RandomWalker/reference/random_weibull_walk.md)

## Examples

``` r
if (requireNamespace("deSolve", quietly = TRUE)) {
  set.seed(287)
  walks <- double_pendulum_walk(.num_walks = 2, .n = 21)
  head(walks)
}
#> # A tibble: 6 × 11
#>   walk_number step_number  time theta1 theta2 omega1     omega2    x1       y1
#>   <fct>             <int> <dbl>  <dbl>  <dbl>  <dbl>      <dbl> <dbl>    <dbl>
#> 1 1                     1  0      1.59   1.56  0      0         1.000  0.0145 
#> 2 1                     2  0.05   1.57   1.56 -0.490 -0.0000959 1.000  0.00223
#> 3 1                     3  0.1    1.54   1.56 -0.981 -0.000333  0.999 -0.0345 
#> 4 1                     4  0.15   1.48   1.56 -1.46  -0.0114    0.995 -0.0956 
#> 5 1                     5  0.2    1.39   1.55 -1.92  -0.0628    0.984 -0.180  
#> 6 1                     6  0.25   1.28   1.55 -2.33  -0.203     0.959 -0.283  
#> # ℹ 2 more variables: x <dbl>, y <dbl>
```
