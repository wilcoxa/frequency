generate_rmd_chunk <- function(all_freqs, i){
paste0(
"
<div class = \"row\">",


# <div class = \"col-md-6\">
"
<h3 style=\"color:#428bca;font-weight:bold;\">", gsub("'", "", names(all_freqs[i])), "</h3>

```{r ", gsub("'", "", names(all_freqs[i])), ", echo=FALSE}",
"
DT::datatable(all_freqs[[", i, "]],
rownames = FALSE,
# caption = '", gsub("'", "", names(all_freqs[i])), "',
style = 'bootstrap',
 options = list(pageLength = 500,
dom = 't',
list(
className = 'dt-left', targets = 0:", ncol(all_freqs[[i]]), "),
# columnDefs = list(list(className = 'dt-center', targets = 0:4)),
columnDefs = list(list(className = 'dt-head-left', targets = 0:4))
,
ordering = FALSE

)) %>%
formatStyle(1:",  ncol(all_freqs[[i]]), ",
# color = 'red',
`font-size` = '12px'
# ,
# backgroundColor = 'orange',
# fontWeight = 'bold'
)

```
</div>
<br>")

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
