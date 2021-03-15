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
update_data <- function(){
  flag <- FALSE

  total_current <- covid19italy::italy_total
  region_current <- covid19italy::italy_region
  province_current <- covid19italy::italy_province

  total_git <- as.data.frame(readr::read_csv("https://raw.githubusercontent.com/RamiKrispin/covid19Italy/master/csv/italy_total.csv",
                                             locale = readr::locale(encoding = "ASCII")))


  region_git <- as.data.frame(readr::read_csv("https://raw.githubusercontent.com/RamiKrispin/covid19Italy/master/csv/italy_region.csv",
                              locale = readr::locale(encoding = "ASCII")))


  province_git <- as.data.frame(readr::read_csv("https://raw.githubusercontent.com/RamiKrispin/covid19Italy/master/csv/italy_province.csv",
                                locale = readr::locale(encoding = "ASCII")))

  if(!base::identical(dim(total_git), dim(total_current))){
    if(base::nrow(total_git) > base::nrow(total_current)){
      flag <- TRUE
    }
  }

  if(!base::identical(dim(region_git), dim(region_current))){
    if(base::nrow(region_git) > base::nrow(region_current)){
      flag <- TRUE
    }
  }

  if(!base::identical(dim(province_git), dim(province_current))){
    if(base::nrow(province_git) > base::nrow(province_current)){
      flag <- TRUE
    }
  }

  if(flag){
    q <- base::tolower(base::readline("Updates are available on the covid19italy Dev version, do you want to update? n/Y"))

    if(q == "y" | q == "yes"){

      base::tryCatch(
        expr = {
      devtools::install_github("RamiKrispin/covid19Italy")

          base::message("The data was refresed, please restart your session to have the new data available")
        },
      error = function(e){
        message('Caught an error!')
        print(e)
      },
      warning = function(w){
        message('Caught an warning!')
        print(w)
      }

      )
    }
  } else {
    base::message("No updates are available")
  }


}




