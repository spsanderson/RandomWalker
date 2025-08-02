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

#' Helper function to convert a snake_case string to Title Case
#'
#' @family Utility Functions
#'
#' @author Antti Lennart Rask
#'
#' @details This function is useful for formatting strings in a more readable
#' way, especially when dealing with variable names or identifiers that use
#' snake_case. This function takes a snake_case string and converts it to Title Case.
#' It replaces underscores with spaces, capitalizes the first letter of each word,
#' and replaces the substring "cum" with "cumulative" for better readability.
#'
#' @description Converts a snake_case string to Title Case.
#'
#' @param string A character string in snake_case format.
#'
#' @return A character string converted to Title Case.
#'
#' @examples
#' convert_snake_to_title_case("hello_world") # "Hello World"
#' convert_snake_to_title_case("this_is_a_test") # "This Is A Test"
#' convert_snake_to_title_case("cumulative_sum") # "Cumulative Sum"
#'
#' @name convert_snake_to_title_case
NULL
#' @rdname convert_snake_to_title_case
#' @export

convert_snake_to_title_case <- function(string) {
  # Replace underscores with spaces to separate words
  string_with_spaces <- gsub("_", " ", string)

  # Replace the substring "cum" with "cumulative" for better readability
#  string_with_replaced_strings <- gsub("cum", "cumulative", string_with_spaces)
  string_with_replaced_strings <- gsub("\\bcum\\b", "cumulative", string_with_spaces)

  # Split the modified string into individual words
  words <- strsplit(string_with_replaced_strings, " ")[[1]]

  # Capitalize the first letter of each word and concatenate them back into a single string
  capitalized_words <- paste(toupper(substring(words, 1, 1)), substring(words, 2), sep = "", collapse = " ")

  # Return the title-cased string
  return(capitalized_words)
}

#' Helper function to generate a caption string based on provided attributes
#'
#' @family Utility Functions
#'
#' @author Antti Lennart Rask
#'
#' @details This function is useful for creating descriptive captions for
#' plots or outputs based on the attributes provided. It ensures that only
#' non-null attributes are included in the caption. This function constructs a
#' caption string by checking various attributes provided in a list.
#' It formats the caption based on the presence of specific attributes, such as
#' dimensions, number of steps, and statistical parameters like mu and standard
#' deviation (sd).
#'
#' @description Generates a caption string based on provided attributes.
#'
#' @param attributes A list containing various attributes that may include
#' `dimension`, `num_steps`, `mu`, and `sd`.
#'
#' @return A character string representing the generated caption. If no
#' attributes are provided, it returns an empty string.
#'
#' @examples
#' attrs <- list(dimension = 3, num_steps = 100, mu = 0.5, sd = 1.2)
#' generate_caption(attrs) # "3 dimensions, 100 steps, mu = 0.5, sd = 1.2."
#'
#' attrs <- list(dimension = NULL, num_steps = 50, mu = NULL, sd = 2.0)
#' generate_caption(attrs) # "50 steps, sd = 2.0."
#'
#' @name generate_caption
NULL
#' @rdname generate_caption
#' @export

generate_caption <- function(attributes) {

  # Initialize an empty vector to hold parts of the caption
  parts <- c()

  # Check if 'dimension' attribute is not NULL and add it to 'parts'
  if (!is.null(attributes$dimension)) {
    parts <- c(parts, paste0(attributes$dimension, " dimensions"))
  }

  # Check if 'num_steps' attribute is not NULL and add it to 'parts'
  if (!is.null(attributes$num_steps)) {
    parts <- c(parts, paste0(attributes$num_steps, " steps"))
  }

  # Check if 'mu' attribute is not NULL and add it to 'parts'
  if (!is.null(attributes$mu)) {
    parts <- c(parts, paste0("mu = ", attributes$mu))
  }

  # Check if 'sd' attribute is not NULL and add it to 'parts'
  if (!is.null(attributes$sd)) {
    parts <- c(parts, paste0("sd = ", attributes$sd))
  }

  # Combine all parts into a single string with commas separating them
  caption <- paste(parts, collapse = ", ")

  # If the caption is not an empty string, append a period at the end
  if (caption != "") {
    caption <- paste0(caption, ".")
  }

  # Return the generated caption
  return(caption)
}

