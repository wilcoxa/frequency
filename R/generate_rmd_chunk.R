generate_rmd_chunk <- function(all_freqs, i){
paste0(
"
<div class = \"row\">
",
# <div class = \"col-md-6\">
"
```{r ", gsub("'", "", names(all_freqs[i])), "}",
"
DT::datatable(all_freqs[[", i, "]])

```
</div>
")

# </div>
# ")
}

# c(
# "
# <div class = \"col-md-6\">
#
# ```{r ggpolt}
#
# tmp <- all_freqs[[1]]
# tmp$Freq <- as.numeric(tmp$Freq)
#
# tmp <- tmp[!tmp$race %in% 'Total',]
# row.names(tmp) <- 1:nrow(tmp)
#
#
#
# p <- ggplot() +
# geom_bar(aes(x=label, y = Freq), data = tmp, stat = 'identity') +
# coord_flip()
# p
#
#
# ```
#
# </div>
# </div>
# ")
