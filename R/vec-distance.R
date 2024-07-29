#' Distance Calculations
#'
#' @family Vector Function
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details
#' A function to calculate the Euclidean distance between two vectors. It uses
#' the formula `sqrt((x - lag(x))^2 + (y - lag(y))^2)`. The function uses augments
#' the data frame with a new column called `distance`.
#'
#' @description
#' A function to calculate the Euclidean distance between two vectors.
#'
#' @param .data A data frame
#' @param .x A numeric vector
#' @param .y A numeric vector
#' @param .pull_vector A boolean of TRUE or FALSE. Default is FALSE which will
#' augment the distance to the data frame. TRUE will return a vector of the distances
#' as the return.
#'
#' @examples
#' set.seed(123)
#' df <- rw30()
#' euclidean_distance(df, x, y)
#' euclidean_distance(df, x, y, TRUE) |> head(10)
#'
#' @return
#' A numeric Vector of ditances
#'
#' @name euclidean_distance
NULL
#' @rdname euclidean_distance
#' @export

euclidean_distance <- function(.data, .x, .y, .pull_vector = FALSE) {

  # Tidyeval ---
  x_var <- rlang::enquo(.x)
  y_var <- rlang::enquo(.y)

  # Calculate the distance ---
  ret <- dplyr::as_tibble(.data) |>
    dplyr::mutate(
      distance = sqrt(
        (!!x_var - dplyr::lag(!!x_var, 1))^2 + (!!y_var - dplyr::lag(!!y_var, 1))^2
      )
    )

  # Return the distance vector ---
  if (.pull_vector) {
    return(ret[["distance"]])
  }

  return(ret)
}
