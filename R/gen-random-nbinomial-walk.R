#' Generate Multiple Random Negative Binomial Walks
#'
#' @family Generator Functions
#' @family Discrete Distribution
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' The `random_negbinomial_walk` function generates multiple random walks in
#' 1, 2, or 3 dimensions. Each walk is a sequence of steps where each step is
#' a random draw from the Negative Binomial distribution using `stats::rnbinom()`.
#' The user can specify the number of samples in each walk (`n`), the size parameter,
#' the probability of success (`prob`), and/or the mean (`mu`), and the number of
#' dimensions. The function also allows for sampling a proportion of the steps and
#' optionally sampling with replacement.
#'
#' @description
#' A Negative Binomial random walk is a stochastic process in which each step is
#' drawn from the Negative Binomial distribution, commonly used for modeling count
#' data with overdispersion. This function allows for the simulation of multiple
#' independent random walks in one, two, or three dimensions, with user control over
#' the number of walks, steps, and the distribution parameters. Sampling options
#' allow for further customization, including the ability to sample a proportion of
#' steps and to sample with or without replacement. The resulting data frame includes
#' cumulative statistics for each walk, making it suitable for simulation studies and
#' visualization.
#'
#' @param .num_walks An integer specifying the number of random walks to
#' generate. Default is 25.
#' @param .n Integer. Number of random variables to return for each walk. Default is 100.
#' @param .size Integer. Number of successful trials or dispersion parameter. Default is 1.
#' This must also match the number of dimensions, for example if `.dimensions = 3`, then
#' .size must be a vector of length 3 like `c(1, 2, 3)`.
#' @param .prob Numeric. Probability of success in each trial (0 < prob <= 1). Default is 0.5.
#' This must also match the number of dimensions, for example if `.dimensions = 3`, then
#' .prob must be a vector of length 3 like `c(0.5, 0.7, 0.9)`.
#' @param .mu Numeric. Alternative parametrization via mean. Default is NULL.
#' This must also match the number of dimensions, for example if `.dimensions = 3`, then
#' .mu must be a vector of length 3 like `c(1, 2, 3)`.
#' @param .initial_value Numeric. Starting value of the walk. Default is 0.
#' @param .samp Logical. Whether to sample the steps. Default is TRUE.
#' @param .replace Logical. Whether sampling is with replacement. Default is TRUE.
#' @param .sample_size Numeric. Proportion of steps to sample (0-1). Default is 0.8.
#' @param .dimensions Integer. Number of dimensions (1, 2, or 3). Default is 1.
#'
#' @examples
#' set.seed(123)
#' random_negbinomial_walk()
#'
#' set.seed(123)
#' random_negbinomial_walk(.dimensions = 3,
#'   .size = c(1,2,3),
#'   .prob = c(0.5,0.7,0.9)
#'   ) |>
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
#' @name random_negbinomial_walk
NULL

#' @export
#' @rdname random_negbinomial_walk
random_negbinomial_walk <- function(.num_walks = 25, .n = 100,
                                    .size = 1, .prob = 0.5, .mu = NULL,
                                    .initial_value = 0, .samp = TRUE,
                                    .replace = TRUE, .sample_size = 0.8,
                                    .dimensions = 1) {

  # Defensive checks
  if (.num_walks < 0) {
    rlang::abort(".num_walks cannot be less than 0", use_cli_format = TRUE)
  }
  if (.n < 1) {
    rlang::abort(".n must be an integer of 1 or more", use_cli_format = TRUE)
  }
  if (any(.size < 1)) {
    rlang::abort(".size must be an integer of 1 or more", use_cli_format = TRUE)
  }
  if (is.null(.prob) && is.null(.mu)) {
    rlang::abort("Either .prob or .mu must be specified.", use_cli_format = TRUE)
  }
  if (!is.null(.prob) && !is.null(.mu)) {
    rlang::abort("Only one of .prob or .mu can be specified, not both.", use_cli_format = TRUE)
  }
  if (!is.null(.mu) && any(.mu < 0)) {
    rlang::abort(".mu must be non-negative if provided", use_cli_format = TRUE)
  }
  if (!is.null(.prob) && any(.prob <= 0 | .prob > 1)) {
    rlang::abort(".prob must be 0 < prob <= 1", use_cli_format = TRUE)
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
  # Fix from PR #202
  if (length(.size) != .dimensions) {
    rlang::abort("The length of .size must be equal to .dimensions.", use_cli_format = TRUE)
  }
  if (!is.null(.prob) && length(.prob) != .dimensions) {
    rlang::abort("The length of .prob must be equal to .dimensions.", use_cli_format = TRUE)
  }
  if (!is.null(.mu) && length(.mu) != .dimensions) {
    rlang::abort("The length of .mu must be equal to .dimensions.", use_cli_format = TRUE)
  }

  # Variables
  num_walks     <- as.integer(.num_walks)
  n             <- as.integer(.n)
  size          <- as.integer(.size)
  prob          <- if (!is.null(.prob)) as.numeric(.prob) else NULL
  mu            <- if (!is.null(.mu)) as.numeric(.mu) else NULL
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

  # --- Combine parameters into a data frame for pmap ---
  param_df <- tibble::tibble(
    size = size,
    prob = prob,
    mu   = mu
  )

  # --- Main function for pmap ---
  generate_walk <- function(walk_num){
    rand_steps <- purrr::pmap(
      param_df,
      function(size, prob, mu) {
        # Generate negative binomial samples
        if (!is.null(prob)) {
          vals <- stats::rnbinom(n, size = size, prob = prob)
        } else {
          vals <- stats::rnbinom(n, size = size, mu = mu)
        }
        # Optionally sample from the generated values
        if (samp) {
          sample(vals, size = periods, replace = replace)
        } else {
          vals
        }
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
    std_cum_sum_augment(
                        .value = dplyr::all_of(dim_names),
                        .initial_value = initial_value) |>
    dplyr::ungroup()
  res <- res |>
    dplyr::group_by(walk_number) |>
    std_cum_prod_augment(
                        .value = dplyr::all_of(dim_names),
                        .initial_value = initial_value) |>
    dplyr::ungroup()
  res <- res |>
    dplyr::group_by(walk_number) |>
    std_cum_min_augment(
                        .value = dplyr::all_of(dim_names),
                        .initial_value = initial_value) |>
    dplyr::ungroup()
  res <- res |>
    dplyr::group_by(walk_number) |>
    std_cum_max_augment(
                        .value = dplyr::all_of(dim_names),
                        .initial_value = initial_value) |>
    dplyr::ungroup()
  res <- res |>
    dplyr::group_by(walk_number) |>
    std_cum_mean_augment(
                        .value = dplyr::all_of(dim_names),
                        .initial_value = initial_value) |>
    dplyr::ungroup()

  # Add attributes
  attr(res, "n")             <- n
  attr(res, "num_walks")     <- num_walks
  attr(res, "size")          <- size
  attr(res, "prob")          <- prob
  attr(res, "mu")            <- mu
  attr(res, "initial_value") <- initial_value
  attr(res, "replace")       <- replace
  attr(res, "samp")          <- samp
  attr(res, "samp_size")     <- samp_size
  attr(res, "periods")       <- periods
  attr(res, "fns")           <- "random_negbinomial_walk"
  attr(res, "dimensions")    <- .dimensions

  # Return the result
  return(res)
}
