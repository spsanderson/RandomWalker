#' Generate Multiple Random Poisson Walks
#'
#' @family Generator Functions
#' @family Discrete Distribution
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' The `random_poisson_walk` function generates multiple random walks in
#' 1, 2, or 3 dimensions. Each walk is a sequence of steps where each step is
#' a random draw from the Poisson distribution using `base::rpois()`. The user
#' can specify the number of samples in each walk (`n`), the lambda parameter for
#' the Poisson distribution, and the number of dimensions. The function also allows
#' for sampling a proportion of the steps and optionally sampling with replacement.
#'
#' @description
#' A Poisson random walk is a stochastic process in which each step is drawn from
#' the Poisson distribution, commonly used for modeling count data. This function
#' allows for the simulation of multiple independent random walks in one, two, or
#' three dimensions, with user control over the number of walks, steps, and the
#' lambda parameter for the distribution. Sampling options allow for further
#' customization, including the ability to sample a proportion of steps and to
#' sample with or without replacement. The resulting data frame includes cumulative
#' statistics for each walk, making it suitable for simulation studies and
#' visualization.
#'
#' @param .num_walks An integer specifying the number of random walks to
#' generate. Default is 25.
#' @param .n Integer. Number of random variables to return for each walk. Default is 100.
#' @param .lambda Numeric or vector. Mean(s) for the Poisson distribution. Default is 1.
#' @param .initial_value Numeric. Starting value of the walk. Default is 0.
#' @param .samp Logical. Whether to sample the steps. Default is TRUE.
#' @param .replace Logical. Whether sampling is with replacement.
#' Default is TRUE.
#' @param .sample_size Numeric. Proportion of steps to sample (0-1). Default
#' is 0.8.
#' @param .dimensions Integer. Number of dimensions (1, 2, or 3). Default is
#' 1.
#'
#' @examples
#' set.seed(123)
#' random_poisson_walk()
#'
#' set.seed(123)
#' random_poisson_walk(.dimensions = 3, .lambda = c(1, 2, 3)) |>
#'    head() |>
#'    t()
#'
#' @return A tibble containing the generated random walks with columns depending
#' on the number of dimensions:
#' \itemize{
#'   \item `walk_number`: Factor representing the walk number.
#'   \item `step_number`: Step index.
#'   \item `y`: If `.dimensions = 1`, the value of the walk at each step.
#'   \item `x`, `y`: If `.dimensions = 2`, the values of the walk in
#'    two dimensions.
#'   \item `x`, `y`, `z`: If `.dimensions = 3`, the values of the walk
#'    in three dimensions.
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
#' @name random_poisson_walk
NULL

#' @export
#' @rdname random_poisson_walk
random_poisson_walk <- function(.num_walks = 25, .n = 100,
                                .lambda = 1, .initial_value = 0, .samp = TRUE,
                                .replace = TRUE, .sample_size = 0.8,
                                .dimensions = 1) {

  # Defensive checks
  if (.num_walks < 0) {
    rlang::abort(".num_walks cannot be less than 0", use_cli_format = TRUE)
  }

  if (.n < 0) {
    rlang::abort(".n cannot be less than 0", use_cli_format = TRUE)
  }

  if (any(.lambda < 0)) {
    rlang::abort(".lambda cannot be less than 0", use_cli_format = TRUE)
  }

  if (.sample_size < 0 || .sample_size > 1) {
    rlang::abort(
      ".sample_size cannot be less than 0 or more than 1",
      use_cli_format = TRUE
    )
  }
  if (!.dimensions %in% c(1, 2, 3)) {
    rlang::abort(
      "Number of dimensions must be 1, 2, or 3.",
      use_cli_format = TRUE
    )
  }

  # Variables
  num_walks     <- as.integer(.num_walks)
  n             <- as.integer(.n)
  lambda        <- as.numeric(.lambda)
  initial_value <- as.numeric(.initial_value)
  replace       <- as.logical(.replace)
  samp          <- as.logical(.samp)
  samp_size     <- round(.sample_size * n, 0)
  periods       <- if (.samp) samp_size else n

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
        sample(
          stats::rpois(n = n, lambda = lambda),
          size = periods, replace = replace
        )
      } else {
        stats::rpois(n, lambda)
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
  attr(res, "lambda")        <- lambda
  attr(res, "initial_value") <- initial_value
  attr(res, "replace")       <- replace
  attr(res, "samp")          <- samp
  attr(res, "samp_size")     <- samp_size
  attr(res, "periods")       <- periods
  attr(res, "fns")           <- "random_poisson_walk"
  attr(res, "dimensions")    <- .dimensions

  # Return the result
  return(res)
}
