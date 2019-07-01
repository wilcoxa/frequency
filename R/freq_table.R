#' Print frequency tables
#'
print.freq_table <- function(x, ...){
  print.data.frame(x, ..., row.names = FALSE)
}
