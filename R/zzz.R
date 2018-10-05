.onLoad <- function(libname, pkgname) {
  op <- options()
  op.frequency <- list(
    frequency_open_output = FALSE,
    frequency_sort_by = "value",
    frequency_sort_descending = FALSE,


    frequency_trim = TRUE,

    # formatting options

    # testing options
    frequency_output_viewer = TRUE

  )
  toset <- !(names(op.frequency) %in% names(op))
  if(any(toset)) options(op.frequency[toset])

  invisible()
}
