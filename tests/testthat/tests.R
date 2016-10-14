library(haven)
library(foreign)
library(frequencies)
options(frequencies_open_output = FALSE)
options(frequencies_output_flextables = FALSE)

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
  print(freq(haven_df)[[1]][[4]])
  print(freq(foreign_df)[[1]][[4]])
  expect_equal(freq(haven_df), freq(foreign_df))
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
