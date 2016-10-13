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
#' tmp <- c(1:3)
#' freq(tmp)
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

  # coerce to dataframe
  if(!"data.frame" %in% class(df)){
    try(df <- as.data.frame(df))
  }

  # conversion of value label attributes for foreign
  df[] <- lapply(df, function(x){
    if (is.null(attributes(x)$labels) & !is.null(attributes(x)$value.labels)){
      attributes(x)$labels <- attributes(x)$value.labels
    }
    x
  })

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
