#' Print frequency tables
#'
#' S3 method for class 'freq_table'
#'
#' @param x object of class \code{freq.table}
#' @param ... optional arguments to \code{data.frame}
#'
#' @example
#' # Suppress external output for examples
#' options(frequency_render = FALSE)
#'
#' x <- freq(big5[1])
#' print(x)
#' print(x[[1]])
#'
#' @export
print.freq_table <- function(x, ...){
  print.data.frame(x, ..., row.names = FALSE)
}
