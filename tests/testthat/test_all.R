# Tests of the main exported functions
context("Testing main functions")


test_that(
  'Download URL returns text', {
  download_url <- get_product_download_url('14100287')
  expect_that(download_url, is_a("character"))
})


test_that('Product metadata is a list', {
  metadata <- get_product_metadata('14100287')
  expect_that(metadata, is_a("list"))
})


