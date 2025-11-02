#' Generate Multiple Random Gamma Walks in Multiple Dimensions
#'
#' @family Generator Functions
#' @family Continuous Distribution
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' The `random_gamma_walk` function generates multiple random walks in 1, 2, or 3 dimensions.
#' Each walk is a sequence of steps where each step is a random draw from a gamma distribution.
#' The user can specify the number of walks, the number of steps in each walk, and the
#' parameters of the gamma distribution (shape, scale, rate). The function
#' also allows for sampling a proportion of the steps and optionally sampling with replacement.
#'
#' @details
#' This function is a flexible generator for random walks where each step is drawn from a gamma distribution.
#' The user can control the number of walks, steps per walk, and the shape, scale, and rate parameters for the distribution.
#' The function supports 1, 2, or 3 dimensions, and augments the output with cumulative statistics for each walk.
#' Sampling can be performed with or without replacement, and a proportion of steps can be sampled if desired.
#'
#' @param .num_walks An integer specifying the number of random walks to generate. Default is 25.
#' @param .n An integer specifying the number of steps in each walk. Must be greater than 0. Default is 100.
#' @param .shape A positive numeric value for the shape parameter. Default is 1.
#' @param .scale A positive numeric value for the scale parameter. Default is 1.
#' @param .rate A positive numeric value for the rate parameter. Default is NULL (ignored if scale is provided).
#' @param .initial_value A numeric value indicating the initial value of the walks. Default is 0.
#' @param .samp A logical value indicating whether to sample the gamma distribution values. Default is TRUE.
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
#' random_gamma_walk()
#'
#' set.seed(123)
#' random_gamma_walk(.dimensions = 3) |>
#'   head() |>
#'   t()
#'
#' @export
random_gamma_walk <- function(
  .num_walks = 25, .n = 100, .shape = 1, .scale = 1, .rate = NULL,
  .initial_value = 0, .samp = TRUE, .replace = TRUE, .sample_size = 0.8, .dimensions = 1
) {
  # Defensive checks
  if (.num_walks < 0) {
    rlang::abort(".num_walks cannot be less than 0", use_cli_format = TRUE)
  }
  if (.n <= 0) {
    rlang::abort(".n must be greater than 0", use_cli_format = TRUE)
  }
  if (.shape <= 0) {
    rlang::abort(".shape must be positive", use_cli_format = TRUE)
  }
  if (!is.null(.scale) && .scale <= 0) {
    rlang::abort(".scale must be positive", use_cli_format = TRUE)
  }
  if (!is.null(.rate) && .rate <= 0) {
    rlang::abort(".rate must be positive if provided", use_cli_format = TRUE)
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
  shape         <- as.numeric(.shape)
  scale         <- as.numeric(.scale)
  rate          <- if (is.null(.rate)) NULL else as.numeric(.rate)
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
        draws <- if (!is.null(rate)) {
          stats::rgamma(if (samp) n else periods, shape = shape, rate = rate)
        } else {
          stats::rgamma(if (samp) n else periods, shape = shape, scale = scale)
        }

        if (samp) {
          sample(draws, size = periods, replace = replace)
        } else {
          draws
        }
      }
    )
    rand_walk_column_names(rand_steps, dim_names, walk_num, periods)
  }

  # Generate all walks
  res <- purrr::map_dfr(1:num_walks, generate_walk)
  res <- res |>
    dplyr::mutate(walk_number = factor(walk_number, levels = 1:num_walks))
  
  # Compute all cumulative statistics in a single grouped operation for performance
  # This approach is ~4-5x faster than separate group_by operations
  cum_exprs <- list()
  for (col in dim_names) {
    cum_exprs[[paste0("cum_sum_", col)]] <- rlang::expr(!!initial_value + cumsum(!!rlang::sym(col)))
    cum_exprs[[paste0("cum_prod_", col)]] <- rlang::expr(!!initial_value * cumprod(1 + !!rlang::sym(col)))
    cum_exprs[[paste0("cum_min_", col)]] <- rlang::expr(!!initial_value + cummin(!!rlang::sym(col)))
    cum_exprs[[paste0("cum_max_", col)]] <- rlang::expr(!!initial_value + cummax(!!rlang::sym(col)))
    cum_exprs[[paste0("cum_mean_", col)]] <- rlang::expr(!!initial_value + cmean(!!rlang::sym(col)))
  }
  
  res <- res |>
    dplyr::group_by(walk_number) |>
    dplyr::mutate(!!!cum_exprs) |>
    dplyr::ungroup() |>
    dplyr::as_tibble()

  # Add attributes
  attr(res, "n")             <- n
  attr(res, "num_walks")     <- num_walks
  attr(res, "shape")         <- shape
  attr(res, "scale")         <- scale
  attr(res, "rate")          <- rate
  attr(res, "initial_value") <- initial_value
  attr(res, "replace")       <- replace
  attr(res, "samp")          <- samp
  attr(res, "samp_size")     <- samp_size
  attr(res, "periods")       <- periods
  attr(res, "fns")           <- "random_gamma_walk"
  attr(res, "dimensions")    <- .dimensions

  # Return the result
  return(res)
}
