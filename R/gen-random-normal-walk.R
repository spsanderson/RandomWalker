#' Generate Multiple Random Normal Walks
#'
#' @family Generator Functions
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' This function generates multiple random walks, which are sequences of steps
#' where each step is a random draw from a normal distribution. The user can
#' specify the number of walks, the number of steps in each walk, and the
#' parameters of the normal distribution (mean and standard deviation). The
#' function also allows for sampling a proportion of the steps and optionally
#' sampling with replacement.
#'
#' The output tibble includes several computed columns for each walk, such as the
#' cumulative sum, product, minimum, and maximum of the steps.
#'
#' @description
#' The `random_normal_walk` function is useful for simulating random processes
#' and can be applied in various fields such as finance, physics, and biology
#' to model different stochastic behaviors.
#'
#' @param .num_walks An integer specifying the number of random walks to generate. Default is 25.
#' @param .n An integer specifying the number of steps in each walk. Default is 100.
#' @param .mu A numeric value indicating the mean of the normal distribution. Default is 0.
#' @param .sd A numeric value indicating the standard deviation of the normal distribution. Default is 0.1.
#' @param .initial_value A numeric value indicating the initial value of the walks. Default is 0.
#' @param .samp A logical value indicating whether to sample the normal distribution values. Default is TRUE.
#' @param .replace A logical value indicating whether sampling is with replacement. Default is TRUE.
#' @param .sample_size A numeric value between 0 and 1 specifying the proportion of `.n` to sample. Default is 0.8.
#'
#' @return A tibble containing the generated random walks with the following columns:
#' \itemize{
#'   \item `walk_number`: Factor representing the walk number.
#'   \item `x`: Step index.
#'   \item `y`: Normal distribution values.
#'   \item `cum_sum`: Cumulative sum of `y`.
#'   \item `cum_prod`: Cumulative product of `y`.
#'   \item `cum_min`: Cumulative minimum of `y`.
#'   \item `cum_max`: Cumulative maximum of `y`.
#' }
#' The tibble includes attributes for the function parameters.
#'
#' @examples
#' # Generate 10 random walks with 50 steps each
#' set.seed(123)
#' random_normal_walk(.num_walks = 10, .n = 50)
#'
#' # Generate random walks with different mean and standard deviation
#' set.seed(123)
#' random_normal_walk(.num_walks = 10, .n = 50, .samp = FALSE)
#'
#' set.seed(123)
#' random_normal_walk(.num_walks = 2, .n = 100) |>
#'   ggplot(aes(x = x, y = y, group = walk_number, color = walk_number)) +
#'   geom_line() +
#'   labs(title = "Random Normal Walk", x = "Time", y = "Value") +
#'   theme_minimal() +
#'   theme(legend.position = "none")
#'
#' @name random_normal_walk
NULL
#' @rdname random_normal_walk
#' @export
random_normal_walk <- function(.num_walks = 25, .n = 100, .mu = 0, .sd = .1,
                               .initial_value = 0, .samp = TRUE, .replace = TRUE,
                               .sample_size = 0.8) {

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
    rlang::abort(".sample_size cannot be less than 0 or more than 1", use_cli_format = TRUE)
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
  x <- if (samp) {
    1:samp_size
  } else {
    1:n
  }
  periods <- length(x)

  res <- tidyr::expand_grid(walk_number = factor(1:num_walks), x = 1:periods) |>
    dplyr::group_by(walk_number) |>
    dplyr::mutate(
      y = if (samp) {
        sample(rnorm(periods, mu, sd), replace = replace, size = samp_size)
      } else {
        rnorm(periods, mu, sd)
      }
    ) |>
    dplyr::mutate(cum_sum  = initial_value + cumsum(y)) |>
    dplyr::mutate(cum_prod = initial_value * cumprod(1 + y)) |>
    dplyr::mutate(cum_min  = initial_value + cummin(y)) |>
    dplyr::mutate(cum_max  = initial_value + cummax(y)) |>
    dplyr::ungroup()

  # res <- dplyr::tibble(walk_number = 1:num_walks |>
  #                        factor()) |>
  #   dplyr::group_by(walk_number) |>
  #   dplyr::mutate(
  #     x = dplyr::case_when(
  #       samp == TRUE ~ list(1:samp_size),
  #       .default = list(1:n)
  #     )) |>
  #   dplyr::mutate(
  #     y = dplyr::case_when(
  #       samp == TRUE ~ list(sample(rnorm(n, mu, sd), replace = replace,
  #                                  size = samp_size)),
  #       .default = list(rnorm(n, mu, sd))
  #     )) |>
  #   tidyr::unnest(cols = c(x, y)) |>
  #   dplyr::mutate(cum_sum  = initial_value + cumsum(y)) |>
  #   dplyr::mutate(cum_prod = initial_value * cumprod(1 + y)) |>
  #   dplyr::mutate(cum_min  = initial_value + cummin(y)) |>
  #   dplyr::mutate(cum_max  = initial_value + cummax(y)) |>
  #   dplyr::ungroup()

  # Attributes
  attr(res, "n")             <- n
  attr(res, "num_walks")     <- num_walks
  attr(res, "mu")            <- mu
  attr(res, "sd")            <- sd
  attr(res, "initial_value") <- initial_value
  attr(res, "replace")       <- replace
  attr(res, "samp")          <- samp
  attr(res, "samp_size")     <- samp_size
  attr(res, "periods")       <- periods
  attr(res, "fns")           <- "random_normal_walk"
  attr(res, "dimension")     <- 1

  # Return
  return(res)
}
