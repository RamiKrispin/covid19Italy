# Pulling raw data
update_italy_total <- function(){
`%>%` <- magrittr::`%>%`

italy_total <- read.csv("https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-andamento-nazionale/dpc-covid19-ita-andamento-nazionale.csv",
                        stringsAsFactors = FALSE) %>%
  stats::setNames(c("date_temp", "state",
                    "hospitalized_with_symptoms",
                    "intensive_care",
                    "total_hospitalized",
                    "home_confinement",
                    "cumulative_positive_cases",
                    "daily_positive_cases",
                    "daily_cases",
                    "recovered", "death", "cumulative_cases",
                    "total_tests", "total_people_tested",
                    "notes_it", "notes_en")) %>%
  dplyr::mutate(date = lubridate::ymd(substr(date_temp, 1, 10))) %>%
  dplyr::select(-date_temp, -state, -notes_it, -notes_en, -daily_cases) %>%
  dplyr::select(date, dplyr::everything()) %>%
  dplyr::arrange(date)


if(ncol(italy_total) != 12){
  stop("The number of columns is invalid")
} else if(nrow(italy_total)< 48){
  stop("The number of raws does not match the minimum number of rows")
} else if(min(italy_total$date) != as.Date("2020-02-24")){
  stop("The starting date is invalid")
}

italy_total_csv <- read.csv("https://raw.githubusercontent.com/Covid19R/covid19italy/master/csv/italy_total.csv", stringsAsFactors = FALSE) %>%
  dplyr::mutate(date = as.Date(date))

if(ncol(italy_total_csv) != 12){
  stop("The number of columns is invalid")
} else if(nrow(italy_total_csv)< 48){
  stop("The number of raws does not match the minimum number of rows")
} else if(min(italy_total_csv$date) != as.Date("2020-02-24")){
  stop("The starting date is invalid")
}


if(nrow(italy_total) > nrow(italy_total_csv)){
  print("Updates available")
  usethis::use_data(italy_total, overwrite = TRUE)
  write.csv(italy_total, "csv/italy_total.csv", row.names = FALSE)
  print("The region dataset was updated")
} else {
  print("Updates are not available")
}

return(print("Done..."))

}


update_italy_total()


