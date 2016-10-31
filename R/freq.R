#' Frequencies
#'
#' This function generates frequencies
#'
#' @param df Input dataframe.
#' @param fn File name. Optional file name if wanting to save the output.
#' @param maxrow Maximum number of rows to display in each frequency table.
#' @param trim Trim whitespace of character vectors.
#' @param type Output type. Either html or doc.
#' @param template Word template. Optional doc template to use if producing doc output.
#'
#' @return A frequency table in html or doc format.
#'
#' @examples
#'
#' \dontrun{
#' # Create frequency tables for the entire dataset
#' freq(big5)
#'
#' # For specific variable/s
#' freq(big5$race)
#' freq(big5[4:6])
#'
#' # To automatically open html output in your browser use the following option:
#' options(frequencies_open_output = TRUE)
#' freq(big5[, c('gender', 'E1')])
#'
#' # To save the output specify the filename and format
#' freq(big5, fn = "mydir/myfile.html")
#'
#' # Produce a list of tables and flextables
#' out <- freq(big5)
#' out$tables[1] # standard output to console
#' out$flextables[4] # flextable output to Viewer in RStudio
#'
#' #Suppress Viewer output
#' options(frequencies_output_flextables = FALSE)
#' x <- freq(big5)
#' x[5] # standard print output
#'
#' }
#'
#' @export
freq <- function(df, fn = NULL, maxrow = 30, trim = TRUE, type = "html", template = NULL){

  type <- tolower(type)

  if(!type %in% c("html", "doc")){
    stop("output type should be either html or doc")
  }

  if(type %in% "html" & !is.null(template)){
    warning("template can only be used with doc output")
  }

  if(!is.numeric(maxrow)){
    stop("maxrows should be numeric")
  }

  if(maxrow <= 3){
    stop("maximum rows should be more than 3")
  }

  # coerce vector to dataframe
  if(!is.list(df)){
    df <- as.data.frame(df)
  }

  # conversion of variable label attributes for foreign
  if (!is.null(attributes(df)$variable.labels)){
    for(i in seq_along(df)){
      attr(df[[i]], "label") <- attr(df, "variable.labels")[[i]]
    }
  }

  # conversion of value label attributes for foreign
  df[] <- lapply(df, function(x){
    if (is.null(attributes(x)$labels) & !is.null(attributes(x)$value.labels)){
      attributes(x)$labels <- attributes(x)$value.labels
    }
    x
  })

  # conversion of missing value label attributes for foreign
  if(!is.null(attributes(df)$missings)){
    miss <- attributes(df)$missings

    for(i in seq_along(miss)){
      if (!is.null(miss[[i]]$value)){
        ind <- which(attributes(df[[i]])$labels %in% miss[[i]]$value)
        attr(df[[i]], "is_na")[ind] <- TRUE
      }
    }
  }

  # create a list of frequencies
  message("Building tables")
  all_freqs <- lapply_pb(names(df), function(x, df1 = as.data.frame(df), maxrow1 = maxrow, trim1 = trim){
    makefreqs(df1, x, maxrow1, trim1)
  })

  # variable labels
  varnames <- names(df)
  labels <- sapply(df, function(x){
    if (is.null(attributes(x)[["label"]])){
      c("")
    } else {
      attributes(x)[["label"]]
    }

  })

  #   labels <- lapply(labels, function(x){
  #     x[is.null(x)] <- ""
  #     ifelse(x == 'NULL', "", x)
  #   })

  names(all_freqs) <- paste0(varnames, ": ", labels)
  names(all_freqs) <- gsub("^\\s+|\\s+$", "", names(all_freqs))

  # write out
  write_freqs(all_freqs, fn, type)


}
