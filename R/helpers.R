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
#' @family caption generation
#' @author Your Name
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
