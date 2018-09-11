#' A function to map legacy CANSIM ID to Product ID
#'
#' This function allows you to either download the entire
#' Statistics Canada CANSIM ID to Product ID concordance or
#' map a single CANSIM ID to Product ID.
#' @param cansimId The Statistics Canada CANSIM ID.
#' @param productId The Statistics Canada Product ID.
#' @keywords productId, cansimId, csv, concordance
#' @export
#' @examples
#' read_cansim_product_mapping()
#' read_cansim_product_mapping(productId = '14100287')
#' read_cansim_product_mapping(cansimId = '2820087')
#'
read_cansim_product_mapping <- function(cansimId='all', productId='all') {

  if (cansimId != 'all' & productId != 'all') {
    stop("ERROR: Only one of cansimId or productId can be entered")
  } else {
    cansim_concordance <- read.csv('https://www.statcan.gc.ca/eng/developers-developpeurs/cansim_id-product_id-concordance.csv', stringsAsFactors = FALSE)
    if (cansimId == 'all' & productId == 'all') {
      returnFrame <- cansim_concordance
    } else if (cansimId != 'all') {
      returnFrame <- cansim_concordance[which(cansim_concordance$CANSIM_ID == cansimId), 'PRODUCT_ID']
    } else if (productId != 'all') {
      returnFrame <- cansim_concordance[which(cansim_concordance$PRODUCT_ID == productId), 'CANSIM_ID']
    }
  }

  return(returnFrame)
}
