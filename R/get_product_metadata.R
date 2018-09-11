#' Download StatsCan Metadata from Product Cube
#'
#' This function allows you to download product metadata from
#' Statistics Canada.
#' @param productId The Statistics Canada Product ID.
#' @keywords productId, product, metadata
#' @importFrom httr POST content content_type
#' @export
#' @examples
#' get_product_metadata('14100287')
#'
get_product_metadata <- function(productId) {
  url <- 'https://www150.statcan.gc.ca/t1/wds/rest/getCubeMetadata'

  req <- POST(
    url,
    content_type('application/json'),
    body = toJSON(data.frame(productId = as.numeric(productId)))
  )

  response <- content(req)[[1]]

  if (response$status == "SUCCESS") {
    return(response$object)
  } else {
    print('ERROR')
  }
}
