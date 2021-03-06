% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_changed_cube_data.R
\name{get_changed_cube_data}
\alias{get_changed_cube_data}
\title{Download StatsCan Coordinate Changed Data from Product Cube}
\usage{
get_changed_cube_data(productId, coordinateId)
}
\arguments{
\item{productId}{The Statistics Canada Product ID.}

\item{coordinateId}{The Statistics Canada Coordinate ID (10 digits).}
}
\description{
This function allows you to download a coordinate series from
Statistics Canada that has been changed.
}
\examples{
get_changed_cube_data('14100287', '1.1.1.1.1.2.0.0.0.0')

}
\keyword{coordinate}
\keyword{cube,}
\keyword{productId,}
