## Resubmission
This is a resubmission. In this version I have:

* removed the redundant " The frequency package comprises 
functions to".

* removed \dontrun{} for examples in freq() for users to run and for checking. Examples that
would generate external .html output are still wrapped in \dontrun{}


## Test environments
* local ubuntu install, R 3.3.3
* local win install, R 3.5.1

* ubuntu 14.04 (on travis-ci), R 3.5.1
* windows (appveyor) 
R version 3.5.1 Patched (2018-10-03 r75399)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows Server 2012 R2 x64 (build 9600) 
Build Success

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.

* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Alistair Wilcox <frequency@alistairwilcox.com>'
New submission

## rhub::check_for_cran()
checking CRAN incoming feasibility
   Maintainer: 'Alistair Wilcox <frequency@alistairwilcox.com>'
   
   New submission
   

## devtools::check()
R CMD check results
0 errors | 0 warnings | 0 notes


## Reverse dependencies

This is a new release, so there are no reverse dependencies.

