library(RandomWalker)

fails <- function(expr) stopifnot(inherits(try(expr, silent = TRUE), "try-error"))
if (!requireNamespace("deSolve", quietly = TRUE)) {
  message("SKIP: double-pendulum simulations require deSolve")
} else {
  generate <- function(...) double_pendulum_walk(.num_walks = 2, .n = 21, ...)
  set.seed(287)
  w <- generate()
  set.seed(287)
  stopifnot(identical(w, generate()), nrow(w) == 42L,
            identical(levels(w$walk_number), c("1", "2")),
            is.integer(w$step_number), !dplyr::is_grouped_df(w),
            identical(attr(w, "dimensions"), 2L), attr(w, "n") == 21,
            attr(w, "num_steps") == 21, attr(w, "num_walks") == 2,
            attr(w, "fns") == "double_pendulum_walk",
            identical(w$time[1:21], (0:20) * 0.05),
            w$theta1[1] != w$theta1[22],
            identical(unname(as.matrix(w[c(1, 22), c("theta1", "theta2", "omega1", "omega2")])),
                      unname(attr(w, "initial_states"))))
  rng <- .Random.seed
  fixed <- generate(.angle_sd = 0)
  stopifnot(identical(rng, .Random.seed))
  stopifnot(identical(as.matrix(fixed[1:21, -1]), as.matrix(fixed[22:42, -1])))
  rest <- generate(.angle_sd = 0, .theta1 = 0, .theta2 = 0)
  stopifnot(all(rest$x == 0), all(rest$y == -2), all(rest$omega1 == 0))

  for (bad in list(NA_real_, Inf, numeric(), c(1, 2), "2", TRUE)) {
    fails(double_pendulum_walk(.m1 = bad))
  }
  for (args in list(list(.n = 1), list(.n = 2.5), list(.num_walks = 0),
                    list(.num_walks = 1.5), list(.delta_time = 0), list(.m1 = -1),
                    list(.m2 = 0), list(.l1 = 0), list(.l2 = -1),
                    list(.gravity = 0), list(.angle_sd = -1))) {
    fails(do.call(double_pendulum_walk, args))
  }

  # Independent mass-matrix formulation, using unequal masses and rod lengths.
  pars <- list(m1 = 1.3, m2 = 0.7, l1 = 0.8, l2 = 1.2, gravity = 9.81)
  initial <- c(theta1 = 0.8, theta2 = -0.4, omega1 = 0.2, omega2 = -0.3)
  mass_rhs <- function(t, state, p) {
    with(as.list(c(state, p)), {
      delta <- theta1 - theta2
      cross <- m2 * l1 * l2
      mass <- matrix(c((m1 + m2) * l1^2, cross * cos(delta),
                       cross * cos(delta), m2 * l2^2), 2)
      forces <- c(-cross * sin(delta) * omega2^2 - (m1 + m2) * gravity * l1 * sin(theta1),
                   cross * sin(delta) * omega1^2 - m2 * gravity * l2 * sin(theta2))
      list(c(omega1, omega2, solve(mass, forces)))
    })
  }
  derivative <- getFromNamespace("pendulum_derivatives", "RandomWalker")
  stopifnot(isTRUE(all.equal(derivative(0, initial, pars)[[1]],
                            mass_rhs(0, initial, pars)[[1]], tolerance = 1e-12)))
  physical <- double_pendulum_walk(.num_walks = 1, .n = 101, .angle_sd = 0,
    .theta1 = 0.8, .theta2 = -0.4, .omega1 = 0.2, .omega2 = -0.3,
    .m1 = 1.3, .m2 = 0.7, .l1 = 0.8, .l2 = 1.2)
  stopifnot(max(abs(physical$x1^2 + physical$y1^2 - 0.8^2)) < 1e-12,
    max(abs((physical$x - physical$x1)^2 + (physical$y - physical$y1)^2 - 1.2^2)) < 1e-12)
  reference <- deSolve::ode(initial, physical$time, mass_rhs, pars,
                            method = "lsoda", rtol = 1e-12, atol = 1e-12)
  stopifnot(max(abs(as.matrix(physical[c("theta1", "theta2", "omega1", "omega2")]) -
                    reference[, -1])) < 1e-5)
  energy <- with(physical,
    0.5 * (pars$m1 + pars$m2) * pars$l1^2 * omega1^2 +
    0.5 * pars$m2 * pars$l2^2 * omega2^2 +
    pars$m2 * pars$l1 * pars$l2 * omega1 * omega2 * cos(theta1 - theta2) -
    (pars$m1 + pars$m2) * pars$gravity * pars$l1 * cos(theta1) -
    pars$m2 * pars$gravity * pars$l2 * cos(theta2))
  scale <- pars$gravity * ((pars$m1 + pars$m2) * pars$l1 + pars$m2 * pars$l2)
  stopifnot(max(abs(energy - energy[1])) / scale < 1e-6)
  stopifnot(nrow(suppressWarnings(summarize_walks(w, x))) == 1L)

  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    message("SKIP: pendulum plots require ggplot2")
  } else {
    stopifnot(inherits(plot_double_pendulum(w), "ggplot"),
              inherits(visualize_walks(w, .pluck = c("x", "y")), "ggplot"))
    ggplot2::ggplot_build(plot_double_pendulum(w))
    reversed <- w[nrow(w):1, ]
    stopifnot(identical(plot_double_pendulum(reversed)$data$step_number, 1:21))
    fails(plot_double_pendulum(w, .walk = "missing"))
    broken <- w
    broken$step_number[2] <- 1L
    fails(plot_double_pendulum(broken))
    broken <- w
    broken$x[2] <- Inf
    fails(plot_double_pendulum(broken))
    broken <- w
    broken$time[2] <- 0
    fails(plot_double_pendulum(broken))
    if (!requireNamespace("gganimate", quietly = TRUE)) {
      message("SKIP: pendulum animations require gganimate")
    } else {
      animation <- animate_double_pendulum(w, .trail_length = 3)
      stopifnot(inherits(animation, "gganim"))
      trail <- animation$layers[[1]]$data
      stopifnot(max(table(trail$frame)) == 3L,
                identical(trail$step_number[trail$frame == 21], 19:21))
      stopifnot(length(animate_double_pendulum(w, .trail_length = 0)$layers) == 6L)
      fails(animate_double_pendulum(w, .trail_length = -1))
      fails(animate_double_pendulum(w, .trail_length = 1.5))
      if (requireNamespace("gifski", quietly = TRUE)) {
        tiny <- w[w$step_number <= 5, ]
        gif <- gganimate::animate(animate_double_pendulum(tiny), nframes = 5,
          fps = 20, width = 240, height = 240, renderer = gganimate::gifski_renderer())
        stopifnot(identical(as.character(gganimate::frame_vars(gif)$current_frame),
                            as.character(1:5)))
        output <- tempfile(fileext = ".gif")
        gganimate::anim_save(output, animation = gif)
        stopifnot(file.exists(output), file.info(output)$size > 0)
      } else message("SKIP: GIF smoke test requires gifski")
    }
  }
}
