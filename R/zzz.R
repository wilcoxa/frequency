.onLoad <- function(libname, pkgname) {
  op <- options()
  op.frequencies <- list(
    frequencies_open_output = FALSE,
    frequencies_sort_by = "value",
    frequencies_sort_descending = FALSE,


    frequencies_trim = TRUE,

    # formatting options

    # testing options
    frequencies_output_viewer = TRUE

  )
  toset <- !(names(op.frequencies) %in% names(op))
  if(any(toset)) options(op.frequencies[toset])

  invisible()
}
