round2 <- function(x, n) {
  # get rid of floating point error
  x <- round(x, 10)
  posneg = sign(x)
  z <- abs(x)*10^n
  z <- z + 0.5
  z <- trunc(z)
  z <- z/10^n
  z*posneg
}

#--- keeps decimal places - does not truncate
dec_dig <- function(x, n) {
  x <- round2(x, n)
  formatC(x, format = "f", digits = n)
}