#' Augment Cumulative Sum
#'
#' @family Utility Functions
#' @author Steven P. Sanderson II, MPH
#' @description This function augments a data frame by adding cumulative sum
#' columns for specified variables.
#'
#' @details The function takes a data frame and a column name (or names) and
#' computes the cumulative sum for each specified column, starting from an
#' initial value. If the column names are not provided, it will throw an error.
#'
#' @param .data A data frame to augment.
#' @param .value A column name or names for which to compute the cumulative sum.
#' @param .names Optional. A character vector of names for the new cumulative
#' sum columns. Defaults to "auto", which generates names based on the original
#' column names.
#' @param .initial_value A numeric value to start the cumulative sum from.
#' Defaults to 0.
#'
#' @return A tibble with the original data and additional columns containing
#' the cumulative sums.
#'
#' @examples
#' df <- data.frame(x = 1:5, y = 6:10)
#' std_cum_sum_augment(df, .value = x)
#' std_cum_sum_augment(df, .value = y, .names = c("cumsum_y"))
#'
#' @name std_cum_sum_augment
NULL
#' @rdname std_cum_sum_augment
#' @export

std_cum_sum_augment <- function(.data,
                                .value,
                                .names = "auto",
                                .initial_value = 0) {
  column_expr <- rlang::enquo(.value)

  if (rlang::quo_is_missing(column_expr)) {
    rlang::abort("std_cum_sum_augment(.value) is missing.", use_cli_format = TRUE)
  }

  col_nms <- names(tidyselect::eval_select(column_expr, .data))

  make_call <- function(col) {
    rlang::expr(!!.initial_value + cumsum(!!rlang::sym(col)))
  }

  grid <- expand.grid(
    col = col_nms,
    stringsAsFactors = FALSE
  )

  calls <- purrr::pmap(list(grid$col), make_call)

  if (any(.names == "auto")) {
    newname <- paste0("cum_sum_", grid$col)
  } else {
    newname <- as.list(.names)
  }

  calls <- purrr::set_names(calls, newname)

  ret <- dplyr::as_tibble(dplyr::mutate(.data, !!!calls))

  return(ret)
}

#' Augment Cumulative Product
#'
#' @family Utility Functions
#' @author Steven P. Sanderson II, MPH
#' @description This function augments a data frame by adding cumulative product
#' columns for specified variables.
#'
#' @details The function takes a data frame and a column name (or names) and
#' computes the cumulative product for each specified column, starting from an
#' initial value. If the column names are not provided, it will throw an error.
#'
#' @param .data A data frame to augment.
#' @param .value A column name or names for which to compute the cumulative product.
#' @param .names Optional. A character vector of names for the new cumulative
#' product columns. Defaults to "auto", which generates names based on the original
#' column names.
#' @param .initial_value A numeric value to start the cumulative product from.
#' Defaults to 1.
#'
#' @return A tibble with the original data and additional columns containing the
#' cumulative products.
#'
#' @examples
#' df <- data.frame(x = 1:5, y = 6:10)
#' std_cum_prod_augment(df, .value = x)
#' std_cum_prod_augment(df, .value = y, .names = c("cumprod_y"))
#'
#' @name std_cum_prod_augment
NULL
#' @rdname std_cum_prod_augment
#' @export

