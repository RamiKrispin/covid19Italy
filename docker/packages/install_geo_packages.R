# installing package imports packages
pkg_list <- c("rnaturalearth", "mapview", "sf")

install.packages(pkgs = pkg_list, repos = "https://cran.rstudio.com/")

for(i in pkg_list){

  if(!i %in% rownames(installed.packages())){
    stop(paste("Package", i, "is not available"))
  }
}
