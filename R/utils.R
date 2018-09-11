
#' @importFrom httr GET content
# Get the download zip file url for a given product
get_product_download_url <- function(pid) {
  url <- paste0('https://www150.statcan.gc.ca/t1/wds/rest/getFullTableDownloadCSV/', pid, '/en')

  request <- GET(url)
  response <- content(request)
  if (response$status == "SUCCESS") {
    result <- response$object
  } else {
    print("ERROR")
  }
  return(result)
}


#' @importFrom httr POST content
#' @importFrom jsonlite toJSON
get_coord_info <- function(pid, coord_id) {

  if (nchar(gsub("\\.", "", coord_id)) < 10) {
    zerosfiller <- paste(rep("0", (10 - nchar(gsub("\\.", "", coord_id)))), collapse='.')
    coord_id <- paste(c(coord_id, zerosfiller), collapse='.')
  } else if (nchar(gsub("\\.", "", coord_id)) > 10) {
    stop("Coordinate cannot be greater than 10 digits")
  }

  url <- 'https://www150.statcan.gc.ca/t1/wds/rest/getSeriesInfoFromCubePidCoord'

  req <- POST(
    url,
    content_type('application/json'),
    body = toJSON(data.frame(
      productId = as.numeric(pid),
      coordinate = coord_id
    ))
  )
  response <- content(req)[[1]]

  if (response$status == "SUCCESS") {
    return(response$object)
  } else {
    print('ERROR')
  }
}


# Retrieve CodeSets
#' @importFrom httr GET content
get_codes <- function() {
  url <- 'https://www150.statcan.gc.ca/t1/wds/rest/getCodeSets'
  req <- GET(url)
  response <- content(req)
  return(response$object)
}

# convert a json vector point object to a data frame observation
normalize_vectorpoint <- function(vectorpoint) {
  dd <- data.frame(
    REF_DATE = vectorpoint$refPer,
    VALUE = ifelse(
      vectorpoint$scalarFactorCode > 0,
      vectorpoint$value*(10*vectorpoint$scalarFactorCode),
      vectorpoint$value
    ),
    stringsAsFactors = FALSE
  )
  return(dd)
}

flatten_df_list <- function(ll) {
  do.call('rbind', lapply(ll, function(x) `length<-`(x, max(lengths(ll)))))
}



# get metadata stuff
#' @importFrom plyr rbind.fill
get_dim_names <- function(metadata) {
  # unlist(lapply(metadata$dimension, function(x) x$dimensionNameEn))
  rbind.fill(lapply(metadata$dimension, function(x) {
    as.data.frame(t(unlist(x)), stringsAsFactors = FALSE)
  }))
}

#' @importFrom plyr rbind.fill
get_member_names <- function(dimension) {
  rbind.fill(
    lapply(dimension$member, function(x) {
      as.data.frame(t(unlist(x)), stringsAsFactors = FALSE)
    })
  )
}

# creates all possible coordinates from a given product cube
build_coordinates <- function(metadata) {
  # nbSeriesCube <- metadata$nbSeriesCube
  ndims <- length(metadata$dimension)
  nmems <- sapply(metadata$dimension, function(x) length(x$member))
  mem_args <- lapply(1:ndims, function(x) 1:nmems[[x]])
  apply(expand.grid(mem_args), 1, paste, collapse=".")
}