std_cum_prod_augment <- function(.data,
                                 .value,
                                 .names = "auto",
                                 .initial_value = 1) {
  column_expr <- rlang::enquo(.value)

  if (rlang::quo_is_missing(column_expr)) {
    stop(call. = FALSE, "std_cum_prod_augment(.value) is missing.")
  }

  col_nms <- names(tidyselect::eval_select(column_expr, .data))

  make_call <- function(col) {
    rlang::expr(!!.initial_value * cumprod(1 + !!rlang::sym(col)))
  }

  grid <- expand.grid(
    col = col_nms,
    stringsAsFactors = FALSE
  )

  calls <- purrr::pmap(.l = list(grid$col), make_call)

  if (any(.names == "auto")) {
    newname <- paste0("cum_prod_", grid$col)
  } else {
    newname <- as.list(.names)
  }

  calls <- purrr::set_names(calls, newname)

  ret <- dplyr::as_tibble(dplyr::mutate(.data, !!!calls))

  return(ret)
}

#' Augment Cumulative Minimum
#'
#' @family Utility Functions
#' @author Steven P. Sanderson II, MPH
#' @description This function augments a data frame by adding cumulative minimum
#' columns for specified variables.
#'
#' @details The function takes a data frame and a column name (or names) and
#' computes the cumulative minimum for each specified column, starting from an
#' initial value. If the column names are not provided, it will throw an error.
#'
#' @param .data A data frame to augment.
#' @param .value A column name or names for which to compute the cumulative minimum.
#' @param .names Optional. A character vector of names for the new cumulative
#' minimum columns. Defaults to "auto", which generates names based on the
#' original column names.
#' @param .initial_value A numeric value to start the cumulative minimum from.
#' Defaults to 0.
#'
#' @return A tibble with the original data and additional columns containing
#' the cumulative minimums.
#'
#' @examples
#' df <- data.frame(x = c(5, 3, 8, 1, 4), y = c(10, 7, 6, 12, 5))
#' std_cum_min_augment(df, .value = x)
#' std_cum_min_augment(df, .value = y, .names = c("cummin_y"))
#'
#' @name std_cum_min_augment
NULL
#' @rdname std_cum_min_augment
#' @export
#'
std_cum_min_augment <- function(.data,
                                .value,
                                .names = "auto",
                                .initial_value = 0) {
  column_expr <- rlang::enquo(.value)

  if (rlang::quo_is_missing(column_expr)) {
    rlang::abort("std_cum_min_augment(.value) is missing.", use_cli_format = TRUE)
  }

  col_nms <- names(tidyselect::eval_select(column_expr, .data))

  make_call <- function(col) {
    rlang::expr(!!.initial_value + cummin(!!rlang::sym(col)))
  }

  grid <- expand.grid(
    col = col_nms,
    stringsAsFactors = FALSE
  )

  calls <- purrr::pmap(list(grid$col), make_call)

  if (any(.names == "auto")) {
    newname <- paste0("cum_min_", grid$col)
  } else {
    newname <- as.list(.names)
  }

  calls <- purrr::set_names(calls, newname)

  ret <- dplyr::as_tibble(dplyr::mutate(.data, !!!calls))

  return(ret)
}

