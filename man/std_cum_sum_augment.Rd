% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/helpers.R
\name{std_cum_sum_augment}
\alias{std_cum_sum_augment}
\title{Augment Cumulative Sum}
\usage{
std_cum_sum_augment(.data, .value, .names = "auto", .initial_value = 0)
}
\arguments{
\item{.data}{A data frame to augment.}

\item{.value}{A column name or names for which to compute the cumulative sum.}

\item{.names}{Optional. A character vector of names for the new cumulative
sum columns. Defaults to "auto", which generates names based on the original
column names.}

\item{.initial_value}{A numeric value to start the cumulative sum from.
Defaults to 0.}
}
\value{
A tibble with the original data and additional columns containing
the cumulative sums.
}
\description{
This function augments a data frame by adding cumulative sum
columns for specified variables.
}
\details{
The function takes a data frame and a column name (or names) and
computes the cumulative sum for each specified column, starting from an
initial value. If the column names are not provided, it will throw an error.
}
\examples{
df <- data.frame(x = 1:5, y = 6:10)
std_cum_sum_augment(df, .value = x)
std_cum_sum_augment(df, .value = y, .names = c("cumsum_y"))

}
\seealso{
Other Utility Functions: 
\code{\link{confidence_interval}()},
\code{\link{convert_snake_to_title_case}()},
\code{\link{generate_caption}()},
\code{\link{get_attributes}()},
\code{\link{rand_walk_column_names}()},
\code{\link{rand_walk_helper}()},
\code{\link{running_quantile}()},
\code{\link{std_cum_max_augment}()},
\code{\link{std_cum_mean_augment}()},
\code{\link{std_cum_min_augment}()},
\code{\link{std_cum_prod_augment}()},
\code{\link{subset_walks}()}
}
\author{
Steven P. Sanderson II, MPH
}
\concept{Utility Functions}
