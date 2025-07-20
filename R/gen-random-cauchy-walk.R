##' Generate Multiple Random Cauchy Walks in Multiple Dimensions
##'
##' @family Generator Functions
##' @family Continuous Distribution
##'
##' @author Steven P. Sanderson II, MPH
##'
##' @description
##' The `random_cauchy_walk` function generates multiple random walks in 1, 2, or 3 dimensions.
##' Each walk is a sequence of steps where each step is a random draw from a Cauchy distribution.
##' The user can specify the number of walks, the number of steps in each walk, and the
##' parameters of the Cauchy distribution (location and scale). The function
##' also allows for sampling a proportion of the steps and optionally sampling with replacement.
##'
##' @param .num_walks An integer specifying the number of random walks to generate. Default is 25.
##' @param .n An integer specifying the number of steps in each walk. Default is 100.
##' @param .location A numeric value indicating the location parameter of the Cauchy distribution. Default is 0.
##' @param .scale A numeric value indicating the scale parameter of the Cauchy distribution. Default is 1.
##' @param .initial_value A numeric value indicating the initial value of the walks. Default is 0.
##' @param .samp A logical value indicating whether to sample the Cauchy distribution values. Default is TRUE.
##' @param .replace A logical value indicating whether sampling is with replacement. Default is TRUE.
##' @param .sample_size A numeric value between 0 and 1 specifying the proportion of `.n` to sample. Default is 0.8.
##' @param .dimensions An integer specifying the number of dimensions (1, 2, or 3). Default is 1.
##'
##' @return A tibble containing the generated random walks with columns depending on the number of dimensions:
##' \itemize{
##'   \item `walk_number`: Factor representing the walk number.
##'   \item `step_number`: Step index.
##'   \item `y`: If `.dimensions = 1`, the value of the walk at each step.
##'   \item `x`, `y`: If `.dimensions = 2`, the values of the walk in two dimensions.
##'   \item `x`, `y`, `z`: If `.dimensions = 3`, the values of the walk in three dimensions.
##' }
##'
##' The following are also returned based upon how many dimensions there are and could be any of x, y and or z:
##' \itemize{
##'   \item `cum_sum`: Cumulative sum of `dplyr::all_of(.dimensions)`.
##'   \item `cum_prod`: Cumulative product of `dplyr::all_of(.dimensions)`.
##'   \item `cum_min`: Cumulative minimum of `dplyr::all_of(.dimensions)`.
##'   \item `cum_max`: Cumulative maximum of `dplyr::all_of(.dimensions)`.
##'   \item `cum_mean`: Cumulative mean of `dplyr::all_of(.dimensions)`.
##' }
##'
##' The tibble includes attributes for the function parameters.
##'
##' @details
##' The `location` and `scale` parameters can be single values or vectors of length equal to the number of dimensions. If vectors are provided, each dimension uses its corresponding value.
##'
##' @examples
##' set.seed(123)
##' random_cauchy_walk()
##'
##' set.seed(123)
##' random_cauchy_walk(.dimensions = 3, .location = c(0, 1, 2), .scale = c(1, 2, 3)) |>
##'   head() |>
##'   t()
##'
##' @export
##' @rdname random_cauchy_walk
random_cauchy_walk <- function(
  .num_walks = 25,
  .n = 100,
  .location = 0,
  .scale = 1,
  .initial_value = 0,
  .samp = TRUE,
  .replace = TRUE,
  .sample_size = 0.8,
  .dimensions = 1
) {
  # Defensive checks
  if (.num_walks < 0) {
    rlang::abort(".num_walks cannot be less than 0", use_cli_format = TRUE)
  }
  if (.n < 0) {
    rlang::abort(".n cannot be less than 0", use_cli_format = TRUE)
  }
  if (any(.scale <= 0)) {
    rlang::abort(".scale must be greater than 0", use_cli_format = TRUE)
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
  location      <- .location
  scale         <- .scale
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

  # Expand location and scale to match dimensions
  if (length(location) == 1) {
    location <- rep(location, .dimensions)
  } else if (length(location) != .dimensions) {
    rlang::abort("Length of .location vector must match number of dimensions.", use_cli_format = TRUE)
  }
  if (length(scale) == 1) {
    scale <- rep(scale, .dimensions)
  } else if (length(scale) != .dimensions) {
    rlang::abort("Length of .scale vector must match number of dimensions.", use_cli_format = TRUE)
  }

  # Function to generate a single random walk
  generate_walk <- function(walk_num) {
    rand_steps <- purrr::pmap(
      list(dim_names, location, scale),
      function(dim, loc, sc) {
        if (samp) {
          sample(stats::rcauchy(n, location = loc, scale = sc), size = periods,
                 replace = replace)
        } else {
          stats::rcauchy(periods, location = loc, scale = sc)
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
  attr(res, "location")      <- location
  attr(res, "scale")         <- scale
  attr(res, "initial_value") <- initial_value
  attr(res, "replace")       <- replace
  attr(res, "samp")          <- samp
  attr(res, "samp_size")     <- samp_size
  attr(res, "periods")       <- periods
  attr(res, "fns")           <- "random_cauchy_walk"
  attr(res, "dimensions")    <- .dimensions

  # Return the result
  return(res)
}
