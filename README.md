<!-- badges: start -->
[![Travis-CI Build Status](https://travis-ci.org/wilcoxa/frequency.svg?branch=master)](https://travis-ci.org/wilcoxa/frequency)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/wilcoxa/frequency?branch=master&svg=true)](https://ci.appveyor.com/project/wilcoxa/frequency)
[![codecov](https://codecov.io/gh/wilcoxa/frequency/branch/master/graph/badge.svg)](https://codecov.io/gh/wilcoxa/frequency)
[![CRAN status](https://www.r-pkg.org/badges/version/frequency)](https://CRAN.R-project.org/package=frequency)
[![R-CMD-check](https://github.com/wilcoxa/frequency/workflows/R-CMD-check/badge.svg)](https://github.com/wilcoxa/frequency/actions)
<!-- badges: end -->

# frequency

The goal of frequency is to provide quick and easy frequency tables from SPSS, SAS 
and other data files in a format that is familiar to SPSS and SAS users. Frequencies are 
generated with variable labels and value labels where applicable. 

[**Example**](https://rawgit.com/wilcoxa/frequency/master/example/example.html) 

## Features
* Easily review an entire dataset with one line of code
* Includes categories included in the label attributes, even if 0 cases exist in the dataset
* Checks for NA and blank cases to review any missing data
* User missing variables can be reported in missing category
* Allows labels for both string and numeric classes
* Suppresses printing of very long tables - defaults to top and bottom cases (can be changed with the "maxrow" option) 
* Supports label conventions from both foreign and haven packages

## Installation

You can install frequency from GitHub with:

```R
# install.packages("devtools")
devtools::install_github("wilcoxa/frequency")
```

## Example

Using foreign:

```R
library(frequency)
library(foreign)
dat <- read.spss("mydat.sav")

freq(dat) # entire dataset

freq(dat$foo) # only one variable

freq(dat[3:5]) # specific variables

```
Using haven:
```R
library(frequency)
library(haven)
dat <- read_sav("mydat.sav", user_na = TRUE)

freq(dat)

freq(dat$foo)

freq(dat[3:5])

```

To automatically open html output:
```R
options(frequency_open_output = TRUE)
freq(dat)

```

Alternately check interactively at the console:
```R
# produce a list of tables
x <- freq(dat) 
x[1]

```
Save output:
```R
freq(dat, file = "myfile.html")

```
