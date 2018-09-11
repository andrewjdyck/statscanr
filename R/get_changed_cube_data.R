#' Download StatsCan Coordinate Changed Data from Product Cube
#'
#' This function allows you to download a coordinate series from
#' Statistics Canada that has been changed.
#' @param productId The Statistics Canada Product ID.
#' @param coordinateId The Statistics Canada Coordinate ID (10 digits).
#' @keywords productId, cube, coordinate
#' @importFrom httr POST content content_type
#' @importFrom jsonlite toJSON fromJSON
#' @export
#' @examples
#' get_changed_cube_data('14100287', '1.1.1.1.1.2.0.0.0.0')
#'
get_changed_cube_data <- function(productId, coordinateId) {

  url <- 'https://www150.statcan.gc.ca/t1/wds/rest/getChangedSeriesDataFromCubePidCoord'

  req <- POST(
    url,
    content_type('application/json'),
    body = toJSON(data.frame(
      productId = as.numeric(productId),
      coordinate = coordinateId
    ))
  )
  response <- content(req)[[1]]
  return(response)
}
