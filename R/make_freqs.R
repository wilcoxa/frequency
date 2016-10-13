makefreqs <- function(df, var, maxrow, trim){
  cat(".")

  # remove whitespace option
  if (trim %in% TRUE){
    if(is.character(df[[var]])){
      df[[var]] <- gsub("^\\s+|\\s+$", "", df[[var]]) # numeric removing attributes...
    }
  }

  # Build frequency table
  res <- tbl_df(df) %>%
    group_by_(var) %>%
    summarise(Freq = n())

  res[[var]] <- as.vector(res[[var]])
  class(res[[var]])
  res[[var]] <- as.character(res[[var]]) # Need to sort out scietific notation

  # Get all labels even if no cases
  if(!is.null(attributes(df[[var]])$labels)){

    tmp <- c(as.vector(attributes(df[[var]])$labels), "",  NA)

    # flag user missing labels
    if(!is.null(attributes(df[[var]])$is_na)){
      isna <- c(as.vector(attributes(df[[var]])$is_na), TRUE, TRUE)
    } else {
      isna <- c(rep(FALSE, length(as.vector(attributes(df[[var]])$labels))), TRUE, TRUE)
    }
  } else {
    tmp <- c("",  NA)
    isna <- c(TRUE, TRUE)
  }

  tmp <- data.frame(tmp, isna, stringsAsFactors = F)
  names(tmp) <- c(var, "missing")
  res <- full_join(res, tmp, by = var)


  sort_by <- switch(getOption("frequencies_sort_by"),
                    "value" = var,
                    "label" = "label",
                    "count" = "freq")

  # reorder and put blank and NA at end
  res[["missing"]][is.na(res[["missing"]])] <- FALSE

  res_v <- res[res[["missing"]] %in% FALSE,]
  res_v <- res_v[mixedorder(res_v[[sort_by]], decreasing = getOption("frequencies_sort_descending")),]

  res_m <- res[res[["missing"]] %in% TRUE,]
  res_m <- res_m[mixedorder(res_m[[sort_by]], decreasing = getOption("frequencies_sort_descending")),]
  mis <- which(!res_m[[var]] %in% "" & !is.na(res_m[[var]]))
  bl <- which(res_m[[var]] %in% "")
  na <- which(is.na(res_m[[var]]))
  res_m <- res_m[c(mis, bl, na), ]

  res <- rbind(res_v, res_m)


  # clean up na counts
  res$Freq[is.na(res$Freq)] <- 0
  res[[var]][res[[var]] %in% ""] <- "<blank>"

  res[["label"]] <- sapply(res[[var]], function(y, z = attributes(df[[var]])$labels){
    ret <- ifelse(y %in% z, names(z)[z %in% y], "")
  })

  res <- res[, c(var, "label", "Freq", "missing")]

  valid_n <- sum(res$Freq[res$missing %in% FALSE])
  total_n <- sum(res$Freq)

  valid <- c("Total", "", valid_n, "")
  total <- c("Total", "", total_n, "")

  if(nrow(res) %in% 2){
    res <- rbind(valid, res, total)
  } else {
    res <- rbind(res[res$missing %in% FALSE, ], valid, res[res$missing %in% TRUE, ], total)
  }

  precol <- c("Valid", rep("", nrow(res[res$missing %in% FALSE,])), "Missing", rep("", nrow(res[res$missing %in% TRUE,])))
  res <- cbind(precol, res, stringsAsFactors = FALSE)

  res[["Percent"]] <- dec_dig((as.numeric(res$Freq) / total_n)*100, 1)

  # Update valid Percent
  if (valid_n %in% 0){
    res[["Valid Percent"]] <- "0.0"
  } else {
    res[["Valid Percent"]] <- dec_dig((as.numeric(res$Freq) / valid_n)*100, 1)
  }

  res[["Valid Percent"]][res[["missing"]] %in% TRUE] <- ""
  res[["Valid Percent"]][nrow(res)] <- ""

  # Update Cumulative Percent
  if(!nrow(res) %in% 4){
    res[["Cumulative Percent"]] <- c(dec_dig(cumsum(as.numeric(res[res$missing %in% FALSE, "Freq"]) / valid_n *100), 1),
                                     rep("", nrow(res[res$missing %in% TRUE,]) + 2))
  } else {
    res[["Cumulative Percent"]] <- rep("", 4)
  }

  res[[var]] <- as.character(res[[var]])
  res[[var]][is.na(res[[var]])] <- "<NA>"

  # remove precol name
  names(res)[[1]] <- ""
  # remove missing variable
  res$missing <- NULL

  # for long tables
  if(nrow(res)> maxrow){
    blankline <- c("", rep("...", ncol(res)-1))
    res <- rbind(res[1:(trunc(maxrow/2)), ], blankline, res[(nrow(res)-trunc(maxrow/2)):nrow(res), ])
  }

  res
}
