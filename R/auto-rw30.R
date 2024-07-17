#' Generate Random Walks
#'
#' @family Auto Random Walk
#'
#' @author Steven P. Sanderson II, MPH
#'
#' This function generates 30 random walks with 100 steps each and pivots the
#' result into a long format tibble.
#'
#' @details
#' The function generates random walks using the normal distribution with a
#' specified mean (`mu`) and standard deviation (`sd`).
#' Each walk is generated independently and stored in a tibble. The resulting
#' tibble is then pivoted into a long format for easier analysis.
#'
#' @return A tibble in long format with columns `walk`, `x`, and `value`,
#' representing the random walks. Additionally, attributes `num_walks`,
#' `num_steps`, `mu`, and `sd` are attached to the tibble.
#'
#' @examples
#' # Generate random walks and print the result
#' rw30()
#'
#' @name rw30
NULL
#' @rdname rw30
#' @export
rw30 <- function() {

  num_walks <- 30L
  num_steps <- 100L
  mu <- 0L
  sd <- 1L

  # Function to generate a single random walk
  single_random_walk <- function(n, mu, sd) {
    cumsum(c(0, stats::rnorm(n - 1, mu, sd)))
  }

  # Generate the walks
  walks <- replicate(
    num_walks,
    single_random_walk(num_steps, mu, sd),
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
  attr(walks_long, "fns") <- "rw30"

  return(walks_long)
}
