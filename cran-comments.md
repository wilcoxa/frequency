## r-devel update
Fixed issue raising error in r-devel build. Error originated 
in unit tests - loading of SPSS file using foreign without 
stringsAsFactors argument. No changes needed in core package.

## Test environments
* local win install, r-devel (2020-04-03) r78147
* local win install, R 3.6.3
* local ubuntu install, R 3.3.3

* ubuntu  (on travis-ci)
  * oldrel 3.5.3 (2017-01-27)
  * release 3.6.2 (2017-01-27)
  * devel R Under development (unstable) (2020-03-13 r77948)

* windows (appveyor) R version 3.6.3 Patched (2020-03-11 r78063)

## R CMD check results

0 errors | 0 warnings | 0 notes

Status: OK
 [40s]

R CMD check succeeded

## rhub::check_for_cran()
No errors
   
## devtools::check()
0 errors | 0 warnings | 0 notes

## Reverse dependencies
There are no reverse dependencies.
