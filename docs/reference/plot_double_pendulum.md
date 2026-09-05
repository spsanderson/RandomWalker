# Plot a Double Pendulum Trajectory

Plot a Double Pendulum Trajectory

## Usage

``` r
plot_double_pendulum(.data, .walk = 1)
```

## Arguments

- .data:

  Data returned by
  [`double_pendulum_walk()`](https://www.spsanderson.com/RandomWalker/reference/double_pendulum_walk.md).

- .walk:

  One walk_number label to display, rather than its position.

## Value

A customizable ggplot of the second bob's spatial trajectory, colored by
elapsed seconds. Coordinates are in meters.

## See also

Other Visualization Functions:
[`animate_double_pendulum()`](https://www.spsanderson.com/RandomWalker/reference/animate_double_pendulum.md),
[`visualize_walks()`](https://www.spsanderson.com/RandomWalker/reference/visualize_walks.md)

## Examples

``` r
if (requireNamespace("deSolve", quietly = TRUE)) {
  plot_double_pendulum(double_pendulum_walk(.num_walks = 1, .n = 21))
}
```
