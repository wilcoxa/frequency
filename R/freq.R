#' Freq
#'
#' This function generates frequency tables
#'
#' @param x Input data. Can be a dataframe, list or vector.
#' @param file File name. Optional file name to save the output.
#' @param weight Weight variable name. (Note: this is a placeholder and not currently implemented)
#' @param maxrow Maximum number of rows to display in each frequency table.
#' @param type Output type. Either html or doc.
#' @param template Word template. Optional doc template to use if producing doc output.
#'
#' @return A frequency table in html or doc format.
#'
#' @examples
#'
#' # Suppress external output for examples
#' options(frequency_render = FALSE)
#'
#' # Create frequency tables for the entire dataset
#' freq(big5)
#'
#' # For specific variable/s
#' freq(big5[5:6])
#' freq(big5$country)
#'
#' # Produce a list of tables
#' out <- freq(big5[8:10])
#' out[1]
#'
#' \dontrun{
#' # To automatically open html output in your browser use the following option:
#' options(frequency_render = TRUE)
#' options(frequency_open_output = TRUE)
#' freq(big5[, c('gender', 'E1')])
#'
#' # To save the output specify the filename and format
#' freq(big5, file = "mydir/myfile.html")
#'
#' # Supports label attributes from the package foreign package
#' library(foreign)
#' dat <- read.spss(myfile)
#' freq(dat)
#' # (Note: foreign may drop attributes when using to.data.frame = TRUE)
#' df <- read.spss(myfile, to.data.frame = TRUE)
#' freq(df)
#'
#' # Also supports label attributes from the haven package
#' library(haven)
#' dat <- read_sav(myfile)
#' freq(dat)
#'
#' # as well as other data with no label attributes
#' dat <- data.frame(id = 1:3, val = letters[1:3])
#' freq(dat)
#'
#' }
#'
#' @export
freq <- function(x, file = NULL, weight = NULL, maxrow = 30, type = "html", template = NULL){

  type <- tolower(type)

  if (type == "docx") type <- "doc"

  if (!type %in% c("html", "doc")){
    stop("output type should be either html or doc")
  }

  if (type %in% "html" & !is.null(template)){
    warning("template can only be used with doc output")
  }

  if (is.na(as.numeric(maxrow))){
    stop("maxrows should be numeric")
  } else {
    maxrow <- as.numeric(maxrow)
  }

  if (maxrow <= 3){
    stop("maximum rows should be more than 3")
  }

  trim <- getOption("frequency_trim")
  if (!trim %in% c(TRUE, FALSE)){
    stop("trim whitespace option should be TRUE or FALSE")
  }

  # coerce vector to dataframe
  if(!is.list(x)){
    x <- as.data.frame(x)
  }

  # conversion of variable label attributes for foreign
  if (!is.null(attributes(x)$variable.labels)){
    for(i in seq_along(x)){
      attr(x[[i]], "label") <- attr(x, "variable.labels")[[i]]
    }
  }

  # conversion of value label attributes for foreign
  x[] <- lapply(x, function(y){
    if (is.null(attributes(y)$labels) & !is.null(attributes(y)$value.labels)){
      attributes(y)$labels <- attributes(y)$value.labels
    }
    y
  })

  # conversion of missing value label attributes for foreign
  if(!is.null(attributes(x)$missings)){
    miss <- attributes(x)$missings

    for(i in seq_along(miss)){
      if (!is.null(miss[[i]]$value)){
        ind <- which(attributes(x[[i]])$labels %in% miss[[i]]$value)
        attr(x[[i]], "is_na")[ind] <- TRUE
      }
    }
  }

  # create a list of frequencies
  message("Building tables")
  all_freqs <- lapply_pb(names(x), function(y, x1 = as.data.frame(x), maxrow1 = maxrow, trim1 = trim){
    makefreqs(x1, y, maxrow1, trim1)
  })

  # variable labels
  varnames <- names(x)
  labels <- sapply(x, function(y){
    if (is.null(attributes(y)[["label"]])){
      c("")
    } else {
      attributes(y)[["label"]]
    }

  })

  # Histogram
  if(getOption("frequency_render") %in% TRUE) {
    all_vis <- lapply(all_freqs, make_vis)
  }

  #   labels <- lapply(labels, function(x){
  #     x[is.null(x)] <- ""
  #     ifelse(x == 'NULL', "", x)
  #   })

  names(all_freqs) <- paste0(varnames, ": ", labels)
  names(all_freqs) <- gsub("^\\s+|\\s+$", "", names(all_freqs))

  if(getOption("frequency_render") %in% FALSE) {
    return(all_freqs)
  }

  # tmp <<- all_freqs
  numcols <- 2



  pths <- create_markdown(all_freqs, all_vis, numcols, file)

  if(is.null(file)){
    out_dir <- NULL
  } else {
    out_dir <- dirname(file)
  }

  rmarkdown::render(input = pths$Rmd_pth,
                    output_file = pths$html_pth,
                    output_format = "html_document",
                    output_dir = out_dir,
                    quiet = TRUE)

  # Open the document directly from R if allowed
  if (getOption("frequency_open_output")){
    browseURL(pths$html_pth)
  } else {
    if(is.null(file)){
      message("Temporary file saved to: ", pths$html_pth)
    } else {
      message("File saved to: ", pths$html_pth)
    }
    message("To open by default use: options(frequency_open_output = TRUE)")
  }

  invisible(all_freqs)
}
