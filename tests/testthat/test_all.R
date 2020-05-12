# Tests of the main exported functions
context("Testing main functions")


check_api <- function() {
  if (httr::GET('https://www150.statcan.gc.ca/t1/wds/rest/getCodeSets')$status_code != 200) {
    skip("API not available")
  }
}

test_that('Download URL returns text', {
  check_api()
  download_url <- get_product_download_url('14100287')
  expect_that(download_url, is_a("character"))
})


test_that('Product metadata is a list', {
  check_api()
  metadata <- get_product_metadata('14100287')
  expect_that(metadata, is_a("list"))
})

test_that('Product cube downloads', {
  check_api()
  pid <- '1310076601'
  download_product_cube(pid)
})

