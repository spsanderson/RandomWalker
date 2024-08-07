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
#' @param .return_tibble The default is TRUE. If set to FALSE then an object
#' of class matrix will be returned.
#'
#' @examples
#' library(ggplot2)
#'
#' set.seed(123)
#' geometric_brownian_motion()
#'
#' set.seed(123)
#' geometric_brownian_motion() |>
#'   ggplot(aes(x = x, y = y, group = walk_number, color = walk_number)) +
#'   geom_line() +
#'   labs(title = "Geometric Brownian Motion", x = "Time", y = "Value") +
#'   theme_minimal() +
#'   theme(legend.position = "none")
#'
#' @return
#' A tibble/matrix
#'
#' @name geometric_brownian_motion
NULL

#' @export
#' @rdname geometric_brownian_motion

geometric_brownian_motion <- function(.num_walks = 25, .n = 100,
                                         .mu = 0, .sigma = 0.1,
                                         .initial_value = 100,
                                         .delta_time = 0.003,
                                         .return_tibble = TRUE) {

  # Tidyeval ----
  # Thank you to https://robotwealth.com/efficiently-simulating-geometric-brownian-motion-in-r/
  num_sims <- as.numeric(.num_walks)
  t <- as.numeric(.n)
  mu <- as.numeric(.mu)
  sigma <- as.numeric(.sigma)
  initial_value <- as.numeric(.initial_value)
  delta_time <- as.numeric(.delta_time)
  return_tibble <- as.logical(.return_tibble)

  # Checks ----
  if (!is.logical(return_tibble)){
    rlang::abort(
      message = "The paramter `.return_tibble` must be either TRUE/FALSE",
      use_cli_format = TRUE
    )
  }

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

  # matrix of random draws - one for each day for each simulation
  rand_matrix <- matrix(stats::rnorm(t * num_sims), ncol = num_sims, nrow = t)
  colnames(rand_matrix) <- 1:num_sims

  # get GBM and convert to price paths
  res <- exp((mu - sigma * sigma / 2) * delta_time + sigma * rand_matrix * sqrt(delta_time))
  res <- apply(rbind(rep(initial_value, num_sims), res), 2, cumprod)

  # Return
  if (return_tibble){
    res <- res |>
      dplyr::as_tibble() |>
      dplyr::mutate(t = 1:(t+1)) |>
      tidyr::pivot_longer(-t) |>
      dplyr::select(name, t, value) |>
      purrr::set_names("walk_number", "x", "y") |>
      dplyr::mutate(walk_number = factor(walk_number, levels = 1:num_sims)) |>
      dplyr::arrange(walk_number, x) |>
      rand_walk_helper(.value = initial_value) |>
      dplyr::select(-cum_sum, -cum_prod)
  }

  attr(res, "n") <- .n
  attr(res, "num_walks") <- .num_walks
  attr(res, "mean") <- .mu
  attr(res, "sigma") <- .sigma
  attr(res, "initial_value") <- .initial_value
  attr(res, "delta_time") <- .delta_time
  attr(res, "return_tibble") <- .return_tibble
  attr(res, "fns") <- "geometric_brownian_motion"
  attr(res, "dimension")     <- 1

  return(res)
}
