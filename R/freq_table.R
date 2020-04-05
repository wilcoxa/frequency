#' Print frequency tables
#'
#' S3 method for class 'freq_table'
#'
#' @param x object of class \code{freq.table}
#' @param ... optional arguments to \code{data.frame}
print.freq_table <- function(x, ...){
  print.data.frame(x, ..., row.names = FALSE)
}
