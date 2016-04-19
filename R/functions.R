makefreqs <- function(df, var, maxrow, trim){
  cat(".")

  # remove whitespace option
  if (trim %in% TRUE){
    if(is.character(df[[var]])){
      df[[var]] <- gsub("^\\s+|\\s+$", "", df[[var]]) # numeric removing attributes...
    }
  }

  res <- tbl_df(df) %>%
    group_by_(var) %>%
    summarise(Freq = n())

  res[[var]] <- as.vector(res[[var]])
  class(res[[var]])
  res[[var]] <- as.character(res[[var]])

  if(!is.null(attributes(df[[var]])$labels)){
    tmp <-(c(as.vector(attributes(df[[var]])$labels), "",  NA))
    tmp <- list(tmp)
    names(tmp) <- var
    #   class(tmp[[1]]) <- class(res[[var]])
    # res <- left_join(expand.grid(tmp), res)
    res <- full_join(res, expand.grid(tmp, stringsAsFactors = F), by = var)
  } else {
    tmp <-c("",  NA)
    tmp <- list(tmp)
    names(tmp) <- var
    #   class(tmp[[1]]) <- class(res[[var]])
    res <- full_join(res, expand.grid(tmp, stringsAsFactors = F), by = var)
  }

  # reorder and put blank and NA at end
  # res <- arrange(res, res[[var]])
  #new gtools order
  res <- res[mixedorder(res[[var]]), ]

  if (any(grepl("^$", res[[var]]))){
    indx <- which(grepl("^$", res[[var]]))
    if (indx %in% 1){
      if(nrow(res) %in% 2){
        res
      } else {
        res <- rbind(res[2:nrow(res), ], res[1, ])
      }
    } else if (indx %in% nrow(res)){
      res
    } else {
      res <- rbind(res[1:(indx-1), ], res[(indx+1):nrow(res), ], res[indx, ])
    }
  }

  if (any(is.na(res[[var]]))){
    indx <- which(is.na(res[[var]]))
    if (indx %in% 1){
      if(nrow(res) %in% 2){
        res
      } else {
        res <- rbind(res[2:nrow(res), ], res[1, ])
      }

    } else if (indx %in% nrow(res)){
      res
    } else {
      res <- rbind(res[1:(indx-1), ], res[(indx+1):nrow(res), ], res[indx, ])
    }
  }

  res$Freq[is.na(res$Freq)] <- 0
  res[[var]][res[[var]] %in% ""] <- "<blank>"

  res[["label"]] <- sapply(res[[var]], function(y, z = attributes(df[[var]])$labels){
    ret <- ifelse(y %in% z, names(z)[z %in% y], "")
  })

  res <- res[, c(var, "label", "Freq")]

  valid_n <- ifelse(nrow(res) %in% 2, 0, sum(res$Freq[1:(nrow(res)-2)]))
  total_n <- sum(res$Freq)

  valid <- c("Total", "", valid_n)
  total <- c("Total", "", total_n)

  if(nrow(res) %in% 2){
    res <- rbind(valid, res, total)
  } else {
    res <- rbind(res[1:(nrow(res)-2), ], valid, res[(nrow(res)-1):nrow(res), ], total)
  }

  precol <- c("Valid", rep("", nrow(res)-4), "Missing", rep("", 2))
  res <- cbind(precol, res)

  res[["Percent"]] <- dec_dig((as.numeric(res$Freq) / total_n)*100, 1)

  if (valid_n %in% 0){
    res[["Valid Percent"]] <- "0.0"
  } else {
    res[["Valid Percent"]] <- dec_dig((as.numeric(res$Freq) / valid_n)*100, 1)
  }

  res[["Valid Percent"]][(nrow(res)-2):nrow(res)] <- ""

  if(!nrow(res) %in% 4){
    # res[["Cumulative Percent"]] <- c(dec_dig(cumsum(res[1:(nrow(res)-4), "Valid Percent"]), 1), rep("", 4)) # rounding errors
    res[["Cumulative Percent"]] <- c(dec_dig(cumsum(as.numeric((res[1:(nrow(res)-4), "Freq"])) / valid_n *100), 1), rep("", 4))
  } else {
    res[["Cumulative Percent"]] <- rep("", 4)
  }

  res[[var]] <- as.character(res[[var]])
  res[[var]][is.na(res[[var]])] <- "<NA>"

  # remove precol name
  names(res)[[1]] <- ""

  # for long tables
  if(nrow(res)> maxrow){
    blankline <- c("", rep("...", ncol(res)-1))
    res <- rbind(res[1:(trunc(maxrow/2)), ], blankline, res[(nrow(res)-trunc(maxrow/2)):nrow(res), ])
  }

  res
}



