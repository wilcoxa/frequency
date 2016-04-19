
context("Make freqs")

test_that("invalid maxrow specification", {
  dat <- data.frame("a" = LETTERS[1:10], "b" = 1:10)
  expect_error(freq(dat, maxrow = 1))
  expect_error(freq(dat, maxrow = -11))
  expect_error(freq(dat, maxrow = "a"))
  # expect_warning(freq(dat, maxrow = 30:40))
})

# test_that("invalid maxrow specification", {
#
# })

# test_that("invalid output type", {
#
# })

# skip_on_cran()
# test_that("asdfasdf", {
#
#   df <-
#   make_freqs
#   expect_equal()
# })

#coercion of vector to a data frame
# trimming of variables
# dealing with NA's


