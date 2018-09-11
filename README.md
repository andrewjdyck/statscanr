
Linux: ![travis](https://travis-ci.org/andrewjdyck/statscanr.png)
<!-- ![CRAN_downloads](http://cranlogs.r-pkg.org/badges/statscanr) -->  


# statscanr #
An R package for working with the Statistics Canada Web Data Services.


# Installing #

```r
install.packages("statscanr")
```

or grab the development version. To install this version you'll need the `devtools` package first.


```r
# install.packages('devtools')
devtools::install_github('andrewjdyck/statscanr')
```

# Usage #

Statistics Canada table 14-10-0287-03 (formerly CANSIM  282-0087) is available online at https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1410028703. The code below is used to load the entire product cube into a data.frame in memory. Note that this may take some time to download (48MB zipped) and then unzip and load the extracted CSV into memory.


```r
library(statscanr)

# Using the legacy CANSIM ID
cansimId <- '2820087'
productId <- read_cansim_product_mapping(cansimId = cansimId)

# Read the product metadata
metadata <- get_product_metadata(productId)

# Read the product cube into R
df <- download_product_cube(productId)

# One can also load the latest 10 observations for a single coordinate in the product cube with the code below.
# Coordinate ID 1.1.1.1.1.2.0.0.0.0 is for the following:
# Canada, Population, Both sexes, 15 years and over, Estimate, Unadjusted, Persons

coordinateId <- '1.1.1.1.1.2.0.0.0.0'
can_pop <- get_coordinate_data(productId, coordinateId, 10)

```


# Statistics Canada Web Data Services Notes #

https://www.statcan.gc.ca/eng/developers/wds

## Web Data Services User Guide ##

https://www.statcan.gc.ca/eng/developers/wds/user-guide