#' Augment Cumulative Maximum
#'
#' @family Utility Functions
#' @author Steven P. Sanderson II, MPH
#' @description This function augments a data frame by adding cumulative maximum
#' columns for specified variables.
#'
#' @details The function takes a data frame and a column name (or names) and
#' computes the cumulative maximum for each specified column, starting from an
#' initial value. If the column names are not provided, it will throw an error.
#'
#' @param .data A data frame to augment.
#' @param .value A column name or names for which to compute the cumulative maximum.
#' @param .names Optional. A character vector of names for the new cumulative
#' maximum columns. Defaults to "auto", which generates names based on the
#' original column names.
#' @param .initial_value A numeric value to start the cumulative maximum from.
#' Defaults to 0.
#'
#' @return A tibble with the original data and additional columns containing the
#' cumulative maximums.
#'
#' @examples
#' df <- data.frame(x = c(1, 3, 2, 5, 4), y = c(10, 7, 6, 12, 5))
#' std_cum_max_augment(df, .value = x)
#' std_cum_max_augment(df, .value = y, .names = c("cummax_y"))
#'
#' @name std_cum_max_augment
NULL
#' @rdname std_cum_max_augment
#' @export
#'
std_cum_max_augment <- function(.data,
                                .value,
                                .names = "auto",
                                .initial_value = 0) {
  column_expr <- rlang::enquo(.value)

  if (rlang::quo_is_missing(column_expr)) {
    rlang::abort("std_cum_max_augment(.value) is missing.", use_cli_format = TRUE)
  }

  col_nms <- names(tidyselect::eval_select(column_expr, .data))

  make_call <- function(col) {
    rlang::expr(!!.initial_value + cummax(!!rlang::sym(col)))
  }

  grid <- expand.grid(
    col = col_nms,
    stringsAsFactors = FALSE
  )

  calls <- purrr::pmap(list(grid$col), make_call)

  if (any(.names == "auto")) {
    newname <- paste0("cum_max_", grid$col)
  } else {
    newname <- as.list(.names)
  }

  calls <- purrr::set_names(calls, newname)

  ret <- dplyr::as_tibble(dplyr::mutate(.data, !!!calls))

  return(ret)
}

#' Augment Cumulative Sum
#'
#' @family Utility Functions
#' @author Steven P. Sanderson II, MPH
#' @description This function augments a data frame by adding cumulative mean
#' columns for specified variables.
#'
#' @details The function takes a data frame and a column name (or names) and
#' computes the cumulative mean for each specified column, starting from an
#' initial value. If the column names are not provided, it will throw an error.
#'
#' @param .data A data frame to augment.
#' @param .value A column name or names for which to compute the cumulative mean.
#' @param .names Optional. A character vector of names for the new cumulative
#' mean columns. Defaults to "auto", which generates names based on the original
#' column names.
#' @param .initial_value A numeric value to start the cumulative mean from.
#' Defaults to 0.
#'
#' @return A tibble with the original data and additional columns containing the
#' cumulative means.
#'
#' @examples
#' df <- data.frame(x = c(1, 2, 3, 4, 5), y = c(10, 20, 30, 40, 50))
#' std_cum_mean_augment(df, .value = x)
#' std_cum_mean_augment(df, .value = y, .names = c("cummean_y"))
#'
#' @name std_cum_mean_augment
NULL
#' @rdname std_cum_mean_augment
#' @export
#'
std_cum_mean_augment <- function(.data,
                                 .value,
                                 .names = "auto",
                                 .initial_value = 0) {
  column_expr <- rlang::enquo(.value)

  if (rlang::quo_is_missing(column_expr)) {
    rlang::abort("std_cum_mean_augment(.value) is missing.", use_cli_format = TRUE)
  }

  col_nms <- names(tidyselect::eval_select(column_expr, .data))

  make_call <- function(col) {
    rlang::expr(!!.initial_value + cmean(!!rlang::sym(col)))
  }

  grid <- expand.grid(
    col = col_nms,
    stringsAsFactors = FALSE
  )

  calls <- purrr::pmap(list(grid$col), make_call)

  if (any(.names == "auto")) {
    newname <- paste0("cum_mean_", grid$col)
  } else {
    newname <- as.list(.names)
  }

  calls <- purrr::set_names(calls, newname)

  ret <- dplyr::as_tibble(dplyr::mutate(.data, !!!calls))

  return(ret)
}

#' Get Attributes
#'
#' @family Utility Functions
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @details This function retrieves the attributes of a given R object,
#' excluding the row.names attribute.
#'
#' @description The `get_attributes` function takes an R object as input and
#' returns its attributes, omitting the row.names attribute.
#'
#' @param .data An R object from which attributes are to be extracted.
#'
#' @examples
#' get_attributes(rw30())
#' get_attributes(iris)
#' get_attributes(mtcars)
#'
#' @return A list of attributes of the input R object, excluding row.names.
#'
#' @name get_attributes
NULL
#'
#' @rdname get_attributes
#'
#' @export

