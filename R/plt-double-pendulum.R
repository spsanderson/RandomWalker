#' Plot a Double Pendulum Trajectory
#' @family Visualization Functions
#'
#' @importFrom rlang .data
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @param .data Data returned by [double_pendulum_walk()].
#' @param .walk One walk_number label to display, rather than its position.
#' @return A customizable ggplot of the second bob's spatial trajectory,
#' colored by elapsed seconds. Coordinates are in meters.
#'
#' @return a ggplot2 object.
#'
#' @examples
#' if (requireNamespace("deSolve", quietly = TRUE)) {
#'   plot_double_pendulum(double_pendulum_walk(.num_walks = 1, .n = 200))
#' }
#' @export
plot_double_pendulum <- function(.data, .walk = 1) {
  pendulum_require("ggplot2")
  frame <- pendulum_plot_data(.data, .walk)
  ggplot2::ggplot(frame, ggplot2::aes(x = .data$x, y = .data$y, colour = .data$time)) +
    ggplot2::geom_path(linewidth = 0.5) +
    ggplot2::scale_colour_viridis_c(name = "Time (s)") +
    ggplot2::coord_equal() + ggplot2::theme_minimal() +
    ggplot2::labs(title = paste("Double pendulum: walk", .walk), x = "x (m)", y = "y (m)")
}

#' Animate a Double Pendulum
#' @family Visualization Functions
#'
#' @author Steven P. Sanderson II, MPH
#'
#' @inheritParams plot_double_pendulum
#'
#' @param .trail_length Nonnegative integer number of recent sampled positions
#' in the second bob's trail, including the current position. Zero disables it.
#'
#' @return A gganim object. Construction does not render or save files.
#'
#' @details Requires optional packages ggplot2 and gganimate. GIF rendering
#' additionally requires gifski. Each observation is one discrete frame;
#' rendering at `fps = 1 / .delta_time` preserves simulated time.
#'
#' @examples
#' \dontrun{
#' walks <- double_pendulum_walk(.num_walks = 1, .n = 200)
#' animation <- animate_double_pendulum(walks)
#' gif <- gganimate::animate(animation, nframes = attr(walks, "n"),
#'   fps = 1 / attr(walks, "delta_time"), renderer = gganimate::gifski_renderer())
#' gganimate::anim_save("double-pendulum.gif", animation = gif)
#' }
#' @export
animate_double_pendulum <- function(.data, .walk = 1, .trail_length = 30) {
  pendulum_require("ggplot2")
  pendulum_require("gganimate")
  pendulum_scalar(.trail_length, ".trail_length")
  if (.trail_length < 0 || .trail_length != floor(.trail_length)) {
    rlang::abort(".trail_length must be a nonnegative integer.")
  }
  frame <- pendulum_plot_data(.data, .walk)
  frame$frame <- seq_len(nrow(frame))
  frame$label <- sprintf("t = %.3f s", frame$time)
  frame$pivot_x <- 0
  frame$pivot_y <- 0
  limits <- function(values) {
    bounds <- range(c(0, values))
    padding <- max(diff(bounds) * 0.05, 0.05)
    bounds + c(-padding, padding)
  }
  xlim <- limits(c(frame$x1, frame$x))
  ylim <- limits(c(frame$y1, frame$y))
  plot <- ggplot2::ggplot()
  if (.trail_length > 1) {
    trail <- dplyr::bind_rows(lapply(frame$frame, function(i) {
      part <- frame[seq.int(max(1, i - .trail_length + 1), i), ]
      part$frame <- i
      part
    }))
    trail <- trail[trail$frame > 1, ]
    # Explicit levels preserve time zero even though the first trail is empty.
    trail$frame <- factor(trail$frame, levels = frame$frame)
    plot <- plot + ggplot2::geom_path(data = trail,
      ggplot2::aes(x = .data$x, y = .data$y, group = .data$frame),
      colour = "#D55E00", alpha = 0.5)
  }
  frame$frame <- factor(frame$frame, levels = frame$frame)
  plot +
    ggplot2::geom_segment(data = frame,
      ggplot2::aes(x = 0, y = 0, xend = .data$x1, yend = .data$y1), linewidth = 1) +
    ggplot2::geom_segment(data = frame,
      ggplot2::aes(x = .data$x1, y = .data$y1, xend = .data$x, yend = .data$y), linewidth = 1) +
    ggplot2::geom_point(data = frame, ggplot2::aes(x = .data$x1, y = .data$y1),
                       colour = "#0072B2", size = 4) +
    ggplot2::geom_point(data = frame, ggplot2::aes(x = .data$x, y = .data$y),
                       colour = "#D55E00", size = 4) +
    ggplot2::geom_point(data = frame,
      ggplot2::aes(x = .data$pivot_x, y = .data$pivot_y), size = 2) +
    ggplot2::geom_text(data = frame,
      ggplot2::aes(x = xlim[1], y = ylim[2], label = .data$label), hjust = 0, vjust = 1) +
    ggplot2::coord_equal(xlim = xlim, ylim = ylim, expand = FALSE) +
    ggplot2::theme_minimal() +
    ggplot2::labs(title = paste("Double pendulum: walk", .walk), x = "x (m)", y = "y (m)") +
    gganimate::transition_manual(frame)
}

pendulum_plot_data <- function(data, walk) {
  required <- c("walk_number", "step_number", "time", "x1", "y1", "x", "y")
  if (!is.data.frame(data) || !all(required %in% names(data))) {
    rlang::abort(paste(".data must contain", paste(required, collapse = ", ")))
  }
  if (length(walk) != 1L || is.na(walk) || !(is.character(walk) || is.numeric(walk))) {
    rlang::abort(".walk must be one walk_number label.")
  }
  frame <- data[!is.na(data$walk_number) & as.character(data$walk_number) == as.character(walk), required]
  if (nrow(frame) < 2L) rlang::abort("The selected walk must exist and contain at least two observations.")
  for (name in required[-1]) {
    if (!is.numeric(frame[[name]]) || any(!is.finite(frame[[name]]))) {
      rlang::abort(paste0("Selected walk column '", name, "' must be finite and numeric."))
    }
  }
  if (anyDuplicated(frame$step_number)) rlang::abort("Selected walk has duplicate steps.")
  frame <- frame[order(frame$step_number), ]
  if (any(diff(frame$time) <= 0)) rlang::abort("Selected walk time must be strictly increasing.")
  frame
}
