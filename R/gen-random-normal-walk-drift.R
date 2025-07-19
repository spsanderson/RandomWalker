#' Generate Multiple Random Walks with Drift
#'
#' @family Generator Functions
#' @family Continuous Distribution
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' This function generates multiple random walks with a specified drift.
#' Each walk is generated using a normal distribution for the steps, with an
#' additional drift term added to each step.
#'
#' @description
#' This function generates a specified number of random walks, each consisting
#' of a specified number of steps. The steps are generated from a normal
#' distribution with a given mean and standard deviation. An additional drift
#' term is added to each step to introduce a consistent directional component
#' to the walks.
#'
#' @param .num_walks Integer. The number of random walks to generate. Default is 25.
#' @param .n Integer. The number of steps in each random walk. Default is 100.
#' @param .mu Numeric. The mean of the normal distribution used for generating steps. Default is 0.
#' @param .sd Numeric. The standard deviation of the normal distribution used for generating steps. Default is 1.
#' @param .drift Numeric. The drift term to be added to each step. Default is 0.1.
#' @param .initial_value A numeric value indicating the initial value of the walks. Default is 0.
#' @param .dimensions The default is 1. Allowable values are 1, 2 and 3.
#'
#' @examples
#' set.seed(123)
#' random_normal_drift_walk()
#'
#' set.seed(123)
#' random_normal_drift_walk(.dimensions = 3) |>
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
#' The following are also returned based upon how many dimensions there are and could be any of x, y and or z:
#' \itemize{
#'   \item `cum_sum`: Cumulative sum of `dplyr::all_of(.dimensions)`.
#'   \item `cum_prod`: Cumulative product of `dplyr::all_of(.dimensions)`.
#'   \item `cum_min`: Cumulative minimum of `dplyr::all_of(.dimensions)`.
#'   \item `cum_max`: Cumulative maximum of `dplyr::all_of(.dimensions)`.
#'   \item `cum_mean`: Cumulative mean of `dplyr::all_of(.dimensions)`.
#' }
#'
#' @name random_normal_drift_walk
NULL
#' @rdname random_normal_drift_walk
#' @export

random_normal_drift_walk <- function(.num_walks = 25, .n = 100, .mu = 0, .sd = 1,
                                     .drift = 0.1, .initial_value = 0, .dimensions = 1) {

  # Convert inputs to appropriate types
  num_walks <- as.integer(.num_walks)
  num_steps <- as.integer(.n)
  mu <- as.numeric(.mu)
  sd <- as.numeric(.sd)
  drift <- as.numeric(.drift)
  initial_value <- as.numeric(.initial_value)

  # Checks
  if (num_walks <= 0) {
    rlang::abort("Number of walks must be a positive integer.", use_cli_format = TRUE)
  }
  if (num_steps <= 0) {
    rlang::abort("Number of steps must be a positive integer.", use_cli_format = TRUE)
  }
  if (sd <= 0) {
    rlang::abort("Standard deviation must be a positive number.", use_cli_format = TRUE)
  }
  if (is.na(mu)) {
    rlang::abort("Mean must be a number.", use_cli_format = TRUE)
  }
  if (is.na(drift)) {
    rlang::abort("Drift must be a number.", use_cli_format = TRUE)
  }
  if (is.na(initial_value)) {
    rlang::abort("Initial value must be a number.", use_cli_format = TRUE)
  }
  if (!.dimensions %in% c(1, 2, 3)) {
    rlang::abort("Number of dimensions must be 1, 2, or 3.", use_cli_format = TRUE)
  }

  # Create drift sequences for each dimension
  dr <- purrr::map(
    1:.dimensions,
    ~ seq(from = drift, to = drift * num_steps, length.out = num_steps)
  )

  # Define dimension names
  dim_names <- switch(.dimensions,
                      `1` = c("y"),
                      `2` = c("x", "y"),
                      `3` = c("x", "y", "z"))

  # Function to generate a single random walk with drift for multiple dimensions
  single_random_walk_with_drift <- function(num_steps, mu, sd, dr) {
    walks_per_dim <- purrr::map2(dr, dim_names, function(drift_seq, dim) {
      wn <- stats::rnorm(n = num_steps, mean = mu, sd = sd)
      rw <- cumsum(wn)
      res <- wn + rw + drift_seq
      res
    })

    # Set Column Names
    rand_walk_column_names(walks_per_dim, dim_names, num_walks, num_steps)
  }

  # Generate all walks for each dimension
  walks <- purrr::map(
    1:num_walks,
    ~ single_random_walk_with_drift(num_steps, mu, sd, dr)
  )


  # Create a tibble with all walks for all dimensions
  res <- dplyr::bind_rows(walks, .id = "walk_number") |>
    dplyr::mutate(walk_number = factor(walk_number, levels = 1:num_walks)) |>
    dplyr::group_by(walk_number) |>
    dplyr::mutate(step_number = 1:num_steps) |>
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

  # Add attributes
  attr(res, "n") <- num_steps
  attr(res, "num_walks") <- num_walks
  attr(res, "mu") <- mu
  attr(res, "sd") <- sd
  attr(res, "drift") <- drift
  attr(res, "fns") <- "random_normal_drift_walk"
  attr(res, "dimensions") <- .dimensions

  return(res)
}
