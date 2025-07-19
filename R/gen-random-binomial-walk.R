#' Generate Multiple Random Binomial Walks in Multiple Dimensions
#'
#' @family Generator Functions
#' @family Discrete Distribution
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' The `random_binomial_walk` function generates multiple random walks using the binomial distribution via `rbinom()`.
#' The user can specify the number of walks, the number of steps in each walk, the number of trials, and the probability of success.
#' The function also allows for sampling a proportion of the steps and optionally sampling with replacement.
#'
#' @details
#' This function generates random walks where each step is drawn from the binomial distribution using `rbinom()`.
#' The user can control the number of walks, steps per walk, the number of trials (`size`), and the probability of success (`prob`).
#' The function supports 1, 2, or 3 dimensions, and augments the output with cumulative statistics for each walk.
#' Sampling can be performed with or without replacement, and a proportion of steps can be sampled if desired.
#'
#' @param .num_walks An integer specifying the number of random walks to generate. Default is 25.
#' @param .n An integer specifying the number of observations per walk. Must be greater than 0. Default is 100.
#' @param .size An integer specifying the number of trials (zero or more). Default is 10.
#' @param .prob A numeric value specifying the probability of success on each trial. Must be 0 <= .prob <= 1. Default is 0.5.
#' @param .initial_value A numeric value indicating the initial value of the walks. Default is 0.
#' @param .samp A logical value indicating whether to sample the binomial values. Default is TRUE.
#' @param .replace A logical value indicating whether sampling is with replacement. Default is TRUE.
#' @param .sample_size A numeric value between 0 and 1 specifying the proportion of `.n` to sample. Default is 0.8.
#' @param .dimensions An integer specifying the number of dimensions (1, 2, or 3). Default is 1.
#'
#' @return A tibble containing the generated random walks with columns depending on the number of dimensions:
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
#' The tibble includes attributes for the function parameters.
#'
#' @examples
#' set.seed(123)
#' random_binomial_walk()
#'
#' set.seed(123)
#' random_binomial_walk(.dimensions = 2) |>
#'   head() |>
#'   t()
#'
#' @export
random_binomial_walk <- function(
  .num_walks = 25, .n = 100, .size = 10, .prob = 0.5,
  .initial_value = 0, .samp = TRUE, .replace = TRUE, .sample_size = 0.8, .dimensions = 1
) {
  # Defensive checks
  if (.num_walks <= 0) {
    rlang::abort(".num_walks cannot be less than or equal to 0", use_cli_format = TRUE)
  }
  if (.n <= 0) {
    rlang::abort(".n must be greater than 0", use_cli_format = TRUE)
  }
  if (.size < 0) {
    rlang::abort(".size must be zero or more", use_cli_format = TRUE)
  }
  if (.prob < 0 || .prob > 1) {
    rlang::abort(".prob must be in the interval [0, 1]", use_cli_format = TRUE)
  }
  if (.sample_size < 0 || .sample_size > 1) {
    rlang::abort(".sample_size cannot be less than 0 or more than 1", use_cli_format = TRUE)
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
      ~ if (samp) {
        sample(stats::rbinom(n, size, prob), size = periods, replace = replace)
      } else {
        stats::rbinom(periods, size, prob)
      }
    )
    rand_walk_column_names(rand_steps, dim_names, walk_num, periods)
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
  attr(res, "prob")          <- prob
  attr(res, "initial_value") <- initial_value
  attr(res, "replace")       <- replace
  attr(res, "samp")          <- samp
  attr(res, "samp_size")     <- samp_size
  attr(res, "periods")       <- periods
  attr(res, "fns")           <- "random_binomial_walk"
  attr(res, "dimensions")    <- .dimensions

  # Return the result
  return(res)
}
