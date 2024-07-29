#' Random Walk Helper
#'
#' @family Utility Functions
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' A function to help build random walks by mutating a data frame. This mutation
#' adds the following columns to the data frame: `cum_sum`, `cum_prod`, `cum_min`,
#' `cum_max`, and `cum_mean`. The function is used internally by certain functions
#' that generate random walks.
#'
#' @description
#' A function to help build random walks by mutating a data frame.
#'
#' @param .data The data frame to mutate.
#' @param .value The .initial_value to use. This is passed from the random walk
#' function being called by the end user.
#'
#' @examples
#' df <- data.frame(
#'   walk_number = factor(rep(1L:25L, each = 30L)),
#'   x = rep(1L:30L, 25L),
#'   y = rnorm(750L, 0L, 1L)
#'   )
#'
#' rand_walk_helper(df, 100)
#'
#' @return
#' A modified data frame/tibble with the following columns added:
#' \itemize{
#'  \item `cum_sum`: Cumulative sum of `y`.
#'  \item `cum_prod`: Cumulative product of `y`.
#'  \item `cum_min`: Cumulative minimum of `y`.
#'  \item `cum_max`: Cumulative maximum of `y`.
#'  \item `cum_mean`: Cumulative mean of `y`.
#'  }
#'
#' @name rand_walk_helper
NULL
#' @rdname rand_walk_helper
#' @export

rand_walk_helper <- function(.data, .value) {

  initial_value = as.numeric(.value)

  df <- .data |>
    dplyr::group_by(walk_number) |>
    dplyr::mutate(
      cum_sum  = initial_value + cumsum(y),
      cum_prod = initial_value * cumprod(1 + y),
      cum_min  = initial_value + cummin(y),
      cum_max  = initial_value + cummax(y),
      cum_mean = initial_value + cmean(y)
    ) |>
    dplyr::ungroup()

  return(df)
}
