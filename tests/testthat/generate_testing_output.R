library(haven)
library(foreign)
options(frequencies_open_output = FALSE)
options(frequencies_output_flextables = FALSE)

Sys.setlocale("LC_COLLATE", "C") # R CMD check uses this default
# Sys.setlocale("LC_COLLATE", "English_United States.1252")

write0 <- function(...){
  write(paste(...), file = fn, append = TRUE)
}

test_spss <- "tests/testthat/test_spss_unicode.sav"

raw_haven_df <- read_sav(test_spss)
raw_foreign_df <- suppressWarnings(read.spss(test_spss, to.data.frame = TRUE, reencode='utf-8'))
raw_foreign_list <- suppressWarnings(read.spss(test_spss, to.data.frame = FALSE, reencode='utf-8'))

save(raw_haven_df, raw_foreign_df, raw_foreign_list, file = "tests/testthat/ImportData.RData")

#-------------------------------------------------------------------------------

# generate output

fn <- "tests/testthat/output.R"

write(paste0("# Output file created on: ", Sys.Date()), file = fn)

write0("load('ImportData.RData')")

#-------------------------------------------------------------------------------

# Frequency tables
dat <- raw_haven_df

raw_all <- freq(dat)
raw_id <- freq(dat$id)
raw_numeric <- freq(dat$test_numeric)
raw_numeric_labelled <- freq(dat$test_numeric_labelled)
raw_character <- freq(dat$test_character)
raw_character_labelled <- freq(dat$test_character_labelled)

save(raw_all, raw_id, raw_numeric, raw_numeric_labelled, raw_character, raw_character_labelled,
     file = "tests/testthat/FreqData.RData")

write0("load('FreqData.RData')")




