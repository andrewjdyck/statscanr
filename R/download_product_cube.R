#' Download StatsCan Product Cube
#'
#' This function allows you to download a product cube from
#' Statistics Canada.
#' @param productId The Statistics Canada Product ID.
#' @keywords productId, cube, product, csv
#' @export
#' @importFrom utils download.file read.csv unzip
#' @examples
#' \dontrun{
#' download_product_cube('14100287')
#' }
download_product_cube <- function(productId) {

  temp1 <- tempfile()
  temp2 <- tempfile()

  download_url <- get_product_download_url(productId)

  download.file(download_url, temp1)
  unzip(temp1, paste0(productId, ".csv"), exdir = temp2)
  returnFrame <- read.csv(paste0(temp2, '/', productId, ".csv"), stringsAsFactors = FALSE)
  unlink(temp1)
  unlink(temp2)
  return(returnFrame)
}
