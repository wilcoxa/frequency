[![Travis-CI Build Status](https://travis-ci.org/wilcoxa/frequencies.svg?branch=master)](https://travis-ci.org/wilcoxa/frequencies)
[![codecov](https://codecov.io/gh/wilcoxa/frequencies/branch/master/graph/badge.svg)](https://codecov.io/gh/wilcoxa/frequencies)


# frequencies

The goal of frequencies is to provide quick and easy frequency tables from SPSS 
and other data files in a format that is familar to SPSS users. Frequencies are 
generated with variable labels and value labels where applicable. 

This package uses David Gohel's [ReporteRs](http://davidgohel.github.io/ReporteRs/) package to generate html output to 
easily view frequency results.


## Installation

You can install frequencies from github with:

```R
# install.packages("devtools")
devtools::install_github("wilcoxa/frequencies")
```

## Example

Using foreign:

```R
library(foreign)
dat <- read.spss("mydat.sav")

freq(dat) # entire dataset

freq(dat$foo) # only one variable

freq(dat[3:5]) # specific variables

```
Using haven:
```R
library(haven)
dat <- read_spss("mydat.sav")

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
# produce a list of tables and flextables
x <- freq(dat) 

x$tables # standard output to console

x$flextables[1] # flextable output to Viewer in RStudio

# Suppress Viewer output
options(frequencies_output_flextables = FALSE)

x <- freq(dat)

x[5] # standard print output 


```
Save output:
```R
freq(dat, file = "myfile", type = "html") 


```

