.onLoad <- function(libname, pkgname) {
  op <- options()
  op.frequencies <- list(
    frequencies_open_output = FALSE,
    frequencies_sort_by = "value",
    frequencies_sort_descending = FALSE,

    # formatting options
    frequencies_content_format = textProperties(color = "black", font.size = 10, font.family = "Arial"),
    frequencies_varhead = textProperties(color = "#007AB2", font.size = 14, font.family = "Arial", font.weight = "bold")
  )
  toset <- !(names(op.frequencies) %in% names(op))
  if(any(toset)) options(op.frequencies[toset])

  invisible()
}
