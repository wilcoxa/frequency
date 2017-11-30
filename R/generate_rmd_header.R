generate_rmd_header <- function(out_RData, numcols){
paste0(
"
---
title: 'Frequencies'
output:
  html_document:
    smart: false
    toc: true
",
ifelse(numcols > 1, "", "    toc_float: true"),
"
---

<style type=\"text/css\">
.main-container {
  ",
ifelse(numcols > 1, "max-width: 3600px;", "max-width: 940px;"),

"
}
</style>

```{r setup, include=FALSE}
library('knitr')
library('frequencies')
library('DT')
# library('ggplot2')
knitr::opts_chunk$set(echo = TRUE)
",
gsub("\\\\", "/", paste0("load('", out_RData, "')")),
"
```
"
)
}
