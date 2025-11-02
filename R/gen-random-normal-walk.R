#' Generate Multiple Random Normal Walks in Multiple Dimensions
#'
#' @family Generator Functions
#' @family Continuous Distribution
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' The `random_normal_walk` function generates multiple random walks in 1, 2, or 3 dimensions.
#' Each walk is a sequence of steps where each step is a random draw from a normal distribution.
#' The user can specify the number of walks, the number of steps in each walk, and the
#' parameters of the normal distribution (mean and standard deviation). The function
#' also allows for sampling a proportion of the steps and optionally sampling with replacement.
#'
#' @param .num_walks An integer specifying the number of random walks to generate. Default is 25.
#' @param .n An integer specifying the number of steps in each walk. Default is 100.
#' @param .mu A numeric value indicating the mean of the normal distribution. Default is 0.
#' @param .sd A numeric value indicating the standard deviation of the normal distribution. Default is 0.1.
#' @param .initial_value A numeric value indicating the initial value of the walks. Default is 0.
#' @param .samp A logical value indicating whether to sample the normal distribution values. Default is TRUE.
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
#' random_normal_walk()
#'
#' set.seed(123)
#' random_normal_walk(.dimensions = 3) |>
#'   head() |>
#'   t()
#'
#' @export
#' @rdname random_normal_walk
random_normal_walk <- function(.num_walks = 25, .n = 100, .mu = 0, .sd = 0.1,
                               .initial_value = 0, .samp = TRUE, .replace = TRUE,
                               .sample_size = 0.8, .dimensions = 1) {

  # Defensive checks
  if (.num_walks < 0) {
    rlang::abort(".num_walks cannot be less than 0", use_cli_format = TRUE)
  }
  if (.n < 0) {
    rlang::abort(".n cannot be less than 0", use_cli_format = TRUE)
  }
  if (.mu < 0) {
    rlang::abort(".mu cannot be less than 0", use_cli_format = TRUE)
  }
  if (.sd < 0) {
    rlang::abort(".sd cannot be less than 0", use_cli_format = TRUE)
  }
  if (.sample_size < 0 || .sample_size > 1) {
    rlang::abort(".sample_size cannot be less than 0 or more than 1",
                 use_cli_format = TRUE)
  }
  if (!.dimensions %in% c(1, 2, 3)) {
    rlang::abort("Number of dimensions must be 1, 2, or 3.", use_cli_format = TRUE)
  }

  # Variables
  num_walks     <- as.integer(.num_walks)
  n             <- as.integer(.n)
  mu            <- as.numeric(.mu)
  sd            <- as.numeric(.sd)
  initial_value <- as.numeric(.initial_value)
  replace       <- as.logical(.replace)
  samp          <- as.logical(.samp)
  samp_size     <- round(.sample_size * n, 0)
  t       <- if (samp) samp_size else n

  # Define dimension names
  dim_names <- switch(.dimensions,
                      `1` = c("y"),
                      `2` = c("x", "y"),
                      `3` = c("x", "y", "z"))

  # Function to generate a single random walk
  generate_walk <- function(walk_num) {
    # Generate random steps for each dimension
    rand_steps <- purrr::map(
      dim_names,
      ~ if (samp) {
        sample(stats::rnorm(n, mu, sd), size = t, replace = replace)
      } else {
        stats::rnorm(t, mu, sd)
      }
    )

    # Set column names
    rand_walk_column_names(rand_steps, dim_names, walk_num, t)
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
  attr(res, "mu")            <- mu
  attr(res, "sd")            <- sd
  attr(res, "initial_value") <- initial_value
  attr(res, "replace")       <- replace
  attr(res, "samp")          <- samp
  attr(res, "samp_size")     <- samp_size
  attr(res, "periods")       <- t
  attr(res, "fns")           <- "random_normal_walk"
  attr(res, "dimensions")    <- .dimensions

  # Return the result
  return(res)
}
