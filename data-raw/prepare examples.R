#'------------------------------------------------------------------------------
#'
#' Prepare example data sets
#'
#' Source:
#' https://openpsychometrics.org/_rawdata/
#' https://openpsychometrics.org/_rawdata/BIG5.zip
#'
#'

# load
x <- read.table("data-raw/big5_rawdata.csv", sep = "\t", header = T, stringsAsFactors = FALSE)

# not really useful
x$source <- NULL

# try to make the file a bit smaller - remove under 18s
x <- x[!x$age %in% c(13:17, 1997:2000), ]

# add variable and value labels
source("data-raw/label dataset.R")

# export
big5 <- x
# save(big5, file = "big5.RDS")
devtools::use_data(big5, overwrite = T, )
