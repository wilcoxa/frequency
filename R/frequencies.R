#'frequencies: A package to generate frequencies
#'
#' The frequencies package comprises functions to generate SPSS like frequencies in R.
#'
#' @section Frequency functions:
#'
#' \code{\link{freq}}
#'
#'
#' @docType package
#' @name frequencies
#' @import dplyr
#' @import ReporteRs
#' @import gtools
NULL


.onLoad <- function(libname, pkgname) {
  op <- options()
  op.frequencies <- list(
    frequencies_open_null = FALSE
    # frequencies.path = "~/R-dev",
    # frequencies.install.args = "",
    # frequencies.name = "Your name goes here",
    # frequencies.desc.author = '"First Last <first.last@example.com> [aut, cre]"',
    # frequencies.desc.license = "What license is it under?",
    # frequencies.desc.suggests = NULL,
    # frequencies.desc = list()
  )
  toset <- !(names(op.frequencies) %in% names(op))
  if(any(toset)) options(op.frequencies[toset])

  invisible()
}
