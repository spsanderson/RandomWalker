#' Discrete Sampled Walk
#'
#' @family Generator Functions
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' The `discrete_walk` function generates multiple random walks over discrete time periods.
#' Each step in the walk is determined by a probabilistic sample from specified upper and lower bounds.
#' This function is useful for simulating stochastic processes, such as stock price movements or
#' other scenarios where outcomes are determined by a random process.
#'
#' @details
#' The function `discrete_walk` simulates random walks for a specified number of simulations
#' (`.num_walks`) over a given total time (`.n`). Each step in the walk is either the upper
#' bound or the lower bound, determined by a probability (`.upper_probability`). The initial
#' value of the walk is set by the user (`.initial_value`), and the cumulative sum, product,
#' minimum, and maximum of the steps are calculated for each walk. The results are returned
#' in a tibble with detailed attributes, including the parameters used for the simulation.
#'
#' @param .n Total time of the simulation.
#' @param .num_walks Total number of simulations.
#' @param .upper_bound The upper bound of the random walk.
#' @param .lower_bound The lower bound of the random walk.
#' @param .upper_probability The probability of the upper bound. Default is 0.5.
#' The lower bound is calculated as 1 - .upper_probability.
#' @param .initial_value The initial value of the random walk. Default is 100.
#'
#' @examples
#' library(ggplot2)
#'
#' set.seed(123)
#' discrete_walk()
#'
#' set.seed(123)
#' discrete_walk(.num_walks = 30, .n = 250, .upper_probability = 0.55) |>
#' ggplot(aes(x = x, y = cum_sum)) +
#'  geom_line(aes(group = walk_number), alpha = .618, color = "steelblue") +
#'  theme_minimal() +
#'  theme(legend.position = "none") +
#'  geom_smooth(method = "lm", se = FALSE)
#'
#' @return
#' A tibble containing the simulated walks, with columns for the walk number,
#' time period, and various cumulative metrics (sum, product, min, max).
#'
#' @name discrete_walk
NULL
#' @export
#' @rdname discrete_walk

discrete_walk <- function(.num_walks = 25, .n = 100, .upper_bound = 1,
                          .lower_bound = -1, .upper_probability = 0.5,
                          .initial_value = 100) {

  # Variables
  num_walks <- as.integer(.num_walks)
  periods <- as.integer(.n)
  upper_bound <- as.numeric(.upper_bound)
  lower_bound <- as.numeric(.lower_bound)
  upper_probability <- as.numeric(.upper_probability)
  lower_probability <- 1 - upper_probability
  initial_value <- as.numeric(.initial_value)

  # Checks
  if (!is.integer(num_walks) | num_walks < 1) {
    rlang::abort(
      message = "The number of walks must be an integer greater than 0.",
      use_cli_format = TRUE
    )
  }

  if (!is.integer(periods) | periods < 1) {
    rlang::abort(
      message = "The number of periods must be an integer greater than 0.",
      use_cli_format = TRUE
    )
  }

  if (!is.numeric(upper_bound)) {
    rlang::abort(
      message = "The upper bound must be a numeric value.",
      use_cli_format = TRUE
      )
  }

  if (!is.numeric(lower_bound)) {
    rlang::abort(
      message = "The lower bound must be a numeric value.",
      use_cli_format = TRUE
      )
  }

  if (!is.numeric(upper_probability) | upper_probability < 0 | upper_probability > 1) {
    rlang::abort(
      message = "The upper probability must be a numeric value between 0 and 1.",
      use_cli_format = TRUE
      )
  }

  if (!is.numeric(initial_value)) {
    rlang::abort(
      message = "The initial value must be a numeric value.",
      use_cli_format = TRUE
      )
  }

  res <- tidyr::expand_grid(walk_number = factor(1:num_walks), x = 1:periods) |>
    dplyr::group_by(walk_number) |>
    dplyr::mutate(y = replicate(
      n = periods,
      sample(
        x = c(upper_bound, lower_bound),
        size = 1,
        prob = c(upper_probability, lower_probability))
      )
    ) |>
    dplyr::ungroup() |>
    rand_walk_helper(.value = initial_value)

  # Attributes
  attr(res, "n")             <- periods
  attr(res, "num_walks")     <- .num_walks
  attr(res, "upper_bound")   <- upper_bound
  attr(res, "lower_bound")   <- lower_bound
  attr(res, "upper_probability") <- upper_probability
  attr(res, "lower_probability") <- lower_probability
  attr(res, "initial_value") <- initial_value
  attr(res, "fns")           <- "discrete_walk"
  attr(res, "dimension")     <- 1

  # Return
  return(res)

}
