#' Confidence Interval
#'
#' @family Utility Functions
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function calculates the confidence interval for a given vector and interval.
#'
#' @description Calculate the confidence interval
#'
#' @param .vector A numeric vector of data points
#' @param .interval A numeric value representing the confidence level
#' (e.g., 0.95 for 95% confidence interval) The default is 0.95
#'
#' @examples
#' confidence_interval(rnorm(100), 0.95)
#'
#' @return A named vector with the lower and upper bounds of the confidence interval
#' @name confidence_interval
NULL

#' @rdname confidence_interval
#' @export
confidence_interval <- function(.vector, .interval = 0.95) {

  # Ensure .interval is between 0 and 1
  if (.interval <= 0 | .interval >= 1) {
    rlang::abort(
      message = "The interval must be between 0 and 1",
      use_cli_format = TRUE
    )
  }

  # Ensure .vector is numeric
  if (!is.numeric(.vector)) {
    rlang::abort(
      message = ".vector must be numeric",
      use_cli_format = TRUE
    )
  }

  # Remove NA values from the vector
  .vector <- purrr::discard(.vector, is.na)

  vec_sd <- stats::sd(.vector)
  n <- length(.vector)
  vec_mean <- mean(.vector)
  error <- stats::qt((.interval + 1) / 2, df = n - 1) * vec_sd / sqrt(n)
  result <- dplyr::tibble(
    lower = vec_mean - error,
    upper = vec_mean + error
  )
  return(result)
}
