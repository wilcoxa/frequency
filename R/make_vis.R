make_vis <- function(x) {

  row.names(x) <- 1:nrow(x)
  x <- x[!x[[2]] %in% "Total", ]

  x[["Missing"]] <- FALSE
  ind <- which(x[[1]] %in% "Missing"):nrow(x)
  x[["Missing"]][ind] <- TRUE

  x <- x[, -1] # get rid of precol

  x[["label"]][x[[1]] %in% "<NA>"] <- "<NA>"
  x[["label"]][x[[1]] %in% "<blank>"] <- "<blank>"
  x[["label"]][x[["label"]] %in% ""] <- x[[1]][x[["label"]] %in% ""]

  x[["Freq"]][x[["Freq"]] %in% "..."] <- 0

  fact <- factor(x$label, levels=x$label)

  labels.wrap  <- rev(lapply(strwrap(x$fact, 30, simplify=F),paste,collapse="\n"))

  p <- ggplot() +
    geom_bar(aes_string(x="fact", y = as.numeric("Freq")), data = x, stat = "identity") +
    coord_flip() + scale_x_discrete(limits = rev(levels(fact)),
                                    labels = labels.wrap)
  p

}
