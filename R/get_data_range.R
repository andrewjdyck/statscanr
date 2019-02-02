#' Download StatsCan Vector Data by date range
#'
#' This function allows you to download a data range
#' @param productId The Statistics Canada Product ID.
#' @param coordinateId The Statistics Canada Coordinate ID (10 digits).
#' @param vectorId The Statistics Canada Vector ID (10 digits).
#' @keywords productId, cube, coordinate
#' @importFrom httr POST content
#' @importFrom jsonlite toJSON fromJSON
#' @export
#' @examples
#' get_data_range(vectorId='2064888', startDt="2015-12-01T08:30", endDt="2018-03-31T19:00")
#'
get_data_range <- function(productId=NA, coordinateId=NA, vectorId=NA, startDt, endDt) {

  if (is.na(vectorId)) {
    vectorId <- get_series_info(productId, coordinateId)$vectorId
  }

  url <- 'https://www150.statcan.gc.ca/t1/wds/rest/getBulkVectorDataByRange'
  req <- POST(
    url,
    content_type('application/json'),
    body = toJSON(list(
      vectorIds = c('74804', '1'),
      startDataPointReleaseDate = startDt,
      endDataPointReleaseDate = endDt
    ), auto_unbox = TRUE)
  )

  response <- content(req)[[1]]

  returnFrame <- as.data.frame(lapply(fromJSON(toJSON(response$object$vectorDataPoint)), unlist), stringsAsFactors = FALSE)
  return(returnFrame)
}



