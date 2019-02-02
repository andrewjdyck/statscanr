#' Download StatsCan Series Ino
#'
#' This function allows you to download info about
#' a series from Statistics Canada.
#' @param productId The Statistics Canada Product ID (8 or 10 digits).
#' @param coordinateId The Statistics Canada Coordinate ID (10 digits).
#' @param vectorId The Statistics Canada Vector ID (up to 10 digits)
#' @keywords productId, cube, coordinate
#' @importFrom httr POST content content_type
#' @importFrom jsonlite toJSON fromJSON
#' @export
#' @examples
#' get_series_info('14100287', '1.1.1.1.1.2.0.0.0.0')
#' get_series_info(vectorId='2064888')
#'
get_series_info <- function(productId=NA, coordinateId=NA, vectorId=NA) {

  if (!is.na(vectorId)) {
    url <- 'https://www150.statcan.gc.ca/t1/wds/rest/getSeriesInfoFromVector'
    req <- POST(
      url,
      content_type('application/json'),
      body = toJSON(data.frame(
        vectorId = as.numeric(vectorId)
      ))
    )
  } else {
    if (is.na(productId) | is.na(coordinateId)) {
      stop('Both productId AND coordinateId must be supplied, OR a vectorId can be used.')
    } else {
      url <- 'https://www150.statcan.gc.ca/t1/wds/rest/getSeriesInfoFromCubePidCoord'
      req <- POST(
        url,
        content_type('application/json'),
        body = toJSON(data.frame(
          productId = as.numeric(productId),
          coordinate = coordinateId
        ))
      )
    }
  }

  response <- content(req)[[1]]
  if (response$status == 'SUCCESS') {
    returnFrame <- as.data.frame(lapply(fromJSON(toJSON(response$object)), unlist), stringsAsFactors = FALSE)
  } else {
    returnFrame <- data.frame()
  }
  return(returnFrame)
}
