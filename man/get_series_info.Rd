% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_series_info.R
\name{get_series_info}
\alias{get_series_info}
\title{Download StatsCan Series Ino}
\usage{
get_series_info(productId = NA, coordinateId = NA, vectorId = NA)
}
\arguments{
\item{productId}{The Statistics Canada Product ID (8 or 10 digits).}

\item{coordinateId}{The Statistics Canada Coordinate ID (10 digits).}

\item{vectorId}{The Statistics Canada Vector ID (up to 10 digits)}
}
\description{
This function allows you to download info about
a series from Statistics Canada.
}
\examples{
get_series_info('14100287', '1.1.1.1.1.2.0.0.0.0')
get_series_info(vectorId='2064888')

}
\keyword{coordinate}
\keyword{cube,}
\keyword{productId,}
