#' Geometric Brownian Motion
#'
#' @family Generator Functions
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description Create a Geometric Brownian Motion.
#'
#' @details Geometric Brownian Motion (GBM) is a statistical method for modeling
#' the evolution of a given financial asset over time. It is a type of stochastic
#' process, which means that it is a system that undergoes random changes over
#' time.
#'
#' GBM is widely used in the field of finance to model the behavior of stock
#' prices, foreign exchange rates, and other financial assets. It is based on
#' the assumption that the asset's price follows a random walk, meaning that it
#' is influenced by a number of unpredictable factors such as market trends,
#' news events, and investor sentiment.
#'
#' The equation for GBM is:
#'
#'      dS/S = mdt + sdW
#'
#' where S is the price of the asset, t is time, m is the expected return on the
#' asset, s is the volatility of the asset, and dW is a small random change in
#' the asset's price.
#'
#' GBM can be used to estimate the likelihood of different outcomes for a given
#' asset, and it is often used in conjunction with other statistical methods to
#' make more accurate predictions about the future performance of an asset.
#'
#' This function provides the ability of simulating and estimating the parameters
#' of a GBM process. It can be used to analyze the behavior of financial
#' assets and to make informed investment decisions.
#'
#' @param .n Total time of the simulation, how many `n` points in time.
#' @param .num_walks Total number of simulations.
#' @param .delta_time Time step size.
#' @param .initial_value Integer representing the initial value.
#' @param .mu Expected return
#' @param .sigma Volatility
#' @param .dimensions The default is 1. Allowable values are 1, 2 and 3.
#'
#' @examples
#'
#' set.seed(123)
#' geometric_brownian_motion()
#'
#' set.seed(123)
#' geometric_brownian_motion(.dimensions = 3) |>
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
#' @name geometric_brownian_motion
NULL

#' @export
#' @rdname geometric_brownian_motion

geometric_brownian_motion <- function(.num_walks = 25, .n = 100,
                                         .mu = 0, .sigma = 0.1,
                                         .initial_value = 100,
                                         .delta_time = 0.003,
                                         .dimensions = 1) {

  # Tidyeval ----
  # Thank you to https://robotwealth.com/efficiently-simulating-geometric-brownian-motion-in-r/
  num_sims <- as.numeric(.num_walks)
  t <- as.numeric(.n)
  mu <- as.numeric(.mu)
  sigma <- as.numeric(.sigma)
  initial_value <- as.numeric(.initial_value)
  delta_time <- as.numeric(.delta_time)

  # Checks ----

  if (!is.numeric(num_sims) | !is.numeric(t) | !is.numeric(mu) |
      !is.numeric(sigma) | !is.numeric(initial_value) | !is.numeric(delta_time)){
    rlang::abort(
      message = "The parameters of `.n', `.num_walks`, `.mu`, `.sigma`,
            `.initial_value`, and `.delta_time` must be numeric.",
      use_cli_format = TRUE
    )
  }

  # .mu and .sigma and .detla_time must be >= 0
  if (mu < 0 | sigma < 0 | delta_time < 0){
    rlang::abort(
      message = "The parameters of `.mu`, `.sigma`, and `.delta_time` must be >= 0.",
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
  if (!.dimensions %in% c(1, 2, 3)) {
    rlang::abort("Number of dimensions must be 1, 2, or 3.", use_cli = TRUE)
  }

  # Define dimension names
  dim_names <- switch(.dimensions,
                      `1` = c("y"),
                      `2` = c("x", "y"),
                      `3` = c("x", "y", "z"))

  # matrix of random draws - one for each day for each simulation
  generate_gbm <- function(num_sims){
    rand_steps <- purrr::map(
      dim_names,
      ~ exp((mu - sigma * sigma / 2) * delta_time + sigma * stats::rnorm(t) * sqrt(delta_time)) |>
        cumprod()
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

  res <- purrr::map(1:num_sims, ~ generate_gbm(.x)) |>
    dplyr::bind_rows() |>
    dplyr::select(walk_number, step_number, dplyr::all_of(dim_names)) |>
    dplyr::group_by(walk_number) |>
    std_cum_min_augment(.value = dplyr::all_of(dim_names), .initial_value = initial_value) |>
    std_cum_max_augment(.value = dplyr::all_of(dim_names), .initial_value = initial_value) |>
    std_cum_mean_augment(.value = dplyr::all_of(dim_names), .initial_value = initial_value) |>
    dplyr::ungroup()

  # Return

  attr(res, "n") <- .n
  attr(res, "num_walks") <- .num_walks
  attr(res, "mean") <- .mu
  attr(res, "sigma") <- .sigma
  attr(res, "initial_value") <- .initial_value
  attr(res, "delta_time") <- .delta_time
  attr(res, "fns") <- "geometric_brownian_motion"
  attr(res, "dimension")     <- .dimensions

  return(res)
}
