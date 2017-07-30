generate_rmd_chunk <- function(all_freqs, all_charts, i){

tab_txt <- paste0(
"
<div class = \"row\">

<div class = \"col-md-6\">

<h3 style=\"color:#428bca;font-weight:bold;\">",
gsub("'", "", names(all_freqs[i])), "</h3>

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
<br>

")


chart_txt <- paste0(
"
<div class = \"col-md-6\">

<br>
```{r echo=FALSE}
all_charts[[", i, "]]
```
</div>
</div>
")

txt <- paste(tab_txt, chart_txt)

}
