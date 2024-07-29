#' Cumulative Variance
#'
#' @family Vector Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' A function to return the cumulative variance of a vector.
#' `exp(cummean(log(.x)))`
#'
#' @description
#' A function to return the cumulative variance of a vector.
#'
#' @param .x A numeric vector
#'
#' @examples
#' x <- mtcars$mpg
#'
#' cvar(x)
#'
#' @return
#' A numeric vector. Note: The first entry will always be
#' NaN.
#'
#' @name cvar
NULL
#' @rdname cvar
#' @export

cvar <- function(.x) {
  n <- length(.x)
  csumx <- base::cumsum(.x)
  cmeanx <- cmean(.x)

  p1 <- base::cumsum(.x^2)
  p2 <- -2 * cmeanx * csumx
  p3 <- (1:n) * cmeanx^2
  (p1 + p2 + p3) / ((1:n) - 1)
}

#' Cumulative Skewness
#'
#' @family Vector Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' A function to return the cumulative skewness of a vector.
#'
#' @description
#' A function to return the cumulative skewness of a vector.
#'
#' @param .x A numeric vector
#'
#' @examples
#' x <- mtcars$mpg
#'
#' cskewness(x)
#'
#' @return
#' A numeric vector
#'
#' @name cskewness
NULL
#' @rdname cskewness
#' @export

cskewness <- function(.x) {
  # rescale `y` to avoid detrimental impacts by outliers
  y <- scale(.x)
  # cumulative length of y
  k <- seq_along(y)
  # cumulative n-th raw moments of y
  m3 <- cumsum(y^3)
  m2 <- cumsum(y^2)
  m1 <- cumsum(y)
  u <- m1 / k
  # expand cubic terms and refactor skewness in terms of num/den
  num <- (m3 - 3 * u * m2 + 3 * u^2 * m1 - k * u^3) / k
  den <- sqrt((m2 + k * u^2 - 2 * u * m1) / k)^3
  c(NaN, (num / den)[-1])
}

#' Cumulative Kurtosis
#'
#' @family Vector Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' A function to return the cumulative kurtosis of a vector.
#'
#' @description
#' A function to return the cumulative kurtosis of a vector.
#'
#' @param .x A numeric vector
#'
#' @examples
#' x <- mtcars$mpg
#'
#' ckurtosis(x)
#'
#' @return
#' A numeric vector
#'
#' @name ckurtosis
NULL
#' @rdname ckurtosis
#' @export

ckurtosis <- function(.x) {
  x <- scale(.x)
  k <- seq_along(x)
  # Cumulative nth raw moment
  m4 <- cumsum(x^4)
  m3 <- cumsum(x^3)
  m2 <- cumsum(x^2)
  m1 <- cumsum(x)
  u <- m1 / k
  # Expand quartic terms and refactor kurtosis in terms of num/den
  num <- (m4 - 4 * u * m3 + 6 * u^2 * m2 - 4 * u^3 * m1 + k * u^4) / k
  den <- (m2 + k * u^2 - 2 * u * m1) / k
  c(NaN, (num / den^2)[-1])
}

#' Cumulative Standard Deviation
#'
#' @family Vector Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' A function to return the cumulative standard deviation of a vector.
#'
#' @description
#' A function to return the cumulative standard deviation of a vector.
#'
#' @param .x A numeric vector
#'
#' @examples
#' x <- mtcars$mpg
#'
#' csd(x)
#'
#' @return
#' A numeric vector. Note: The first entry will always be
#' NaN.
#'
#' @name csd
NULL
#' @rdname csd
#' @export

csd <- function(.x) {
  sqrt(cvar(.x))
}

#' Cumulative Median
#'
#' @family Vector Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' A function to return the cumulative median of a vector.
#'
#' @description
#' A function to return the cumulative median of a vector.
#'
#' @param .x A numeric vector
#'
#' @examples
#' x <- mtcars$mpg
#'
#' cmedian(x)
#'
#' @return
#' A numeric vector
#'
#' @name cmedian
NULL
#' @rdname cmedian
#' @export

cmedian <- function(.x) {
  sapply(seq_along(.x), function(k, z) stats::median(z[1:k]), z = .x)
}

#' Cumulative Geometric Mean
#'
#' @family Vector Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' A function to return the cumulative geometric mean of a vector.
#' `exp(cummean(log(.x)))`
#'
#' @description
#' A function to return the cumulative geometric mean of a vector.
#'
#' @param .x A numeric vector
#'
#' @examples
#' x <- mtcars$mpg
#'
#' cgmean(x)
#'
#' @return
#' A numeric vector
#'
#' @name cgmean
NULL
#' @rdname cgmean
#' @export

cgmean <- function(.x) {
  exp(cmean(log(.x)))
}

#' Cumulative Harmonic Mean
#'
#' @family Vector Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' A function to return the cumulative harmonic mean of a vector.
#' `1 / (cumsum(1 / .x))`
#'
#' @description
#' A function to return the cumulative harmonic mean of a vector.
#'
#' @param .x A numeric vector
#'
#' @examples
#' x <- mtcars$mpg
#'
#' chmean(x)
#'
#' @return
#' A numeric vector
#'
#' @name chmean
NULL
#' @rdname chmean
#' @export

