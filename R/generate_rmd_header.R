generate_rmd_header <- function(out_RData){
paste0(
"
---
title: 'Frequencies'
output:
  html_document:
    toc: true
    toc_float: true
---

<style type=\"text/css\">
.main-container {
max-width: 940px;
}
</style>

```{r setup, include=FALSE}
library('knitr')
library('frequencies')
library('DT')
library('ggplot2')
knitr::opts_chunk$set(echo = TRUE)
",
paste0("load('", out_RData, "')"),
"
```
"
)
}
