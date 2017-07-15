create_markdown <- function(all_freqs){

  # prepare temporary copy of data for markdawn
  out_RData <- file.path(tempfile(fileext = ".RData"))
  save(all_freqs, file = out_RData)

  out_Rmd <- file.path(tempfile(fileext = ".Rmd"))

  rmd_header <- generate_rmd_header(out_RData)
  write(rmd_header, file = out_Rmd)

  rmd_body <- ""

  for (i in seq_along(all_freqs)){
    rmd_chunk <- generate_rmd_chunk(all_freqs, i)
    rmd_body <- c(rmd_body, rmd_chunk)
  }

  write(rmd_body, file = out_Rmd, append = T)

  out_html <- file.path(tempfile(fileext = ".html"))

  out <- list(RData_pth = out_RData,
              Rmd_pth = out_Rmd,
              html_pth = out_html)
  out
}
