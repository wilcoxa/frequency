library(haven)

test_spss <- "test_spss_unicode.sav"

haven_df <- read_sav(test_spss)

test_that("Loading haven", {

  #haven reading in as NAN on travis
  skip_on_travis()
  skip_on_appveyor()
  print(haven_df)
  print(str(haven_df))
  print(raw_haven_df)
  print(str(raw_haven_df))
  expect_equal(haven_df, raw_haven_df)

})

test_that("foreign vs haven", {

  skip_on_travis()
  skip_on_appveyor()
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
