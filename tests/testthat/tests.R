library(foreign)
options(freq_open_output = FALSE)
options(freq_output_viewer = FALSE)

print(Sys.getlocale(category = "LC_ALL"))
Sys.setlocale("LC_COLLATE", "C") # R CMD check uses this default
# Sys.setlocale("LC_COLLATE", "en_US.UTF-8")
# Sys.setlocale("LC_COLLATE", "English_United States.1252")
print(Sys.getlocale(category = "LC_ALL"))

test_spss <- "test_spss_unicode.sav"

foreign_df <- suppressWarnings(read.spss(test_spss, to.data.frame = TRUE, reencode='utf-8', use.value.labels = F))
foreign_list <- suppressWarnings(read.spss(test_spss, to.data.frame = FALSE, reencode='utf-8', use.value.labels = F))

dat <- foreign_list

source("output.R")

#-------------------------------------------------------------------------------
context("Data attributes assumptions")

test_that("Loading foreign", {

  print(foreign_df)
  print(str(foreign_df))
  print(raw_foreign_df)
  print(str(raw_foreign_df))
  expect_equal(foreign_df, raw_foreign_df)
  expect_equal(foreign_list, raw_foreign_list)
})

#-------------------------------------------------------------------------------
context("Frequency output")

test_that("All", {
  expect_equal(raw_all, freq(dat))
})
test_that("Individual tables", {
  expect_equal(raw_id, freq(dat$id))

  print(raw_numeric)
  print(freq(dat$test_numeric))
  print(raw_numeric)
  print(freq(dat$test_numeric))
  # expect_equal(raw_numeric, freq(dat$test_numeric))
  x <- freq(dat$test_numeric); y <- freq(dat$test_numeric)
  names(x) <- NULL; names(y) <- NULL
  expect_equal(x, y)

  print(raw_numeric_labelled)
  print(freq(dat$test_numeric_labelled))
  print(raw_numeric_labelled)
  print(freq(dat$test_numeric_labelled))
  # expect_equal(raw_numeric_labelled, freq(dat$test_numeric_labelled))
  x <- freq(dat$test_numeric_labelled); y <- freq(dat$test_numeric_labelled)
  names(x) <- NULL; names(y) <- NULL
  expect_equal(x, y)

  print(raw_character)
  print(freq(dat$test_character))
  print(raw_character)
  print(freq(dat$test_character))
  expect_equal(raw_character, freq(dat$test_character))

  print(raw_character)
  print(freq(dat$test_character_labelled))
  print(raw_character)
  print(freq(dat$test_character_labelled))
  expect_equal(raw_character_labelled, freq(dat$test_character_labelled))
})

#-------------------------------------------------------------------------------

# really the output should be the same regardless
context("Package comparison")

test_that("foreign_df vs foreign_list", {
  # expect_equal(foreign_df, foreign_list)

  print("Foreign: df vs list")
  # handles missing labels differently
  print(freq(foreign_df))
  print(freq(foreign_list))

  expect_equal(freq(foreign_df[-3]), freq(foreign_list[-3]))
})



#-------------------------------------------------------------------------------

context("Input assumptions")

test_that("Arguments - x = ", {
  # dataframe
  df <- data.frame("a" = LETTERS[1:10], "b" = 1:10)
  # no error
  expect_error(freq(df), NA)

  # list
  dat <- list("a" = LETTERS[1:10], "b" = 1:10)
  # no error
  expect_error(freq(dat), NA)

  # vector
  vs <- LETTERS[1:10]
  vn <- 1:10
  # no error
  expect_error(freq(vs), NA)
  expect_error(freq(vn), NA)

})

test_that("Arguments - file = ", {
  skip_on_cran()

  dat <- data.frame("a" = LETTERS[1:10], "b" = 1:10)
  # expect_error(freq(dat, file = "")) # should be error?
  # expect_error(freq(dat, file = NA)) # should be error?
  # expect_error(freq(dat, file = ".html")) # should be error?
  # expect_error(freq(dat, file = ".docx", type = "doc")) # should be error?

  # no errors
  expect_error(freq(dat, file = "asdf"), NA)
  expect_error(freq(dat, file = "1234"), NA)
  expect_error(freq(dat, file = "aaa.html"), NA)
  expect_error(freq(dat, file = "bbb.docx", type = "doc"), NA)

  file.remove("asdf.html")
  file.remove("1234.html")
  file.remove("aaa.html")
  file.remove("bbb.docx")
  unlink("css", recursive=TRUE)
  unlink("fonts", recursive=TRUE)
  unlink("js", recursive=TRUE)


})

test_that("Arguments - maxrow = ", {
  dat <- data.frame("a" = LETTERS[1:10], "b" = 1:10)
  expect_error(freq(dat, maxrow = 1))
  expect_error(freq(dat, maxrow = -11))
  expect_error(suppress_warnings(freq(dat, maxrow = "a")))

  # no errors
  expect_error(freq(dat, maxrow = "5"), NA)
  expect_error(freq(dat, maxrow = "10"), NA)
  expect_error(freq(dat, maxrow = 5), NA)
  expect_error(freq(dat, maxrow = 10), NA)
  expect_error(freq(dat, maxrow = 100), NA)

})

test_that("Arguments - type = ", {
  dat <- data.frame("a" = LETTERS[1:10], "b" = 1:10)
  expect_error(freq(dat, type = "asdf"))
  expect_error(freq(dat, type = ""))
  expect_error(freq(dat, type = NA))

  # no errors
  expect_error(freq(dat, type = "doc"), NA)
  expect_error(freq(dat, type = "docx"), NA)
  expect_error(freq(dat, type = "html"), NA)
  expect_error(freq(dat, type = "DOC"), NA)
  expect_error(freq(dat, type = "DOCX"), NA)
  expect_error(freq(dat, type = "HTML"), NA)

})

#-------------------------------------------------------------------------------
#----------------------------------------------------------------------------end
#-------------------------------------------------------------------------------
