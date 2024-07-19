#' Generate Multiple Random Walks with Drift
#'
#' @family Generator Functions
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' This function generates multiple random walks with a specified drift.
#' Each walk is generated using a normal distribution for the steps, with an
#' additional drift term added to each step.
#'
#' @description
#' This function generates a specified number of random walks, each consisting
#' of a specified number of steps. The steps are generated from a normal
#' distribution with a given mean and standard deviation. An additional drift
#' term is added to each step to introduce a consistent directional component
#' to the walks.
#'
#' @param .num_walks Integer. The number of random walks to generate. Default is 25.
#' @param .n Integer. The number of steps in each random walk. Default is 100.
#' @param .mu Numeric. The mean of the normal distribution used for generating steps. Default is 0.
#' @param .sd Numeric. The standard deviation of the normal distribution used for generating steps. Default is 1.
#' @param .drift Numeric. The drift term to be added to each step. Default is 0.1.
#'
#' @examples
#' library(ggplot2)
#'
#' walks <- random_normal_drift_walk(.num_walks = 10, .n = 50, .mu = 0, .sd = 1,
#'                                   .drift = 0.05)
#' ggplot(walks, aes(x = x, y = y, group = walk_number, color = walk_number)) +
#'   geom_line() +
#'   labs(title = "Random Walks with Drift", x = "Time", y = "Value") +
#'   theme_minimal() +
#'   theme(legend.position = "none")
#'
#' @return A tibble in long format with columns `walk_number`, `x` (step index),
#' and `y` (walk value). The tibble has attributes for the number of walks,
#' number of steps, mean, standard deviation, and drift.
#'
#' @name random_normal_drift_walk
NULL
#' @rdname random_normal_drift_walk
#' @export

random_normal_drift_walk <- function(.num_walks = 25, .n = 100, .mu = 0,
                                     .sd = 1, .drift = 0.1) {

  num_walks <- as.integer(.num_walks)
  num_steps <- as.integer(.n)
  mu <- as.numeric(.mu)
  sd <- as.numeric(.sd)
  drift <- as.numeric(.drift)
  #dr <- seq(from = drift, to = n, length.out = n)

  # Function to generate a single random walk
  single_random_walk_with_drift <- function(num_steps, mu, sd, drift) {
    wn <- stats::rnorm(n = num_steps, mean = mu, sd = sd)
    rw <- cumsum(stats::rnorm(n = num_steps, mean = mu, sd = sd))
    res <- wn + rw + drift
    return(res)
  }

  # Generate the walks
  walks <- replicate(
    num_walks,
    single_random_walk_with_drift(num_steps, mu, sd, drift),
    simplify = FALSE
  )

  # Create a tibble with the walks
  walks_tibble <- dplyr::tibble(
    x = 1:num_steps,
    !!!stats::setNames(walks, 1:num_walks)
  )

  # Pivot the tibble longer
  walks_long <- tidyr::pivot_longer(
    walks_tibble,
    cols = -x,
    names_to = "walk_number",
    values_to = "y"
  ) |>
    dplyr::mutate(walk_number = factor(walk_number)) |>
    dplyr::select(walk_number, x, y) |>
    dplyr::arrange(walk_number, x)

  attr(walks_long, "num_walks") <- num_walks
  attr(walks_long, "num_steps") <- num_steps
  attr(walks_long, "mu") <- mu
  attr(walks_long, "sd") <- sd
  attr(walks_long, "drift") <- drift
  attr(walks_long, "fns") <- "random_normal_drift_walk"
  attr(res, "dimension")     <- 1

  return(walks_long)
}