chmean <- function(.x) {
  1 / (cumsum(1 / .x))
}

#' Cumulative Mean
#'
#' @family Vector Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' A function to return the cumulative mean of a vector. It uses [dplyr::cummean()]
#' as the basis of the function.
#'
#' @description
#' A function to return the cumulative mean of a vector.
#'
#' @param .x A numeric vector
#'
#' @examples
#' x <- mtcars$mpg
#'
#' cmean(x)
#'
#' @return
#' A numeric vector
#'
#' @name cmean
NULL
#' @rdname cmean
#' @export

cmean <- function(.x) {
  dplyr::cummean(.x)
}

#' Range
#'
#' @family Vector Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' A function to return the range of a vector. It uses `max(.x) - min(.x)` as
#' the basis of the function.
#'
#' @description
#' A function to return the range of a vector.
#'
#' @param .x A numeric vector
#'
#' @examples
#' x <- mtcars$mpg
#'
#' rw_range(x)
#'
#' @return
#' A numeric vector
#'
#' @name rw_range
NULL
#' @rdname rw_range
#' @export

rw_range <- function(.x) {
  max(.x) - min(.x)
}

#' Cumulative Range
#'
#' @family Vector Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' A function to return the cumulative range of a vector. It uses `max(.x[1:k]) - min(.x[1:k])` as
#' the basis of the function.
#'
#' @description
#' A function to return the cumulative range of a vector.
#'
#' @param .x A numeric vector
#'
#' @examples
#'
#' x <- mtcars$mpg
#'
#' crange(x)
#'
#' @return
#' A numeric vector
#'
#' @name name
NULL
#' @rdname crange
#' @export

crange <- function(.x) {
  sapply(seq_along(.x), function(k, z) max(z[1:k]) - min(z[1:k]), z = .x)
}

#' Compute Kurtosis of a Vector
#'
#' @family Vector Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' A function to return the kurtosis of a vector.
#'
#' @seealso \url{https://en.wikipedia.org/wiki/Kurtosis}
#'
#' @description
#' This function takes in a vector as it's input and will return the kurtosis
#' of that vector. The length of this vector must be at least four numbers. The
#' kurtosis explains the sharpness of the peak of a distribution of data.
#'
#' `((1/n) * sum(x - mu})^4) / ((()1/n) * sum(x - mu)^2)^2`
#'
#' @param .x A numeric vector of length four or more.
#'
#' @examples
#' set.seed(123)
#' kurtosis_vec(rnorm(100, 3, 2))
#'
#' @return
#' The kurtosis of a vector
#'
#' @name kurtosis_vec
NULL
#' @rdname kurtosis_vec
#' @export

kurtosis_vec <- function(.x) {

  # Tidyeval ----
  x_term <- .x

  # Checks ----
  if (!is.numeric(x_term)) {
    stop(call. = FALSE, ".x must be a numeric vector.")
  }

  if (length(x_term) < 4) {
    stop(call. = FALSE, ".x must be a numeric vector of 4 or more.")
  }

  # Calculate
  n <- length(x_term)
  mu <- mean(x_term, na.rm = TRUE)
  n_diff <- (x_term - mu)^4
  nu <- (1 / n * sum(n_diff))
  d_diff <- (x_term - mu)^2
  de <- (1 / n * sum(d_diff))^2
  k <- nu / de
  return(k)
  print(k)
}

#' Compute Skewness of a Vector
#'
#' @family Vector Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' A function to return the skewness of a vector.
#'
#' @seealso \url{https://en.wikipedia.org/wiki/Skewness}
#'
#' @description
#' This function takes in a vector as it's input and will return the skewness
#' of that vector. The length of this vector must be at least four numbers. The
#' skewness explains the 'tailedness' of the distribution of data.
#'
#' `((1/n) * sum(x - mu})^3) / ((()1/n) * sum(x - mu)^2)^(3/2)`
#'
#' @param .x A numeric vector of length four or more.
#'
#' @examples
#' set.seed(123)
#' skewness_vec(rnorm(100, 3, 2))
#'
#' @return
#' The skewness of a vector
#'
#' @name skewness_vec
NULL
#' @rdname skewness_vec
#' @export

skewness_vec <- function(.x) {

  # Tidyeval ----
  x_term <- .x

  # Checks ----
  if (!is.numeric(x_term)) {
    stop(call. = FALSE, ".x must be a numeric vector.")
  }

  if (length(x_term) < 4) {
    stop(call. = FALSE, ".x must be a numeric vector of 4 or more.")
  }

  # Calculate
  n <- length(x_term)
  mu <- mean(x_term, na.rm = TRUE)
  n_diff <- (x_term - mu)^3
  nu <- (1 / n * sum(n_diff))
  d_diff <- (x_term - mu)^2
  de <- (1 / n * sum(d_diff))^(3 / 2)
  s <- nu / de
  return(s)
  print(s)
}
