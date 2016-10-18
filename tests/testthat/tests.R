library(haven)
library(foreign)
library(frequencies)
options(frequencies_open_output = FALSE)
options(frequencies_output_flextables = FALSE)

print(Sys.getlocale(category = "LC_ALL"))

test_spss <- "test_spss.sav"

haven_df <- read_sav(test_spss)
foreign_df <- suppressWarnings(read.spss(test_spss, to.data.frame = TRUE))
foreign_list <- suppressWarnings(read.spss(test_spss, to.data.frame = FALSE))

dat <- haven_df

source("output.R")

#-------------------------------------------------------------------------------
context("Data attributes assumptions")

test_that("Loading foreign", {
  expect_equal(foreign_df, raw_foreign_df)
  expect_equal(foreign_list, raw_foreign_list)
})
test_that("Loading haven", {
  expect_equal(haven_df, raw_haven_df)
})

#-------------------------------------------------------------------------------
context("Frequency output")

test_that("All", {
  expect_equal(raw_all, freq(dat))
})
test_that("Individual tables", {
  expect_equal(raw_id, freq(dat$id))
  expect_equal(raw_numeric, freq(dat$test_numeric))
  expect_equal(raw_numeric_labelled, freq(dat$test_numeric_labelled))
  expect_equal(raw_character, freq(dat$test_character))
  expect_equal(raw_character_labelled, freq(dat$test_character_labelled))
})

#-------------------------------------------------------------------------------

# really the output should be the same regardless
context("Package comparison")
test_that("foreign vs haven", {

  expect_equal(freq(haven_df), freq(foreign_list))
  expect_equal(freq(haven_df$id), freq(foreign_list$id))

  # expect_equal(freq(haven_df$test_numeric), ffreq(haven_df$test_numeric)) # variable label dropped on subset
  x <- freq(haven_df$test_numeric); y <- freq(haven_df$test_numeric)
  names(x) <- NULL; names(y) <- NULL
  expect_equal(x, y)
  # expect_equal(freq(haven_df$test_numeric_labelled), freq(foreign_list$test_numeric_labelled)) # as above
  x <- freq(haven_df$test_numeric_labelled); y <- freq(haven_df$test_numeric_labelled)
  names(x) <- NULL; names(y) <- NULL
  expect_equal(x, y)

  expect_equal(freq(haven_df$test_character), freq(foreign_list$test_character))
  expect_equal(freq(haven_df$test_character_labelled), freq(foreign_list$test_character_labelled))
})



context("Input assumptions")

test_that("invalid maxrow specification", {
  dat <- data.frame("a" = LETTERS[1:10], "b" = 1:10)
  expect_error(freq(dat, maxrow = 1))
  expect_error(freq(dat, maxrow = -11))
  expect_error(freq(dat, maxrow = "a"))
  # expect_warning(freq(dat, maxrow = 30:40))
})

#-------------------------------------------------------------------------------
#----------------------------------------------------------------------------end
#-------------------------------------------------------------------------------
