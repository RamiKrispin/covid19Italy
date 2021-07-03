# Pulling raw data
update_italy_region <- function(branch = "master"){

  if(branch != "master" && branch != "dev"){
    stop("The branch argument is missing")
  }

  `%>%` <- magrittr::`%>%`

  italy_region <- readr::read_csv("https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-regioni/dpc-covid19-ita-regioni.csv",
                                  col_types = readr::cols(casi_da_sospetto_diagnostico = readr::col_character(),
                                                   casi_da_screening = readr::col_character(),
                                                   casi_testati = readr::col_character(), note = readr::col_character(),
                                                   ingressi_terapia_intensiva = readr::col_character(),
                                                   note_test = readr::col_character(), note_casi = readr::col_character(),
                                                   totale_positivi_test_molecolare = readr::col_character(),
                                                   totale_positivi_test_antigenico_rapido = readr::col_character(),
                                                   tamponi_test_molecolare = readr::col_character(),
                                                   tamponi_test_antigenico_rapido = readr::col_character(),
                                                   codice_nuts_1 = readr::col_character(),
                                                   codice_nuts_2 = readr::col_character()),
                                  na = "empty") %>%
    stats::setNames(c("date_temp", "state",
                      "region_code", "region_name",
                      "lat", "long",
                      "hospitalized_with_symptoms", "intensive_care",
                      "total_hospitalized", "home_confinement",
                      "cumulative_positive_cases", "daily_positive_cases",
                      "daily_cases", "recovered",
                      "death",
                      "positive_clinical_activity",
                      "positive_surveys_tests",
                      "cumulative_cases",
                      "total_tests", "total_people_tested",
                      "notes",
                      "new_intensive_care",
                      "test_notes", "case_notes",
                      "total_positive_tests",
                      "total_fast_tests",
                      "daily_positive_tests",
                      "daily_fast_tests",
                      "nuts_code_1", "nuts_code_2")) %>%
    dplyr::mutate(date = lubridate::ymd(substr(as.character(date_temp), 1, 10))) %>%
    dplyr::select(-date_temp, - state, -notes, -daily_cases,
                  # -new_intensive_care,
                  -test_notes,
                  -case_notes#,
                  # - total_positive_tests,
                  # -total_fast_tests, - daily_positive_tests,
                  # -daily_fast_tests,
                  # -nuts_code_1, -nuts_code_2
                  ) %>%
    dplyr::select(date, dplyr::everything()) %>%
    dplyr::mutate(region_spatial = region_name) %>%
    dplyr::arrange(date) %>%
    as.data.frame()

  head(italy_region)

  # Encoding(italy_region$region_name) <- "ASCII"
  italy_region$region_spatial <- ifelse(italy_region$region_spatial == "Emilia Romagna",
                                        "Emilia-Romagna",
                                        italy_region$region_spatial)


  italy_region$region_spatial <- ifelse(italy_region$region_spatial == "Friuli Venezia Giulia",
                                        "Friuli-Venezia Giulia",
                                        italy_region$region_spatial)


  italy_region$region_spatial <- ifelse(italy_region$region_spatial == "Sicilia",
                                        "Sicily",
                                        italy_region$region_spatial)

  italy_region$region_spatial <- ifelse(italy_region$region_spatial == "Puglia",
                                        "Apulia",
                                        italy_region$region_spatial)


  italy_region$region_spatial <- ifelse(italy_region$region_spatial == "P.A. Bolzano" |
                                          italy_region$region_spatial == "P.A. Trento",
                                        "Trentino-Alto Adige",
                                        italy_region$region_spatial)


  if(ncol(italy_region) != 26){
    stop("The number of columns is invalid")
  } else if(nrow(italy_region) < 8000){
    stop("The number of raws does not match the minimum number of rows")
  } else if(min(italy_region$date) != as.Date("2020-02-24")){
    stop("The starting date is invalid")
  }

  italy_region_csv <- read.csv(sprintf("https://raw.githubusercontent.com/RamiKrispin/covid19italy/%s/csv/italy_region.csv", branch), stringsAsFactors = FALSE) %>%
    dplyr::mutate(date = as.Date(date))

  if(ncol(italy_region_csv) != 19){
    stop("The number of columns is invalid")
  } else if(nrow(italy_region_csv) < 8000){
    stop("The number of raws does not match the minimum number of rows")
  } else if(min(italy_region_csv$date) != as.Date("2020-02-24")){
    stop("The starting date is invalid")
  }


  if(nrow(italy_region) > nrow(italy_region_csv)){
    print("Updates available")
    usethis::use_data(italy_region, overwrite = TRUE)
    write.csv(italy_region, "csv/italy_region.csv", row.names = FALSE)
    print("The region dataset was updated")
  } else {
    print("Updates are not available")
  }

  return(print("Done..."))

}
