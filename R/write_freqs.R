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
    outpth <- file.path(paste0(fn, file_extension))
  }

  #-------------------
  # outdoc <<- bsdoc() # for html
  # assign(outdoc, bsdoc(), envir = .GlobalEnv)

  if(output_type == "html"){
    mymenu <- BootstrapMenu(title = 'Frequencies')
    mydd <- DropDownMenu(label = 'Variables')
  }

  # formatting defaults
  txt_italics <- textProperties(font.style = "italic")
  txt_bold <- textProperties(font.weight = "bold")

  no_border     <- cellProperties(border.bottom.style = "none", border.left.style = "none",
                                  border.right.style = "none", border.top.style = "none")
  solid_top     <- cellProperties(border.bottom.style = "none", border.left.style = "none",
                                  border.right.style = "none", border.top.style = "solid")
  solid_bottom  <- cellProperties(border.bottom.style = "solid", border.left.style = "none",
                                  border.right.style = "none", border.top.style = "none")
  topbottom     <- cellProperties(border.bottom.style = "solid", border.left.style = "none",
                                  border.right.style = "none", border.top.style = "solid")

  #-----------------------------------------------------------------------------

  flextables <- NULL

  message("Writing tables")
  pb <- txtProgressBar(min = 0, max = length(all_freqs), style = 3)
  for (i in 1:length(all_freqs)){
    setTxtProgressBar(pb, i)

    miss_row <- which(all_freqs[[i]][[1]] %in% "Missing") - 1
    tmp <- all_freqs[[i]]

    # html issue
    if(output_type == "html"){
      tmp[ , 2] <- gsub("<", "&lt", tmp[ , 2])
      tmp[ , 2] <- gsub(">", "&gt", tmp[ , 2])
      parbreak <- "<br>"
    } else {
      parbreak <- ""
    }

    if(any(!grepl("^$|^...$", tmp$label))){
      widths <- c(1, 1, 3, 1, 1, 1, 1)
    } else {
      tmp <- tmp[, -3]
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

    varhead <- pot(varhead_text, format = getOption("frequencies_varhead"))
    addParagraph(outdoc, varhead)

    # create flextable
    mytable <- FlexTable(data = tmp, header.columns = TRUE)

    # Set default formatting sizes
    mytable[, ] <- getOption("frequencies_content_format")

    # set borders
    mytable[, ] <- no_border
    mytable[, , to = "header"] <- topbottom
    mytable[nrow(all_freqs[[i]]), ] <- solid_bottom
    mytable[miss_row, ] <- solid_bottom

    # set fonts
    mytable[, 1] <- txt_italics
    mytable[miss_row, ] <- txt_bold
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
  close(pb)

  if(output_type == "html"){
    mymenu <- addLinkItem(mymenu, dd = mydd)
    outdoc <- addBootstrapMenu(outdoc, mymenu)
  }

  # write the doc
  writeDoc(outdoc, file = outpth)

  # Open the document directly from R if allowed
  if (getOption("frequencies_open_output")){
    browseURL(outpth)
  } else {
    if(is.null(fn)){
      message("Temporary file saved to: ", outpth)
    } else {
      message("File saved to: ", outpth)
    }
    message("To open by default use: options(frequencies_open_output = TRUE)")
  }

  # return tables invisibly
  if(getOption("frequencies_output_flextables")){
    return(invisible(list("tables" = all_freqs, "flextables" = flextables)))
  } else {
    return(invisible(all_freqs))
  }


}
