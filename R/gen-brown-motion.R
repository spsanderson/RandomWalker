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
#' @param .return_tibble The default is TRUE. If set to FALSE then an object
#' of class matrix will be returned.
#'
#' @examples
#' library(ggplot2)
#'
#' brownian_motion()
#'
#' brownian_motion() |>
#'   ggplot(aes(x = x, y = y, group = walk_number, color = walk_number)) +
#'   geom_line() +
#'   labs(title = "Brownian Motion", x = "Time", y = "Value") +
#'   theme_minimal() +
#'   theme(legend.position = "none")
#'
#' @return
#' A tibble/matrix
#'
#' @name brownian_motion
NULL

#' @export
#' @rdname brownian_motion

brownian_motion <- function(.num_walks = 25, .n = 100, .delta_time = 1,
                               .initial_value = 0, .return_tibble = TRUE) {

  # Tidyeval ----
  num_sims <- as.numeric(.num_walks)
  t <- as.numeric(.n)
  initial_value <- as.numeric(.initial_value)
  delta_time <- as.numeric(.delta_time)
  return_tibble <- as.logical(.return_tibble)

  # Checks
  if (!is.numeric(num_sims) | !is.numeric(t) | !is.numeric(initial_value) |
      !is.numeric(delta_time)){
    rlang::abort(
      message = "The parameters `.num_walks`, `.n`, `.delta_time`, and `.initial_value` must be numeric.",
      use_cli_format = TRUE
    )
  }

  if (!is.logical(return_tibble)){
    rlang::abort(
      message = "The parameter `.return_tibble` must be either TRUE/FALSE",
      use_cli_format = TRUE
    )
  }

  # Matrix of random draws - one for each simulation
  rand_matrix <- matrix(rnorm(t * num_sims, mean = 0, sd = sqrt(delta_time)),
                        ncol = num_sims, nrow = t)
  colnames(rand_matrix) <- 1:num_sims

  # Get the Brownian Motion and convert to price paths
  res <- apply(rbind(rep(initial_value, num_sims), rand_matrix), 2, cumsum)

  # Return
  if (return_tibble){
    res <- res |>
      dplyr::as_tibble() |>
      dplyr::mutate(t = 1:(t+1)) |>
      tidyr::pivot_longer(-t) |>
      dplyr::select(name, t, value) |>
      purrr::set_names("walk_number", "x", "y") |>
      dplyr::mutate(walk_number = factor(walk_number, levels = 1:num_sims)) |>
      dplyr::arrange(walk_number, x)
  }

  # Return ----
  attr(res, "n") <- .n
  attr(res, "num_walks") <- .num_walks
  attr(res, "delta_time") <- .delta_time
  attr(res, "initial_value") <- .initial_value
  attr(res, "return_tibble") <- .return_tibble
  attr(res, "fns") <- "brownian_motion"
  attr(res, "dimension")     <- 1

  return(res)
}