get_attributes <- function(.data){

  atb <- attributes(.data)

  # drop row.names
  atb <- atb[!names(atb) %in% c("row.names")]

  # Return
  return(atb)
}

#' Get Column Names
#'
#' @family Utility Functions
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description This function generates the column names of a rand walk
#' data frame.
#'
#' @details The `rand_walk_column_names` function takes a data frame as input and
#' returns the rand walk data with column names.
#'
#' @param .rand_data A data frame from which column names are to be extracted.
#' @param .dim_names The dimnames passed from the rand walk function.
#' @param .num_sims The number of simulations.
#' @param .t Ther periods in the walk
#'
#' @name rand_walk_column_names
NULL
#'
#' @rdname rand_walk_column_names
#'
#' @export
rand_walk_column_names <- function(.rand_data, .dim_names, .num_sims, .t) {
  # Set column names
  rand_steps <- stats::setNames(.rand_data, .dim_names)
  rand_steps <- purrr::map(rand_steps, \(x) dplyr::as_tibble(x)) |>
    purrr::list_cbind()
  colnames(rand_steps) <- .dim_names
  rand_steps <- purrr::map(
    rand_steps, \(x) x |>
      unlist(use.names = FALSE)) |>
    dplyr::as_tibble()

  # Combine into a tibble
  rand_steps <- dplyr::tibble(
    walk_number = factor(.num_sims),
    step_number = 1:.t
  ) |>
    dplyr::bind_cols(rand_steps)

  return(rand_steps)
}

#' Subset Walks by Extreme Values
#'
#' @family Utility Functions
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description This function subsets random walks to identify the walk with the
#' maximum or minimum value.
#'
#' @details The `subset_walks` function takes a data frame containing random
#' walks and subsets it to return the walk with the maximum or minimum value
#' based on the specified type. It requires that the input data frame contains
#' columns `walk_number` and the specified value column.
#'
#' @param .data A data frame containing random walks. It must have columns `walk_number` and the specified value column.
#' @param .type A character string specifying the type of subset: "max" for maximum value, "min" for minimum value, or "both" for both maximum and minimum values.
#' @param .value A character string specifying the column name to use for finding extreme values. Defaults to "y".
#'
#' @return A data frame containing the subset walk.
#'
#' @examples
#' set.seed(123)
#' df <- rw30()
#' subset_walks(df, .type = "max")
#' subset_walks(df, .type = "min")
#' subset_walks(df, .type = "both")
#'
#' # Example with a specific value column
#' set.seed(123)
#' discrete_walk() |>
#'   subset_walks(.type = "both", .value = "cum_sum_y") |>
#'   visualize_walks(.pluck = 2)
#'
#' @name subset_walks
NULL
#'
#' @rdname subset_walks
#'
#' @export
subset_walks <- function(.data, .type = "max", .value = "y") {
  if (!.type %in% c("max", "min", "both")) {
    rlang::abort("Invalid .type. Choose from 'max', 'min', or 'both'.")
  }

  if (.type == "max") {
    max_row <- .data[which.max(.data[[.value]]), ]
    return(.data[.data$walk_number == max_row$walk_number, ])
  } else if (.type == "min") {
    min_row <- .data[which.min(.data[[.value]]), ]
    return(.data[.data$walk_number == min_row$walk_number, ])
  } else if (.type == "both") {
    max_row <- .data[which.max(.data[[.value]]), ]
    min_row <- .data[which.min(.data[[.value]]), ]
    max_walk <- .data[.data$walk_number == max_row$walk_number, ]
    min_walk <- .data[.data$walk_number == min_row$walk_number, ]
    return(dplyr::bind_rows(max_walk, min_walk))
  }
}
