#' Update the Package Datasets
#' @export
#' @description Checks if new data is available on the package dev version (Github).
#' In case new data is available the function will enable the user the update the datasets
#'
#' @example
#' \dontrun{
#'
#' data_update()
#'
#' }
data_update <- function(){
  flag <- FALSE

  total_current <- covid19italy::italy_total
  region_current <- covid19italy::italy_region
  province_current <- covid19italy::italy_province

  total_git <- read.csv("https://raw.githubusercontent.com/RamiKrispin/covid19Italy/master/csv/italy_total.csv",
                        stringsAsFactors = FALSE)

  region_git <- read.csv("https://raw.githubusercontent.com/RamiKrispin/covid19Italy/master/csv/italy_region.csv",
                         stringsAsFactors = FALSE)

  province_git <- read.csv("https://raw.githubusercontent.com/RamiKrispin/covid19Italy/master/csv/italy_province.csv")


  total_git$date <- as.Date(total_git$date)
  region_git$date <- as.Date(region_git$date)
  province_git$date <- as.Date(province_git$date)


  if(!base::identical(total_git, total_current)){
    if(base::nrow(total_git) > base::nrow(total_current)){
      flag <- TRUE
    }
  }

  if(!base::identical(region_git, region_current)){
    if(base::nrow(region_git) > base::nrow(region_current)){
      flag <- TRUE
    }
  }

  if(!base::identical(province_git, province_current)){
    if(base::nrow(province_git) > base::nrow(province_current)){
      flag <- TRUE
    }
  }

  if(flag){
    q <- base::tolower(base::readline("Updates are available on the covid19italy Dev version, do you want to update? n/Y"))

    if(q == "y" | q == "yes"){
      devtools::install_github("RamiKrispin/covid19Italy")
      .rs.restartR()
    }
  } else {
    base::message("No updates are available")
  }


}




