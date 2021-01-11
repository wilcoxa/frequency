Update to address CRAN package check error results, flavors: r-patched-solaris-x86, r-release-macos-x86_64, and r-oldrel-macos-x86_64. Errors from custom testthat specified tests, only on these platforms, status OK on all other flavors. Have tested on these specific platforms (below)

In this version:    
 - Added condition to check for failing unit tests where pandoc installation unavailable  
 - Update unit tests  
 - Update redirected URL in dataset documentation  
 - Added new testing environments
 
## R CMD check results

There were no ERRORs, WARNINGs or NOTEs

Status: OK
R CMD check succeeded

## winbuilder

* DONE
Status: OK

## Reverse dependencies
There are no reverse dependencies.



# Test environments
There were no ERRORs, WARNINGs or NOTES in all of the following test environments
 
### Local
 - local win install, R 4.0.3
 - local ubuntu install, R 4.0.3

### rhub
 - check_for_cran
 https://builder.r-hub.io/status/original/frequency_0.4.1.tar.gz-3b0571d66ea84de8a9afb05b68ffa3c6

 - macos-highsierra-release-cran
 https://builder.r-hub.io/status/original/frequency_0.4.1.tar.gz-d53fafb1780542f58c890cd353746caa

 - solaris-x86-patched
 https://builder.r-hub.io/status/original/frequency_0.4.1.tar.gz-b1a362c381f345a9956285079684db17


### GitHub actions R-CMD-CHECK 
 - {os: macOS-latest,   r: 'release'}
 - {os: windows-latest, r: 'release'}
 - {os: windows-latest, r: '3.6'}
 - {os: ubuntu-16.04,   r: 'devel', rspm: "https://packagemanager.rstudio.com/cran/__linux__/xenial/latest", http-user-agent: "R/4.0.0 (ubuntu-16.04) R (4.0.0 x86_64-pc-linux-gnu x86_64 linux-gnu) on GitHub Actions" }
 - {os: ubuntu-16.04,   r: 'release', rspm: "https://packagemanager.rstudio.com/cran/__linux__/xenial/latest"}
 - {os: ubuntu-16.04,   r: 'oldrel',  rspm: "https://packagemanager.rstudio.com/cran/__linux__/xenial/latest"}
 - {os: ubuntu-16.04,   r: '3.5',     rspm: "https://packagemanager.rstudio.com/cran/__linux__/xenial/latest"}
 - {os: ubuntu-16.04,   r: '3.4',     rspm: "https://packagemanager.rstudio.com/cran/__linux__/xenial/latest"}

https://github.com/wilcoxa/frequency/actions/runs/477480460

### travis-ci
 - ubuntu
   - oldrel 3.6.3 
   - release 4.0.2
   - R Under development (unstable) (2021-01-09 r79815)

 - osx
   - oldrel 3.6.3
   - release 4.0.2

https://travis-ci.org/github/wilcoxa/frequency

### appveyor
 - R version 4.0.3 Patched (2021-01-08 r79815)
 - Platform: x86_64-w64-mingw32/x64 (64-bit)
 - Running under: Windows Server 2012 R2 x64 (build 9600)

 https://ci.appveyor.com/project/wilcoxa/frequency