# write out
write_freqs <- function(all_freqs, fn = NULL, output_type = "html"){

  if(output_type == "html"){
    outdoc <- bsdoc()
    file_extension <- ".html"
  } else {
    outdoc <- docx()
    file_extension <- ".docx"
  }

  if(is.null(fn)){
    outpth <- tempfile(fileext = file_extension)
    # on.exit(unlink(outpth))
  } else {
    outpth <- file.path(getwd(), paste0(fn, file_extension))
  }
  #------
  # some settings

  blue <- "#007AB2"
  # blue <- "#1b3d93"
  grey <- "#A6A6A6"

  # title_format   <- textProperties(color = green,   font.weight = "bold", font.size = 8.5, font.family = "Tahoma")
  #   txt_green_bold <- textProperties(color = green,   font.weight = "bold", font.size = 8,   font.family = "Arial")
  #   txt_green      <- textProperties(color = green,   font.size = 8, font.family = "Arial")

  txt_italics <- textProperties(font.style = "italic")
  txt_bold <- textProperties(font.weight = "bold")

  content_format <- textProperties(color = "black", font.size = 8, font.family = "Arial")
  # varhead <- textProperties(color = blue, font.size = 14, font.family = "Arial", font.weight = "bold")
  varhead <- textProperties(font.size = 14, font.family = "Arial", font.weight = "bold")

  left_aligned    <- parProperties(text.align = "left",   padding.bottom = 1, padding.top = 1, padding.left = 0, padding.right = 0)
  left_aligned0   <- parProperties(text.align = "left",   padding.bottom = 0, padding.top = 0, padding.left = 0, padding.right = 0)
  center_aligned  <- parProperties(text.align = "center", padding.bottom = 2, padding.top = 4, padding.left = 0, padding.right = 0)
  center_aligned0 <- parProperties(text.align = "center", padding.bottom = 0, padding.top = 0, padding.left = 0, padding.right = 0)
  right_aligned   <- parProperties(text.align = "right",  padding.bottom = 2, padding.top = 4, padding.left = 0, padding.right = 0)
  right_aligned1   <- parProperties(text.align = "right",  padding.bottom = 2, padding.top = 3, padding.left = 0, padding.right = 0)
  right_aligned2   <- parProperties(text.align = "right",  padding.bottom = 2, padding.top = 2, padding.left = 0, padding.right = 0)

  right_aligned0  <- parProperties(text.align = "right",  padding.bottom = 0, padding.top = 0, padding.left = 0, padding.right = 0)

  no_border     <- cellProperties(border.bottom.style = "none", border.left.style = "none",
                                  border.right.style = "none", border.top.style = "none")
  dashed_top    <- cellProperties(border.bottom.style = "none", border.left.style = "none",
                                  border.right.style = "none", border.top.style = "dashed")
  solid_top     <- cellProperties(border.bottom.style = "none", border.left.style = "none",
                                  border.right.style = "none", border.top.style = "solid")
  solid_bottom  <- cellProperties(border.bottom.style = "solid", border.left.style = "none",
                                  border.right.style = "none", border.top.style = "none")
  topbottom     <- cellProperties(border.bottom.style = "solid", border.left.style = "none",
                                  border.right.style = "none", border.top.style = "solid")

  thick_outside <- cellProperties(border.bottom.style = "solid", border.left.style = "solid",
                                  border.right.style = "solid", border.top.style = "solid")

  #-------------------


  # outdoc <<- bsdoc() # for html
  # assign(outdoc, bsdoc(), envir = .GlobalEnv)


  if(output_type == "html"){
    mymenu <- BootstrapMenu(title = 'Frequencies')
    mydd <- DropDownMenu(label = 'Variables')
  }

  flextables <- NULL

  for (i in 1:length(all_freqs)){
    cat(".")

    # html issue
    if(output_type == "html"){
      all_freqs[i][[1]][ , 2] <- gsub("<", "&lt", all_freqs[i][[1]][ , 2])
      all_freqs[i][[1]][ , 2] <- gsub(">", "&gt", all_freqs[i][[1]][ , 2])
      parbreak <- "<br>"
    } else {
      parbreak <- ""
    }

    if(any(!grepl("^$|^...$", all_freqs[[i]]$label))){
      widths <- c(1, 1, 3, 1, 1, 1, 1)
    } else {
      all_freqs[[i]] <- all_freqs[[i]][, -3]
      widths <- c(1, 4, 1, 1, 1, 1)
    }

    if(output_type %in% "doc"){
      widths <- widths * .80
    }

    addParagraph(outdoc, parbreak)

    # add html id so dropdown contents can link to header
    if(output_type == "html"){
      varhead_text <- paste0("<h id='",names(all_freqs[i]), "'>", names(all_freqs[i]), "<h/>")
    } else {
      varhead_text <- names(all_freqs[i])
    }

    varhead <- pot(varhead_text, textProperties(color = "#007AB2", font.size = 14, font.family = "Arial", font.weight = "bold"))
    addParagraph(outdoc, varhead)


    mytable <- FlexTable(data = all_freqs[[i]], header.columns = TRUE)
    #     mytable[, ] <- no_border
    #     mytable[, , to = "header"] <- no_border

    # Set default font sizes
    # mytable[, ] <- content_format

    # set borders
    mytable[, ] <- no_border
    mytable[, , to = "header"] <- topbottom
    mytable[nrow(all_freqs[[i]]), ] <- solid_bottom
    # mytable[nrow(all_freqs[[i]])-3, 2:ncol(all_freqs[[i]])] <- solid_bottom
    mytable[nrow(all_freqs[[i]])-3, ] <- solid_bottom

    # set fonts
    mytable[, 1] <- txt_italics
    mytable[nrow(all_freqs[[i]])-3, ] <- txt_bold
    mytable[nrow(all_freqs[[i]]), ] <- txt_bold



    # set background colours
    # mytable <- setFlexTableBackgroundColors(mytable, i = nrow(all_freqs[[i]]), j = 2, colors = grey)
    # mytable <- setFlexTableBackgroundColors(mytable, i = nrow(all_freqs[[i]]) - 3, j = 2,  colors = blue)

    setFlexTableWidths(mytable, widths)

    flextables[[i]] <- mytable
    names(flextables)[[i]] <- names(all_freqs)[[i]]

    addFlexTable(outdoc, mytable)

    addParagraph(outdoc, parbreak)

    if(output_type == "html"){
      mydd <- addLinkItem(mydd, label = paste0(names(all_freqs[i])), paste0("#", names(all_freqs[i])))
    }
  }

  if(output_type == "html"){
    mymenu <- addLinkItem(mymenu, dd = mydd)
    outdoc <- addBootstrapMenu(outdoc, mymenu)
  }

  # write the doc
  writeDoc(outdoc, file = outpth)

  # Open the document directly from R if allowed
  if(is.null(fn)){
    if (getOption("frequencies_open_null")){
      browseURL(outpth)
    } else {
      print(paste0("temporary file saved:", outpth))
      print("use options(frequencies_open_null = TRUE) to open by default")

    }
  }

  #   mydd = addLinkItem( mydd, label = 'GitHub', 'http://github.com/')
  #   mydd = addLinkItem( mydd, separator.after = TRUE)
  #   mydd = addLinkItem( mydd, label = 'Wikipedia', 'http://www.wikipedia.fr')
  #

  # rm(outdoc, envir = .GlobalEnv)

  invisible(list(all_freqs, flextables))


}


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
  all_freqs <- lapply(names(df), function(x, df1 = as.data.frame(df), maxrow1 = maxrow, trim1 = trim){
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

#-------------------------------------------------------------------------------

round2 <- function(x, n) {
  # get rid of floating point error
  x <- round(x, 10)
  posneg = sign(x)
  z <- abs(x)*10^n
  z <- z + 0.5
  z <- trunc(z)
  z <- z/10^n
  z*posneg
}

#--- keeps decimal places - does not truncate
dec_dig <- function(x, n) {
  x <- round2(x, n)
  formatC(x, format = "f", digits = n)
}




