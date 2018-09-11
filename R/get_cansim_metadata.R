#' Download StatsCan Metadata from Legacy CASIM Table
#'
#' This function allows you to download product metadata from
#' Statistics Canada.
#' @param cansimId The Statistics Canada Legacy CANSIM ID.
#' @keywords cansimId, CANSIM, metadata
#' @export
#' @examples
#' get_cansim_metadata('2820087')
#'
get_cansim_metadata <- function(cansimId) {

  productId <- read_cansim_product_mapping(cansimId = cansimId)

  get_product_metadata(productId)
}
