#' Running Quantile Calculation
#'
#' @family Utility Functions
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function computes the running quantile of a numeric vector using
#' a specified window size and probability.
#'
#' @description The `running_quantile` function calculates the quantile of
#' a vector over a sliding window, allowing for various alignment and rule options.
#'
#' @param .x A numeric vector for which the running quantile is to be calculated.
#' @param .window An integer specifying the size of the sliding window.
#' @param .probs A numeric value between 0 and 1 indicating the desired quantile
#' probability (default is 0.50).
#' @param .type An integer from 1 to 9 specifying the quantile algorithm type
#' (default is 7).
#' @param .rule A character string indicating the rule to apply at the edges of
#' the window. Possible choices are:
#'   - "quantile": Standard quantile calculation.
#'   - "trim": Trims the output to remove values outside the window.
#'   - "keep": Keeps the original values at the edges of the window.
#'   - "constant": Fills the edges with the constant value from the nearest valid quantile.
#'   - "NA": Fills the edges with NA values.
#'   - "func": Applies a custom function to the values in the window (default is "quantile").
#' @param .align A character string specifying the alignment of the
#' window ("center", "left", or "right"; default is "center").
#'
#' @examples
#' # Example usage of running_quantile
#' set.seed(123)
#' data <- cumsum(rnorm(50))
#' result <- running_quantile(data, .window = 3, .probs = 0.5)
#' print(result)
#'
#' plot(data, type = "l")
#' lines(result, col = "red")
#'
#' @return A numeric vector containing the running quantile values.
#'
#' @name running_quantile
NULL

#' @rdname running_quantile
#' @export

running_quantile <- function(.x, .window, .probs = 0.50, .type = 7,
                             .rule = "quantile", .align = "center") {
  n <- length(.x)
  k <- .window
  k2 <- k %/% 2
  x <- .x

  if (!is.vector(x)) {
    rlang::abort(
      message = "Input must be a vector",
      use_cli_format = TRUE
    )
  }

  if (k <= 0 || k > n) {
    rlang::abort(
      message = "Invalid window size",
      use_cli_format = TRUE
    )
  }

  if (.probs < 0 || .probs > 1) {
    rlang::abort(
      message = "Invalid probability value",
      use_cli_format = TRUE
    )
  }

  if (.type < 1 || .type > 9) {
    rlang::abort(
      message = "Invalid quantile algorithm type",
      use_cli_format = TRUE
    )
  }

  if (!(.rule %in% c("quantile", "trim", "keep", "constant", "NA", "func"))) {
    rlang::abort(
      message = "Invalid rule",
      use_cli_format = TRUE
    )
  }

  if (!(.align %in% c("center", "left", "right"))) {
    rlang::abort(
      message = "Invalid alignment",
      use_cli_format = TRUE
    )
  }

  out <- numeric(n)

  if (.rule == "func") {
    for (i in 1:n) {
      start <- max(1, i - k2)
      end <- min(n, i + k2)
      out[i] <- stats::quantile(x[start:end], probs = .probs, type = .type, names = FALSE)
    }
  } else {
    for (i in (k2 + 1):(n - k2)) {
      out[i] <- stats::quantile(x[(i - k2):(i + k2)], probs = .probs, type = .type, names = FALSE)
    }

    if (.rule == "quantile") {
      if (.align == "center") {
        for (i in 1:k2) {
          out[i] <- stats::quantile(x[1:(i + k2)], probs = .probs, type = .type, names = FALSE)
          out[n - i + 1] <- stats::quantile(x[(n - i - k2 + 1):n], probs = .probs, type = .type, names = FALSE)
        }
      } else {
        for (i in 1:k2) {
          out[i] <- stats::quantile(x[1:(k + i - 1)], probs = .probs, type = .type, names = FALSE)
          out[n - i + 1] <- stats::quantile(x[(n - k - i + 2):n], probs = .probs, type = .type, names = FALSE)
        }
      }
    } else if (.rule == "trim") {
      out <- out[(k2 + 1):(n - k2)]
    } else if (.rule == "keep") {
      out[1:k2] <- x[1:k2]
      out[(n - k2 + 1):n] <- x[(n - k2 + 1):n]
    } else if (.rule == "constant") {
      out[1:k2] <- out[k2 + 1]
      out[(n - k2 + 1):n] <- out[n - k2]
    } else if (.rule == "NA") {
      out[1:k2] <- NA
      out[(n - k2 + 1):n] <- NA
    }
  }

  if (.align == "left") {
    out <- out[1:(n - k2)]
  } else if (.align == "right") {
    out <- out[(k2 + 1):n]
  }

  # Add attributes
  attr(out, "window") <- .window
  attr(out, "probs") <- .probs
  attr(out, "type") <- .type
  attr(out, "rule") <- .rule
  attr(out, "align") <- .align

  return(out)
}
