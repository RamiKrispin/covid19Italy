# installing package imports packages
pkg_list <- c("textshaping",
              "ragg",
              "pkgdown",
              "dplyr",
              "remotes",
              "devtools",
              "here",
              "lubridate",
              "magrittr",
              "rmarkdown",
              "tidyr",
              "testthat",
              "shiny",
              "plotly",
              "ggplot2",
              "rcmdcheck",
              "flexdashboard",
              "readr",
              "knitr",
              "usethis"
              )

install.packages(pkgs = pkg_list, repos = "https://cran.rstudio.com/")

for(i in pkg_list){

  if(!i %in% rownames(installed.packages())){
    stop(paste("Package", i, "is not available"))
  }
}

