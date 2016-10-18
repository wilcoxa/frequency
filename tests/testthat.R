Sys.setenv("R_TESTS" = "")
# Sys.setenv(LC_COLLATE = "C", LC_TIME = "C", LANGUAGE = "en")
Sys.setenv(LC_COLLATE = "C")

print(Sys.getlocale(category = "LC_ALL"))
Sys.setlocale("LC_COLLATE", "C") # R CMD check uses this default
# Sys.setlocale("LC_COLLATE", "en_US.UTF-8")
# Sys.setlocale("LC_COLLATE", "English_United States.1252")
print(Sys.getlocale(category = "LC_ALL"))

library(testthat)
library(frequencies)
test_check("frequencies")
