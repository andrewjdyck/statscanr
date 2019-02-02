#' Download StatsCan Coordinate Data from Product Cube
#'
#' This function allows you to download a coordinate series from
#' Statistics Canada.
#' @param productId The Statistics Canada Product ID.
#' @param coordinateId The Statistics Canada Coordinate ID (10 digits).
#' @param nperiods Number of time periods.
#' @keywords productId, cube, coordinate
#' @importFrom httr POST content
#' @importFrom jsonlite toJSON fromJSON
#' @export
#' @examples
#' get_coordinate_data('14100287', '1.1.1.1.1.2.0.0.0.0', 3)
#'
get_coordinate_data <- function(productId, coordinateId, nperiods) {
  url <- 'https://www150.statcan.gc.ca/t1/wds/rest/getDataFromCubePidCoordAndLatestNPeriods'

  req <- POST(
    url,
    content_type('application/json'),
    body = toJSON(data.frame(
      productId = as.numeric(productId),
      coordinate = coordinateId,
      latestN = nperiods
    ))
  )

  response <- content(req)[[1]]

  # normalize_vectorpoint(response$object$vectorDataPoint[[1]])
  returnFrame <- as.data.frame(lapply(fromJSON(toJSON(response$object$vectorDataPoint)), unlist), stringsAsFactors = FALSE)
  return(returnFrame)
}



