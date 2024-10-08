% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/vec-cumulative-functions.R
\name{rw_range}
\alias{rw_range}
\title{Range}
\usage{
rw_range(.x)
}
\arguments{
\item{.x}{A numeric vector}
}
\value{
A numeric vector
}
\description{
A function to return the range of a vector.
}
\details{
A function to return the range of a vector. It uses \code{max(.x) - min(.x)} as
the basis of the function.
}
\examples{
x <- mtcars$mpg

rw_range(x)

}
\seealso{
Other Vector Function: 
\code{\link{cgmean}()},
\code{\link{chmean}()},
\code{\link{ckurtosis}()},
\code{\link{cmean}()},
\code{\link{cmedian}()},
\code{\link{crange}()},
\code{\link{csd}()},
\code{\link{cskewness}()},
\code{\link{cvar}()},
\code{\link{euclidean_distance}()},
\code{\link{kurtosis_vec}()},
\code{\link{skewness_vec}()}
}
\author{
Steven P. Sanderson II, MPH
}
\concept{Vector Function}
