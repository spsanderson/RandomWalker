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
#' @param .dimensions The default is 1. Allowable values are 1, 2 and 3.
#'
#' @examples
#' set.seed(123)
#' discrete_walk()
#'
#' set.seed(123)
#' discrete_walk(.dimensions = 3) |>
#'   head() |>
#'   t()
#'
#' @return A tibble containing the generated random walks with columns depending
#' on the number of dimensions:
#' \itemize{
#'   \item `walk_number`: Factor representing the walk number.
#'   \item `step_number`: Step index.
#'   \item `y`: If `.dimensions = 1`, the value of the walk at each step.
#'   \item `x`, `y`: If `.dimensions = 2`, the values of the walk in two dimensions.
#'   \item `x`, `y`, `z`: If `.dimensions = 3`, the values of the walk in three dimensions.
#' }
#'
#' The following are also returned based upon how many dimensions there are and
#' could be any of x, y and or z:
#' \itemize{
#'   \item `cum_sum`: Cumulative sum of `dplyr::all_of(.dimensions)`.
#'   \item `cum_prod`: Cumulative product of `dplyr::all_of(.dimensions)`.
#'   \item `cum_min`: Cumulative minimum of `dplyr::all_of(.dimensions)`.
#'   \item `cum_max`: Cumulative maximum of `dplyr::all_of(.dimensions)`.
#'   \item `cum_mean`: Cumulative mean of `dplyr::all_of(.dimensions)`.
#' }
#'
#' @name discrete_walk
NULL
#' @export
#' @rdname discrete_walk

discrete_walk <- function(.num_walks = 25, .n = 100, .upper_bound = 1,
                          .lower_bound = -1, .upper_probability = 0.5,
                          .initial_value = 100, .dimensions = 1) {

  # Variables
  num_walks <- as.integer(.num_walks)
  t <- as.integer(.n)
  upper_bound <- as.numeric(.upper_bound)
  lower_bound <- as.numeric(.lower_bound)
  upper_probability <- as.numeric(.upper_probability)
  lower_probability <- 1 - upper_probability
  initial_value <- as.numeric(.initial_value)
  dimensions <- as.integer(.dimensions)

  # Checks
  if (!is.integer(num_walks) | num_walks < 1) {
    rlang::abort(
      message = "The number of walks must be an integer greater than 0.",
      use_cli_format = TRUE
    )
  }

  if (!is.integer(t) | t < 1) {
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

  if (!is.integer(dimensions) | dimensions < 1 | dimensions > 3) {
    rlang::abort(
      message = "The number of dimensions must be an integer between 1 and 3.",
      use_cli_format = TRUE
    )
  }

  if (!.dimensions %in% c(1, 2, 3)) {
    rlang::abort(
      message = "The number of dimensions must be an integer between 1 and 3.",
      use_cli_format = TRUE
    )
  }

  # Define dimension names
  dim_names <- switch(.dimensions,
                      `1` = c("y"),
                      `2` = c("x", "y"),
                      `3` = c("x", "y", "z"))

  # Generate walks for each dimension
  single_discrete_walk <- function(t, upper_bound, lower_bound,
                                   upper_probability, lower_probability){
    rand_steps <- purrr::map(
      dim_names,
      ~ replicate(
        n = t,
        sample(
          x = c(upper_bound, lower_bound),
          size = 1,
          prob = c(upper_probability, lower_probability))
      )
    )

    # Set Column Names
    rand_walk_column_names(rand_steps, dim_names, num_walks, t)
  }

  # Generate walks
  walks <- purrr::map(
    1:num_walks,
    ~ single_discrete_walk(t, upper_bound, lower_bound,
                           upper_probability, lower_probability)
  )

  # Create a tibble with all walks for all dimensions
  res <- dplyr::bind_rows(walks, .id = "walk_number") |>
    dplyr::mutate(walk_number = factor(walk_number, levels = 1:num_walks)) |>
    dplyr::group_by(walk_number) |>
    dplyr::select(walk_number, step_number, dplyr::all_of(dim_names))
  res <- res |>
    dplyr::group_by(walk_number) |>
    std_cum_sum_augment(.value = dplyr::all_of(dim_names), .initial_value = initial_value) |>
    dplyr::ungroup()
  res <- res |>
    dplyr::group_by(walk_number) |>
    std_cum_prod_augment(.value = dplyr::all_of(dim_names), .initial_value = initial_value) |>
    dplyr::ungroup()
  res <- res |>
    dplyr::group_by(walk_number) |>
    std_cum_min_augment(.value = dplyr::all_of(dim_names), .initial_value = initial_value) |>
    dplyr::ungroup()
  res <- res |>
    dplyr::group_by(walk_number) |>
    std_cum_max_augment(.value = dplyr::all_of(dim_names), .initial_value = initial_value) |>
    dplyr::ungroup()
  res <- res |>
    dplyr::group_by(walk_number) |>
    std_cum_mean_augment(.value = dplyr::all_of(dim_names), .initial_value = initial_value) |>
    dplyr::ungroup()

  # Attributes
  attr(res, "n")             <- t
  attr(res, "num_walks")     <- num_walks
  attr(res, "upper_bound")   <- upper_bound
  attr(res, "lower_bound")   <- lower_bound
  attr(res, "upper_probability") <- upper_probability
  attr(res, "lower_probability") <- lower_probability
  attr(res, "initial_value") <- initial_value
  attr(res, "fns")           <- "discrete_walk"
  attr(res, "dimension")     <- dimensions

  # Return
  return(res)

}
