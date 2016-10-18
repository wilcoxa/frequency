if(interactive()){
  library(covr)
  library(shiny)

  coverage <- package_coverage(type="all")
  shine(coverage)
}

