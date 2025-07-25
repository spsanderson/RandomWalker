% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gen-random-brown-motion.R
\name{brownian_motion}
\alias{brownian_motion}
\title{Brownian Motion}
\usage{
brownian_motion(
  .num_walks = 25,
  .n = 100,
  .delta_time = 1,
  .initial_value = 0,
  .dimensions = 1
)
}
\arguments{
\item{.num_walks}{Total number of simulations.}

\item{.n}{Total time of the simulation.}

\item{.delta_time}{Time step size.}

\item{.initial_value}{Integer representing the initial value.}

\item{.dimensions}{The default is 1. Allowable values are 1, 2 and 3.}
}
\value{
A tibble containing the generated random walks with columns depending on the number of dimensions:
\itemize{
\item \code{walk_number}: Factor representing the walk number.
\item \code{step_number}: Step index.
\item \code{y}: If \code{.dimensions = 1}, the value of the walk at each step.
\item \code{x}, \code{y}: If \code{.dimensions = 2}, the values of the walk in two dimensions.
\item \code{x}, \code{y}, \code{z}: If \code{.dimensions = 3}, the values of the walk in three dimensions.
}

The following are also returned based upon how many dimensions there are and could be any of x, y and or z:
\itemize{
\item \code{cum_sum}: Cumulative sum of \code{dplyr::all_of(.dimensions)}.
\item \code{cum_prod}: Cumulative product of \code{dplyr::all_of(.dimensions)}.
\item \code{cum_min}: Cumulative minimum of \code{dplyr::all_of(.dimensions)}.
\item \code{cum_max}: Cumulative maximum of \code{dplyr::all_of(.dimensions)}.
\item \code{cum_mean}: Cumulative mean of \code{dplyr::all_of(.dimensions)}.
}
}
\description{
Create a Brownian Motion Tibble
}
\details{
Brownian Motion, also known as the Wiener process, is a
continuous-time random process that describes the random movement of particles
suspended in a fluid. It is named after the physicist Robert Brown,
who first described the phenomenon in 1827.

The equation for Brownian Motion can be represented as:

\if{html}{\out{<div class="sourceCode">}}\preformatted{W(t) = W(0) + sqrt(t) * Z
}\if{html}{\out{</div>}}

Where W(t) is the Brownian motion at time t, W(0) is the initial value of the
Brownian motion, sqrt(t) is the square root of time, and Z is a standard
normal random variable.

Brownian Motion has numerous applications, including modeling stock prices in
financial markets, modeling particle movement in fluids, and modeling random
walk processes in general. It is a useful tool in probability theory and
statistical analysis.
}
\examples{
set.seed(123)
brownian_motion()

set.seed(123)
brownian_motion(.dimensions = 3) |>
  head() |>
  t()

}
\seealso{
Other Generator Functions: 
\code{\link{discrete_walk}()},
\code{\link{geometric_brownian_motion}()},
\code{\link{random_beta_walk}()},
\code{\link{random_binomial_walk}()},
\code{\link{random_cauchy_walk}()},
\code{\link{random_chisquared_walk}()},
\code{\link{random_displacement_walk}()},
\code{\link{random_exponential_walk}()},
\code{\link{random_f_walk}()},
\code{\link{random_gamma_walk}()},
\code{\link{random_geometric_walk}()},
\code{\link{random_hypergeometric_walk}()},
\code{\link{random_logistic_walk}()},
\code{\link{random_lognormal_walk}()},
\code{\link{random_multinomial_walk}()},
\code{\link{random_negbinomial_walk}()},
\code{\link{random_normal_drift_walk}()},
\code{\link{random_normal_walk}()},
\code{\link{random_poisson_walk}()},
\code{\link{random_smirnov_walk}()},
\code{\link{random_t_walk}()},
\code{\link{random_uniform_walk}()},
\code{\link{random_weibull_walk}()},
\code{\link{random_wilcox_walk}()},
\code{\link{random_wilcoxon_sr_walk}()}

Other Continuous Distribution: 
\code{\link{geometric_brownian_motion}()},
\code{\link{random_beta_walk}()},
\code{\link{random_cauchy_walk}()},
\code{\link{random_chisquared_walk}()},
\code{\link{random_exponential_walk}()},
\code{\link{random_f_walk}()},
\code{\link{random_gamma_walk}()},
\code{\link{random_logistic_walk}()},
\code{\link{random_lognormal_walk}()},
\code{\link{random_normal_drift_walk}()},
\code{\link{random_normal_walk}()},
\code{\link{random_t_walk}()},
\code{\link{random_uniform_walk}()},
\code{\link{random_weibull_walk}()}
}
\author{
Steven P. Sanderson II, MPH
}
\concept{Continuous Distribution}
\concept{Generator Functions}
