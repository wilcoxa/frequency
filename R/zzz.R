.onLoad <- function(libname, pkgname) {
  op <- options()
  op.frequency <- list(

    # Render output using rmarkdown
    frequency_render = TRUE,

    # Automatically open external output
    frequency_open_output = FALSE,

    # Sorting options
    frequency_sort_by = "value",
    frequency_sort_descending = FALSE,

    # Table options
    frequency_trim = TRUE,

    # Formatting options

    # Testing options
    frequency_output_viewer = TRUE,
    frequency_testthat_debug = FALSE

  )
  toset <- !(names(op.frequency) %in% names(op))
  if(any(toset)) options(op.frequency[toset])

  invisible()
}
