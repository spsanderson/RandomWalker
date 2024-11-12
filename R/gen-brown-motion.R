#' Brownian Motion
#'
#' @family Generator Functions
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description Create a Brownian Motion Tibble
#'
#' @details Brownian Motion, also known as the Wiener process, is a
#' continuous-time random process that describes the random movement of particles
#' suspended in a fluid. It is named after the physicist Robert Brown,
#' who first described the phenomenon in 1827.
#'
#' The equation for Brownian Motion can be represented as:
#'
#'     W(t) = W(0) + sqrt(t) * Z
#'
#' Where W(t) is the Brownian motion at time t, W(0) is the initial value of the
#' Brownian motion, sqrt(t) is the square root of time, and Z is a standard
#' normal random variable.
#'
#' Brownian Motion has numerous applications, including modeling stock prices in
#' financial markets, modeling particle movement in fluids, and modeling random
#' walk processes in general. It is a useful tool in probability theory and
#' statistical analysis.
#'
#' @param .n Total time of the simulation.
#' @param .num_walks Total number of simulations.
#' @param .delta_time Time step size.
#' @param .initial_value Integer representing the initial value.
#' @param .dimensions The default is 1. Allowable values are 1, 2 and 3.
#'
#' @examples
#' set.seed(123)
#' brownian_motion()
#'
#' set.seed(123)
#' brownian_motion(.dimensions = 3) |>
#'   head() |>
#'   t()
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
#' @name brownian_motion
NULL

#' @export
#' @rdname brownian_motion

brownian_motion <- function(.num_walks = 25, .n = 100, .delta_time = 1,
                            .initial_value = 0, .dimensions = 1) {

  # Tidyeval ----
  num_sims <- as.numeric(.num_walks)
  t <- as.numeric(.n)
  initial_value <- as.numeric(.initial_value)
  delta_time <- as.numeric(.delta_time)

  # Checks
  if (!is.numeric(num_sims) | !is.numeric(t) | !is.numeric(initial_value) |
      !is.numeric(delta_time)){
    rlang::abort(
      message = "The parameters `.num_walks`, `.n`, `.delta_time`, and `.initial_value` must be numeric.",
      use_cli_format = TRUE
    )
  }

  # .num_walks and .n must be >= 1
  if (num_sims < 1 | t < 1){
    rlang::abort(
      message = "The parameters of `.num_walks` and `.n` must be >= 1.",
      use_cli_format = TRUE
    )
  }

  # .delta_time must be > 0
  if (delta_time <= 0){
    rlang::abort(
      message = "The parameter `.delta_time` must be > 0.",
      use_cli_format = TRUE
    )
  }

  if (!.dimensions %in% c(1, 2, 3)) {
    rlang::abort("Number of dimensions must be 1, 2, or 3.", use_cli = TRUE)
  }

  # Define dimension names
  dim_names <- switch(.dimensions,
                      `1` = c("y"),
                      `2` = c("x", "y"),
                      `3` = c("x", "y", "z"))

  # Matrix of random draws - one for each simulation
  generate_brownian_motion <- function(num_sims) {
    rand_steps <- purrr::map(
      dim_names,
      ~ stats::rnorm(t, mean = 0, sd = sqrt(delta_time))
    )

    # Set column names
    # rand_steps <- stats::setNames(rand_steps, dim_names)
    # rand_steps <- purrr::map(rand_steps, \(x) dplyr::as_tibble(x)) |>
    #   purrr::list_cbind()
    # colnames(rand_steps) <- dim_names
    # rand_steps <- purrr::map(
    #   rand_steps, \(x) x |>
    #     unlist(use.names = FALSE)) |>
    #   dplyr::as_tibble()
    #
    # # Combine into a tibble
    # dplyr::tibble(
    #   walk_number = factor(num_sims),
    #   step_number = 1:t
    # ) |>
    #   dplyr::bind_cols(rand_steps)
    rand_walk_column_names(rand_steps, dim_names, num_sims, t)
  }

  # Get the Brownian Motion and convert to price paths
  res <- purrr::map(1:num_sims, ~ generate_brownian_motion(.x)) |>
    dplyr::bind_rows() |>
    dplyr::select(walk_number, step_number, dplyr::any_of(dim_names)) |>
    dplyr::mutate(walk_number = factor(walk_number, levels = 1:num_sims)) |>
    dplyr::group_by(walk_number) |>
    std_cum_sum_augment(.value = dplyr::all_of(dim_names), .initial_value = initial_value) |>
    std_cum_prod_augment(.value = dplyr::all_of(dim_names), .initial_value = initial_value) |>
    std_cum_min_augment(.value = dplyr::all_of(dim_names), .initial_value = initial_value) |>
    std_cum_max_augment(.value = dplyr::all_of(dim_names), .initial_value = initial_value) |>
    std_cum_mean_augment(.value = dplyr::all_of(dim_names), .initial_value = initial_value) |>
    dplyr::ungroup()

  # Return ----
  attr(res, "n") <- .n
  attr(res, "num_walks") <- .num_walks
  attr(res, "delta_time") <- .delta_time
  attr(res, "initial_value") <- .initial_value
  attr(res, "fns") <- "brownian_motion"
  attr(res, "dimension")     <- .dimensions

  return(res)
}
