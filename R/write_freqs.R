
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
    if (getOption("frequencies_open_output")){
      browseURL(outpth)
    } else {
      print(paste0("\ntemporary file saved:", outpth))
      print("use options(frequencies_open_output = TRUE) to open by default")

    }
  }

  #   mydd = addLinkItem( mydd, label = 'GitHub', 'http://github.com/')
  #   mydd = addLinkItem( mydd, separator.after = TRUE)
  #   mydd = addLinkItem( mydd, label = 'Wikipedia', 'http://www.wikipedia.fr')
  #

  # rm(outdoc, envir = .GlobalEnv)

  invisible(list(all_freqs, flextables))


}
