library(RandomWalker)

walks <- data.frame(
  walk_number = rep(1:2, each = 4),
  batch = rep(c("a", "b"), 4),
  y = c(1, 2, 4, 8, 3, 6, 9, 12)
)
attr(walks, "fns") <- "random_normal_walk"
attr(walks, "n") <- 4L
attr(walks, "dimensions") <- 1L

check_summary <- function(result, values) {
  moments <- NNS::NNS.moments(values)
  expected <- c(
    mean_val = mean(values), median = median(values),
    range = diff(range(values)),
    quantile_lo = unname(quantile(values, 0.025)),
    quantile_hi = unname(quantile(values, 0.975)),
    variance = moments[["variance"]], sd = sd(values),
    min_val = min(values), max_val = max(values),
    harmonic_mean = length(values) / sum(1 / values),
    geometric_mean = exp(mean(log(values))),
    skewness = moments[["skewness"]], kurtosis = moments[["kurtosis"]]
  )
  stopifnot(nrow(result) == 1L)
  stopifnot(isTRUE(all.equal(
    unname(unlist(result[names(expected)])), unname(expected)
  )))
}

overall <- summarize_walks(walks, y)
check_summary(overall, walks$y)
stopifnot(identical(overall, summarize_walks(walks, y, NULL)))
stopifnot(!"walk_number" %in% names(overall))
stopifnot(overall$dimensions == 1L, overall$obs == 4L)

by_walk <- summarize_walks(walks, y, walk_number)
by_batch <- summarize_walks(walks, y, batch)
stopifnot(nrow(by_walk) == 2L, nrow(by_batch) == 2L)
for (i in seq_len(2L)) {
  check_summary(by_walk[i, ], walks$y[walks$walk_number == by_walk$walk_number[i]])
  check_summary(by_batch[i, ], walks$y[walks$batch == by_batch$batch[i]])
}

pregrouped <- dplyr::group_by(walks, batch)
stopifnot(identical(overall, summarize_walks(pregrouped, y)))
stopifnot(identical(overall, summarize_walks(pregrouped, y, NULL)))
stopifnot(identical(by_walk, summarize_walks(pregrouped, y, walk_number)))
stopifnot(identical(overall, summarise_walks(walks, y)))
stopifnot(identical(by_walk, summarise_walks(walks, y, walk_number)))
stopifnot(identical(overall, summarise_walks(pregrouped, y, NULL)))

legacy <- walks
attr(legacy, "dimensions") <- NULL
attr(legacy, "dimension") <- 2L
stopifnot(summarize_walks(legacy, y)$dimensions == 2L)
attr(legacy, "dimensions") <- 3L
stopifnot(summarize_walks(legacy, y)$dimensions == 3L)
attr(legacy, "dimensions") <- NULL
attr(legacy, "dimension") <- NULL
stopifnot(identical(summarize_walks(legacy, y)$dimensions, NA_integer_))

set.seed(289)
for (dimension in 1:3) {
  generated <- random_normal_walk(
    .num_walks = 2, .n = 20, .dimensions = dimension,
    .mu = 10, .sd = 0.1
  )
  result <- summarize_walks(generated, y)
  stopifnot(nrow(result) == 1L, result$dimensions == dimension)
  stopifnot(nrow(summarize_walks(generated, y, walk_number)) == 2L)
}
automatic <- rw30()
result <- suppressWarnings(summarize_walks(automatic, y))
stopifnot(nrow(result) == 1L, result$dimensions == 1L)
stopifnot(nrow(suppressWarnings(
  summarize_walks(automatic, y, walk_number)
)) == length(unique(automatic$walk_number)))

# Preserve the existing input requirement.
invalid <- walks
invalid$walk_number <- NULL
stopifnot(inherits(try(summarize_walks(invalid, y), silent = TRUE), "try-error"))
