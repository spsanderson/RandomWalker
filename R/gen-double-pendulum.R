#' Double Pendulum Walk
#'
#' @family Generator Functions
#' @family Continuous Distribution
#' @description Simulate a planar frictionless double pendulum with massless
#' rigid rods and point masses. Randomness enters only through starting angles;
#' subsequent continuous-time motion is deterministic.
#' @param .num_walks Positive integer number of trajectories.
#' @param .n Integer number of observations, including time zero (at least two).
#' @param .delta_time Positive sampling interval in seconds, not the solver step.
#' @param .theta1,.theta2 Initial angles in radians from vertically downward.
#' @param .omega1,.omega2 Initial angular velocities in radians per second.
#' @param .angle_sd Nonnegative standard deviation of independent normal angle
#' perturbations. Zero consumes no random numbers. Use `set.seed()` for repeatability.
#' @param .m1,.m2 Positive bob masses in kilograms.
#' @param .l1,.l2 Positive rod lengths in meters.
#' @param .gravity Positive gravitational acceleration in meters per second squared.
#' @details Uses optional package deSolve and adaptive LSODA integration with
#' relative and absolute tolerances of 1e-9. Times are
#' `(0:(.n - 1)) * .delta_time`. The default covers 20 seconds.
#' Angles are absolute, not relative to the other rod; positive angles move
#' toward positive x from downward vertical. The pivot is at the origin and y
#' increases upward. This is an ensemble of randomized initial conditions,
#' not a process with random forces or random waiting times.
#' @return An ungrouped tibble with factor `walk_number`, integer `step_number`,
#' `time`, angles `theta1`, `theta2`, angular velocities `omega1`, `omega2`, first
#' bob coordinates `x1`, `y1`, and second bob coordinates `x`, `y`. Coordinates
#' are positions, not increments; no cumulative columns are added. Attributes
#' contain parameters, `initial_states`, `fns`, `n`, `num_steps`, `num_walks`,
#' `delta_time`, and `dimensions = 2`.
#' @references Equations: <https://www.myphysicslab.com/pendulum/double-pendulum-en.html>.
#' @examples
#' if (requireNamespace("deSolve", quietly = TRUE)) {
#'   set.seed(287)
#'   walks <- double_pendulum_walk(.num_walks = 2, .n = 21)
#'   head(walks)
#' }
#' @export
double_pendulum_walk <- function(.num_walks = 5, .n = 401, .delta_time = 0.05,
                                 .theta1 = pi / 2, .theta2 = pi / 2,
                                 .omega1 = 0, .omega2 = 0, .angle_sd = 0.01,
                                 .m1 = 1, .m2 = 1, .l1 = 1, .l2 = 1,
                                 .gravity = 9.81) {
  parameters <- list(num_walks = .num_walks, n = .n, delta_time = .delta_time,
                     theta1 = .theta1, theta2 = .theta2, omega1 = .omega1,
                     omega2 = .omega2, angle_sd = .angle_sd, m1 = .m1,
                     m2 = .m2, l1 = .l1, l2 = .l2, gravity = .gravity)
  for (name in names(parameters)) {
    pendulum_scalar(parameters[[name]], paste0(".", name))
  }
  for (name in c("num_walks", "n")) {
    value <- parameters[[name]]
    if (value != floor(value) || value < (if (name == "n") 2 else 1) ||
        value > .Machine$integer.max) {
      rlang::abort(paste0(".", name, " must be an integer between ",
                         if (name == "n") 2 else 1, " and .Machine$integer.max."))
    }
  }
  for (name in c("delta_time", "m1", "m2", "l1", "l2", "gravity")) {
    if (parameters[[name]] <= 0) rlang::abort(paste0(".", name, " must be positive."))
  }
  if (.angle_sd < 0) rlang::abort(".angle_sd must be nonnegative.")
  pendulum_require("deSolve")
  times <- (seq_len(.n) - 1) * .delta_time
  if (any(!is.finite(times)) || any(diff(times) <= 0)) {
    rlang::abort("Sampling times must be finite and strictly increasing.")
  }
  starts <- vector("list", .num_walks)
  results <- vector("list", .num_walks)
  for (i in seq_len(.num_walks)) {
    angles <- c(.theta1, .theta2)
    if (.angle_sd > 0) angles <- angles + stats::rnorm(2, sd = .angle_sd)
    state <- c(theta1 = angles[1], theta2 = angles[2],
               omega1 = .omega1, omega2 = .omega2)
    starts[[i]] <- state
    solution <- tryCatch(
      deSolve::ode(state, times, pendulum_derivatives, parameters,
                   method = "lsoda", rtol = 1e-9, atol = 1e-9),
      error = function(e) rlang::abort(paste0("Integration failed for walk ", i, ": ",
                                             conditionMessage(e))))
    if (nrow(solution) != .n || any(!is.finite(solution)) ||
        !isTRUE(all.equal(unname(solution[, "time"]), times, tolerance = 0)) ||
        (!is.null(attr(solution, "istate")) && attr(solution, "istate")[[1]] < 0)) {
      rlang::abort(paste0("Integration failed or returned incomplete results for walk ", i, "."))
    }
    frame <- as.data.frame(solution)
    frame$x1 <- .l1 * sin(frame$theta1)
    frame$y1 <- -.l1 * cos(frame$theta1)
    frame$x <- frame$x1 + .l2 * sin(frame$theta2)
    frame$y <- frame$y1 - .l2 * cos(frame$theta2)
    if (any(!is.finite(as.matrix(frame)))) {
      rlang::abort(paste0("Nonfinite coordinates for walk ", i, "."))
    }
    results[[i]] <- dplyr::bind_cols(
      data.frame(walk_number = factor(i, levels = seq_len(.num_walks)),
                 step_number = seq_len(.n)), frame)
  }
  result <- dplyr::as_tibble(dplyr::bind_rows(results))
  for (name in names(parameters)) attr(result, name) <- parameters[[name]]
  attr(result, "initial_states") <- do.call(rbind, starts)
  attr(result, "fns") <- "double_pendulum_walk"
  attr(result, "num_steps") <- .n
  attr(result, "dimensions") <- 2L
  result
}

pendulum_scalar <- function(value, name) {
  if (!is.numeric(value) || length(value) != 1L || !is.finite(value)) {
    rlang::abort(paste0(name, " must be a finite numeric scalar."))
  }
}

pendulum_require <- function(package) {
  if (!requireNamespace(package, quietly = TRUE)) {
    rlang::abort(paste0("This feature requires the optional package '", package,
                       "'. Install it to use this function."))
  }
}

pendulum_derivatives <- function(time, state, parameters) {
  with(as.list(c(state, parameters)), {
    # The sine terms below require theta1 - theta2, not theta2 - theta1.
    delta <- theta1 - theta2
    denominator <- 2 * m1 + m2 - m2 * cos(2 * delta)
    a1 <- (-gravity * (2 * m1 + m2) * sin(theta1) -
             m2 * gravity * sin(theta1 - 2 * theta2) -
             2 * sin(delta) * m2 * (omega2^2 * l2 + omega1^2 * l1 * cos(delta))) /
      (l1 * denominator)
    a2 <- 2 * sin(delta) * (omega1^2 * l1 * (m1 + m2) +
                             gravity * (m1 + m2) * cos(theta1) +
                             omega2^2 * l2 * m2 * cos(delta)) / (l2 * denominator)
    list(c(omega1, omega2, a1, a2))
  })
}
