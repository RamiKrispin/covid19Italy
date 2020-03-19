#------------------------------------------------------------------
# Pulling covid19 data for Italy total, region, and province level
# Source: Presidenza del Consiglio dei Ministri - Dipartimento della Protezione Civile
# Website: http://www.protezionecivile.it/
# Github repo: https://github.com/pcm-dpc
#------------------------------------------------------------------

data_refresh <- function(){

  flag <- FALSE

  # Loading the current version

  `%>%` <- magrittr::`%>%`


  italy_current <- covid19italy::italy_total


  italy_total <- read.csv("https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-andamento-nazionale/dpc-covid19-ita-andamento-nazionale.csv",
                          stringsAsFactors = FALSE) %>%
    stats::setNames(c("date_temp", "state",
                      "hospitalized_with_symptoms",
                      "intensive_care",
                      "total_hospitalized",
                      "home_confinement",
                      "total_currently_positive",
                      "new_currently_positive",
                      "recovered", "death", "total_positive_cases", "total_tests")) %>%
    dplyr::mutate(date = lubridate::ymd(substr(date_temp, 1, 10))) %>%
    dplyr::select(-date_temp, -state) %>%
    dplyr::select(date, dplyr::everything()) %>%
    dplyr::arrange(date)



  # Testing if there is a change in the data

  if(identical(italy_current, italy_total)){
    print("No updates available")
  } else {
    if(ncol(italy_current) != ncol(italy_total)){
      stop("The number of columns in the updated data is not maching the one in the current version")
    }

    if(nrow(italy_current) > nrow(italy_total)){
      stop("The number of rows in the updated data is lower than the one in the current version")
    }

    if(min(italy_current$date) != min(italy_total$date)){
      stop("The start date of the new dataset is not match the one in the current version")
    }



    # If not stop by one of the conditions above than
    # save and commit

    usethis::use_data(italy_total, overwrite = TRUE)
    flag <- TRUE

    write.csv(italy_total, "csv/italy_total.csv", row.names = FALSE)

  }


  # Loading the current version

  italy_pro_current <- covid19italy::italy_province



  df1 <- read.csv("https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-province/dpc-covid19-ita-province.csv", stringsAsFactors = FALSE) %>%
    stats::setNames(c("date_temp", "state", "region_code", "region_name", "province_code",
                      "province_name", "province_abb", "lat", "long", "total_cases")) %>%
    dplyr::mutate(date = lubridate::ymd(substr(date_temp, 1, 10))) %>%
    dplyr::select(-date_temp, -state) %>%
    dplyr::select(date, dplyr::everything()) %>%
    dplyr::arrange(date)

  head(df1)


  df2 <- df1 %>% dplyr::mutate(date = date + lubridate::days(1)) %>%
    dplyr::mutate(total_cases_lag = total_cases) %>%
    dplyr::select(-total_cases)

  head(df1)
  head(df2)

  italy_province <- df1 %>% dplyr::left_join(df2,
                                             by = c("date",
                                                    "region_code", "region_name",
                                                    "province_code", "province_name",
                                                    "province_abb",
                                                    "lat", "long")) %>%
    dplyr::mutate(new_cases = total_cases - total_cases_lag)  %>%
    dplyr::select(-total_cases_lag) %>%
    dplyr::mutate(new_cases = ifelse(is.na(new_cases), total_cases, new_cases))



  # Testing if there is a change in the data

  if(identical(italy_pro_current, italy_province)){
    print("No updates available")
  } else {
    if(ncol(italy_pro_current) != ncol(italy_province)){
      stop("The number of columns in the updated data is not maching the one in the current version")
    }

    if(nrow(italy_current) > nrow(italy_province)){
      stop("The number of rows in the updated data is lower than the one in the current version")
    }

    if(min(italy_pro_current$date) != min(italy_province$date)){
      stop("The start date of the new dataset is not match the one in the current version")
    }



    # If not stop by one of the conditions above than
    # save and commit

    usethis::use_data(italy_province, overwrite = TRUE)
    flag <- TRUE


    write.csv(italy_province, "csv/italy_province.csv", row.names = FALSE)





  }


  # Loading the current version

  `%>%` <- magrittr::`%>%`



  italy_reg_current <- covid19italy::italy_region



  italy_region <- read.csv("https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-regioni/dpc-covid19-ita-regioni.csv",
                           stringsAsFactors = FALSE) %>%
    stats::setNames(c("date_temp", "state", "region_code", "region_name",
                      "lat", "long",
                      "hospitalized_with_symptoms",
                      "intensive_care",
                      "total_hospitalized",
                      "home_confinement",
                      "total_currently_positive",
                      "new_currently_positive",
                      "recovered", "death", "total_positive_cases", "total_tests")) %>%
    dplyr::mutate(date = lubridate::ymd(substr(date_temp, 1, 10))) %>%
    dplyr::select(-date_temp, - state) %>%
    dplyr::select(date, dplyr::everything()) %>%
    dplyr::arrange(date)



  # Testing if there is a change in the data

  if(identical(italy_reg_current, italy_region)){
    print("No updates available")
  } else {
    if(ncol(italy_reg_current) != ncol(italy_region)){
      stop("The number of columns in the updated data is not maching the one in the current version")
    }

    if(nrow(italy_current) > nrow(italy_region)){
      stop("The number of rows in the updated data is lower than the one in the current version")
    }

    if(min(italy_reg_current$date) != min(italy_region$date)){
      stop("The start date of the new dataset is not match the one in the current version")
    }



    # If not stop by one of the conditions above than
    # save and commit

    usethis::use_data(italy_region, overwrite = TRUE)
    flag <- TRUE
    write.csv(italy_region, "csv/italy_region.csv", row.names = FALSE)

  }

  if(flag){
  system(command = "R CMD INSTALL --no-multiarch --with-keep.source /Users/ramikrispin/R/packages/covid19italy")

  .rs.restartR()
  }


}



