# Pulling raw data
update_italy_province <- function(branch = "master"){
`%>%` <- magrittr::`%>%`

df1 <- readr::read_csv("https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-province/dpc-covid19-ita-province.csv",
                       col_types = readr::cols(note = readr::col_character(),
                                        codice_nuts_1 = readr::col_character(),
                                        codice_nuts_2 = readr::col_character(),
                                        codice_nuts_3 = readr::col_character()),
                       na = "empty") %>%
  stats::setNames(c("date_temp", "state", "region_code", "region_name", "province_code",
                    "province_name", "province_abb", "lat", "long", "total_cases",
                    "notes", "nuts_code_1", "nuts_code_2", "nuts_code_3")) %>%
  dplyr::mutate(date = lubridate::ymd(substr(date_temp, 1, 10))) %>%
  dplyr::select(-date_temp, -state, - notes) %>%
  dplyr::select(date, dplyr::everything()) %>%
  dplyr::arrange(date)


head(df1)

tail(df1)



df2 <- df1 %>% dplyr::mutate(date = date + lubridate::days(1)) %>%
  dplyr::mutate(total_cases_lag = total_cases) %>%
  dplyr::select(-total_cases, -nuts_code_1, -nuts_code_2, -nuts_code_3)

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
  dplyr::mutate(new_cases = ifelse(is.na(new_cases), total_cases, new_cases)) %>%
  dplyr::mutate(province_spatial = province_name)

italy_province$province_name <-  ifelse(italy_province$province_name == "Forlì-Cesena", "Forli-Cesena", italy_province$province_name)
italy_province$province_spatial <- ifelse(italy_province$province_spatial == "Aosta", "Aoste", italy_province$province_spatial)
italy_province$province_spatial <- ifelse(italy_province$province_spatial == "Bolzano", "Bozen", italy_province$province_spatial)
italy_province$province_spatial <- ifelse(italy_province$province_spatial == "Crotone", "Crotene", italy_province$province_spatial)
italy_province$province_spatial <- ifelse(italy_province$province_spatial == "Massa Carrara", "Massa-Carrara", italy_province$province_spatial)
italy_province$province_spatial <- ifelse(italy_province$province_spatial == "Monza e della Brianza", "Monza e Brianza", italy_province$province_spatial)
italy_province$province_spatial <- ifelse(italy_province$province_spatial == "Oristano", "Oristrano", italy_province$province_spatial)
italy_province$province_spatial <- ifelse(italy_province$province_spatial == "Reggio di Calabria", "Reggio Calabria", italy_province$province_spatial)
italy_province$province_spatial <- ifelse(italy_province$province_spatial == "Reggio nell'Emilia", "Reggio Emilia", italy_province$province_spatial)
italy_province$province_spatial <- ifelse(italy_province$province_spatial == "Torino", "Turin", italy_province$province_spatial)
italy_province$province_spatial <- ifelse(italy_province$province_spatial == "Barletta-Andria-Trani", "Barletta-Andria Trani", italy_province$province_spatial)
italy_province$province_spatial <- ifelse(italy_province$province_spatial == "Forlì-Cesena", "Forli-Cesena", italy_province$province_spatial)


italy_province <- italy_province %>%
  dplyr::select(date, region_name, region_code,
                province_name, province_spatial, province_abb, province_code,
                lat, long, new_cases, total_cases,
                nuts_code_1, nuts_code_2, nuts_code_3)

if(ncol(italy_province) != 14){
  stop("The number of columns is invalid")
} else if(nrow(italy_province) < 55500){
  stop("The number of raws does not match the minimum number of rows")
} else if(min(italy_province$date) != as.Date("2020-02-24")){
  stop("The starting date is invalid")
}




italy_province_csv <- readr::read_csv(sprintf("https://raw.githubusercontent.com/RamiKrispin/covid19italy/%s/csv/italy_province.csv", branch),
                                      col_types = readr::cols(nuts_code_1 = readr::col_character(),
                                                       nuts_code_2 = readr::col_character(),
                                                       nuts_code_3 = readr::col_character()),
                                      na = "empty")

if(ncol(italy_province_csv) != 14){
  stop("The number of columns is invalid")
} else if(nrow(italy_province_csv)< 55500){
  stop("The number of raws does not match the minimum number of rows")
} else if(min(italy_province_csv$date) != as.Date("2020-02-24")){
  stop("The starting date is invalid")
}


if(nrow(italy_province) > nrow(italy_province_csv)){
  print("Updates available")
  usethis::use_data(italy_province, overwrite = TRUE)
  write.csv(italy_province, "csv/italy_province.csv", row.names = FALSE)
  print("The region dataset was updated")
} else {
  print("Updates are not available")
}

return(print("Done..."))

}
