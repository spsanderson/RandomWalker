#' Generate Multiple Random Multinomial Walks
#'
#' @family Generator Functions
#' @family Discrete Distribution
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' The `random_multinomial_walk` function generates multiple random walks using
#' the multinomial distribution via `stats::rmultinom()`. Each walk is a sequence
#' of steps where each step is a random draw from the multinomial distribution.
#' The user can specify the number of walks, steps, trials per step, and the
#' probability vector. Sampling options allow for further customization,
#' including the ability to sample a proportion of steps and to sample with or
#' without replacement. The resulting data frame includes cumulative statistics
#' for each walk, making it suitable for simulation studies and visualization.
#'
#' @description
#' A multinomial random walk is a stochastic process in which each step is drawn
#' from the multinomial distribution. This function allows for the simulation of
#' multiple independent random walks in one, two, or three dimensions, with user
#' control over the number of walks, steps, trials, probabilities, and dimensions.
#' Sampling options allow for further customization, including the ability to
#' sample a proportion of steps and to sample with or without replacement. The
#' resulting data frame includes cumulative statistics for each walk.
#'
#' @param .num_walks Integer. Number of random walks to generate. Default is 25.
#' @param .n Integer. Length of each walk (number of steps). Default is 100.
#' @param .size Integer. Number of trials for each multinomial draw. Default is 3.
#' @param .prob Numeric vector. Probabilities for each outcome. Default is rep(1/3, .n).
#' @param .initial_value Numeric. Starting value of the walk. Default is 0.
#' @param .samp Logical. Whether to sample the steps. Default is TRUE.
#' @param .replace Logical. Whether sampling is with replacement. Default is TRUE.
#' @param .sample_size Numeric. Proportion of steps to sample (0-1). Default is 0.8.
#' @param .dimensions Integer. Number of dimensions (1, 2, or 3). Default is 1.
#'
#' @examples
#' set.seed(123)
#' random_multinomial_walk()
#'
#' set.seed(123)
#' random_multinomial_walk(.dimensions = 3) |>
#'   head() |>
#'   t()
#'
#' @return A tibble containing the generated random walks with columns:
#'   \itemize{
#'     \item `walk_number`: Factor representing the walk number.
#'     \item `step_number`: Step index.
#'     \item `value`: Value of the walk at each step.
#'     \item Cumulative statistics: cum_sum, cum_prod, cum_min, cum_max, cum_mean.
#'   }
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
#' @export
random_multinomial_walk <- function(.num_walks = 25, .n = 100, .size = 3,
                                    .prob = rep(1/3, .n), .initial_value = 0,
                                    .samp = TRUE, .replace = TRUE,
                                    .sample_size = 0.8, .dimensions = 1) {

  # Defensive checks
  if (.num_walks < 0) {
    rlang::abort(".num_walks cannot be less than 0", use_cli_format = TRUE)
  }
  if (.n < 0) {
    rlang::abort(".n cannot be less than 0", use_cli_format = TRUE)
  }
  if (.size < 1) {
    rlang::abort(".size must be at least 1", use_cli_format = TRUE)
  }
  if (length(.prob) != .n) {
    rlang::abort("Length of .prob must equal .n", use_cli_format = TRUE)
  }
  if (.sample_size < 0 || .sample_size > 1) {
    rlang::abort(".sample_size must be between 0 and 1", use_cli_format = TRUE)
  }
  if (!.dimensions %in% c(1, 2, 3)) {
    rlang::abort("Number of dimensions must be 1, 2, or 3.", use_cli_format = TRUE)
  }

  # Variables
  num_walks     <- as.integer(.num_walks)
  n             <- as.integer(.n)
  size          <- as.integer(.size)
  prob          <- as.numeric(.prob)
  initial_value <- as.numeric(.initial_value)
  replace       <- as.logical(.replace)
  samp          <- as.logical(.samp)
  samp_size     <- round(.sample_size * n, 0)
  periods       <- if (samp) samp_size else n

  # Define dimension names
  dim_names <- switch(.dimensions,
                      `1` = c("y"),
                      `2` = c("x", "y"),
                      `3` = c("x", "y", "z"))

  # Function to generate a single random walk
  generate_walk <- function(walk_num) {
    rand_steps <- purrr::map(
      dim_names,
      ~ {
        steps <- stats::rmultinom(n = 1, size = size, prob = prob)
        steps <- as.vector(steps)
        if (samp) {
          steps <- sample(steps, size = periods, replace = replace)
        }
        steps
      }
    )
    # Set column names
    rand_walk_column_names(rand_steps, dim_names, num_walks, periods)
  }

  # Generate all walks
  res <- purrr::map_dfr(1:num_walks, generate_walk)
  res <- res |>
    dplyr::mutate(walk_number = factor(walk_number, levels = 1:num_walks))
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
  attr(res, "n")             <- n
  attr(res, "num_walks")     <- num_walks
  attr(res, "size")          <- size
  attr(res, "initial_value") <- initial_value
  attr(res, "replace")       <- replace
  attr(res, "samp")          <- samp
  attr(res, "samp_size")     <- samp_size
  attr(res, "periods")       <- periods
  attr(res, "fns")           <- "random_multinomial_walk"
  attr(res, "dimensions")    <- .dimensions

  # Return the result
  return(res)
}
