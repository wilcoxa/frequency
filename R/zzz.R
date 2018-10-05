.onLoad <- function(libname, pkgname) {
  op <- options()
  op.freq <- list(
    freq_open_output = FALSE,
    freq_sort_by = "value",
    freq_sort_descending = FALSE,


    freq_trim = TRUE,

    # formatting options

    # testing options
    freq_output_viewer = TRUE

  )
  toset <- !(names(op.freq) %in% names(op))
  if(any(toset)) options(op.freq[toset])

  invisible()
}
