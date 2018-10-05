create_markdown <- function(all_freqs, all_charts, numcols, file){

  # prepare temporary copy of data for markdown
  out_RData <- tempfile(fileext = ".RData")
  save(all_freqs, all_charts, file = out_RData)

  out_Rmd <- tempfile(fileext = ".Rmd")

  rmd_header <- generate_rmd_header(out_RData, numcols)
  write(rmd_header, file = out_Rmd)

  rmd_body <- ""

  for (i in seq_along(all_freqs)){
    rmd_chunk <- generate_rmd_chunk(all_freqs, all_charts, i)
    rmd_body <- c(rmd_body, rmd_chunk)
  }

  write(rmd_body, file = out_Rmd, append = T)

  out_html <- ifelse(is.null(file), tempfile(fileext = ".html"), file)

  out <- list(RData_pth = out_RData,
              Rmd_pth = out_Rmd,
              html_pth = out_html)
  out
}
