#' Generate a Random Displacement Walk in 2D
#'
#' @family Generator Functions
#' @family Discrete Distribution
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @description
#' The `random_displacement_walk` function generates a single random walk in 2 dimensions (x, y),
#' where each step is a random displacement in both x and y directions, sampled from the provided
#' displacement and distance spaces. The walk disregards steps where both x and y displacements are zero.
#'
#' @param .num_walks An integer specifying the number of random walks to generate. Default is 25.
#' @param .seed An optional value to set the random seed. If NULL, no seed is set. Default is NULL.
#' @param .n The number of steps in the walk. Must be >= 0. Default is 100.
#' @param .distance_space A numeric vector of possible step distances. Default is c(0, 1, 2, 3, 4).
#' @param .displacement A numeric vector of possible step directions. Default is c(-1, 1).
#' @param .dimensions An integer specifying the number of dimensions (1, 2, or 3). Default is 1.
#'
#' @return A tibble with columns depending on the number of dimensions:
#'   \itemize{
#'     \item `step_number`: Step index.
#'     \item `y`: If `.dimensions = 1`, the value of the walk at each step.
#'     \item `x`, `y`: If `.dimensions = 2`, the values of the walk in two dimensions.
#'     \item `x`, `y`, `z`: If `.dimensions = 3`, the values of the walk in three dimensions.
#'   }
#'
#' The tibble includes attributes for the function parameters.
#'
#' @examples
#' random_displacement_walk(.n = 10, .seed = Sys.Date())
#'
#' @export
random_displacement_walk <- function(
  .num_walks = 25,
  .seed = NULL,
  .n = 100,
  .distance_space = c(0, 1, 2, 3, 4),
  .displacement = c(-1, 1),
  .dimensions = 1
) {
  # Defensive checks

  if (.num_walks < 0) {
    rlang::abort(".num_walks cannot be less than 0", use_cli_format = TRUE)
  }
  if (!is.null(.seed)) {
    set.seed(.seed)
  }
  if (.n < 0) {
    rlang::abort(".n must be greater than or equal to 0", use_cli_format = TRUE)
  }
  if (length(.distance_space) == 0) {
    rlang::abort(".distance_space must have at least one value", use_cli_format = TRUE)
  }
  if (length(.displacement) == 0) {
    rlang::abort(".displacement must have at least one value", use_cli_format = TRUE)
  }
  if (!.dimensions %in% c(1, 2, 3)) {
    rlang::abort("Number of dimensions must be 1, 2, or 3.", use_cli_format = TRUE)
  }

  num_walks     <- as.integer(.num_walks)
  n             <- as.integer(.n)
  distance_space <- .distance_space
  displacement   <- .displacement

  # Define dimension names
  dim_names <- switch(.dimensions,
                      `1` = c("y"),
                      `2` = c("x", "y"),
                      `3` = c("x", "y", "z"))

  # Function to generate a single walk
  generate_walk <- function(walk_num) {
    values <- lapply(1:.dimensions, function(i) numeric(n + 1))
    num <- 1
    while (num < n + 1) {
      walked <- sapply(1:.dimensions, function(i) sample(displacement, size = 1, replace = TRUE) *
                                              sample(distance_space, size = 1, replace = TRUE))
      # disregard all zero vector
      if (all(walked == 0)) next
      for (i in seq_len(.dimensions)) {
        values[[i]][num + 1] <- walked[i] + values[[i]][num]
      }
      num <- num + 1
    }
    res <- tibble::tibble(
      walk_number = factor(walk_num, levels = 1:num_walks),
      step_number = 0:n
    ) |>
      dplyr::mutate(step_number = step_number + 1)
    for (i in seq_along(dim_names)) {
      res[[dim_names[i]]] <- values[[i]]
    }
    res
  }

  # Generate all walks
  res <- purrr::map_dfr(1:num_walks, generate_walk)

  # Add attributes
  attr(res, "n")             <- n
  attr(res, "num_walks")     <- num_walks
  attr(res, "distance_space")<- distance_space
  attr(res, "displacement")  <- displacement
  attr(res, "seed")          <- .seed
  attr(res, "fns")           <- "random_displacement_walk"
  attr(res, "dimensions")    <- .dimensions

  return(res)
}
