# Animate a Double Pendulum

Animate a Double Pendulum

## Usage

``` r
animate_double_pendulum(.data, .walk = 1, .trail_length = 30)
```

## Arguments

- .data:

  Data returned by
  [`double_pendulum_walk()`](https://www.spsanderson.com/RandomWalker/reference/double_pendulum_walk.md).

- .walk:

  One walk_number label to display, rather than its position.

- .trail_length:

  Nonnegative integer number of recent sampled positions in the second
  bob's trail, including the current position. Zero disables it.

## Value

A gganim object. Construction does not render or save files.

## Details

Requires optional packages ggplot2 and gganimate. GIF rendering
additionally requires gifski. Each observation is one discrete frame;
rendering at `fps = 1 / .delta_time` preserves simulated time.

## See also

Other Visualization Functions:
[`plot_double_pendulum()`](https://www.spsanderson.com/RandomWalker/reference/plot_double_pendulum.md),
[`visualize_walks()`](https://www.spsanderson.com/RandomWalker/reference/visualize_walks.md)

## Examples

``` r
if (FALSE) { # \dontrun{
walks <- double_pendulum_walk(.num_walks = 1)
animation <- animate_double_pendulum(walks)
gif <- gganimate::animate(animation, nframes = attr(walks, "n"),
  fps = 1 / attr(walks, "delta_time"), renderer = gganimate::gifski_renderer())
gganimate::anim_save("double-pendulum.gif", animation = gif)
} # }
```
