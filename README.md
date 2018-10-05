[![Travis-CI Build Status](https://travis-ci.org/wilcoxa/frequencies.svg?branch=master)](https://travis-ci.org/wilcoxa/frequencies)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/wilcoxa/frequencies?branch=master&svg=true)](https://ci.appveyor.com/project/wilcoxa/frequencies)
[![codecov](https://codecov.io/gh/wilcoxa/frequencies/branch/master/graph/badge.svg)](https://codecov.io/gh/wilcoxa/frequencies)


# frequencies

The goal of frequencies is to provide quick and easy frequency tables from SPSS, SAS 
and other data files in a format that is familar to SPSS and SAS users. Frequencies are 
generated with variable labels and value labels where applicable. 

[**Example**](http://htmlpreview.github.io/?https://github.com/wilcoxa/frequencies/blob/master/example/example.html) 

Features
* Easily review an entire dataset with one line
* Includes categories included in the label attributes, even if 0 cases exist in the dataset
* Checks for NA and blank cases to review any missing data
* User missing variables can be reported in missing category
* Allows labels for both string and numeric classes
* Suppresses printing of very long tables - defaults to top and bottom cases (can be changed with the maxrow option) 
* Supports label conventions from both foreign and haven packages

## Installation

You can install frequencies from github with:

```R
# install.packages("devtools")
devtools::install_github("wilcoxa/frequencies")
```

## Example

Using foreign:

```R
library(frequencies)
library(foreign)
dat <- read.spss("mydat.sav")

freq(dat) # entire dataset

freq(dat$foo) # only one variable

freq(dat[3:5]) # specific variables

```
Using haven:
```R
library(frequencies)
library(haven)
dat <- read_sav("mydat.sav", user_na = TRUE)

freq(dat)

freq(dat$foo)

freq(dat[3:5])

```

To automatically open html output:
```R
options(frequencies_open_output = TRUE)
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
