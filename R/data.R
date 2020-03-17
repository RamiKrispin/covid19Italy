#' The 2019 Novel Coronavirus COVID-19 (2019-nCoV) Italy Outbreak Dataset
#'
#' @description  daily summary of the Coronavirus (COVID-19) pandemic cases in Italy
#'
#'
#' @format A data.frame object
#' @source Presidenza del Consiglio dei Ministri - Dipartimento della Protezione Civile \href{http://www.protezionecivile.it/}{website}
#' @keywords datasets coronavirus COVID19 Italy
#' @details The dataset contains the daily summary of the Coronavirus pandemic cases in Italy. The data includes the following fields:
#'
#' - date - date of notification (Date class)
#'
#' - hospitalized_with_symptoms - number of hospitalised patients with symptoms
#'
#' - intensive_care - intensive Care
#'
#' - total_hospitalized - total hospitalised patients
#'
#' - home_confinement - home confinement
#'
#' - total_currently_positive - total amount of current positive cases (Hospitalised patients + Home confinement)
#'
#' - new_currently_positive - news amount of current positive cases (Hospitalised patients + Home confinement)
#'
#' - recovered - recovered cases
#'
#' - death - death cases
#'
#' - total_positive_cases - total positive cases
#'
#' - total_tests - number of tests performed
#'
#' @examples
#'
#' data(italy_total)
#'
#' require(dplyr)
#'
#' # Get the most recent day summary
#' italy_total %>%
#'   dplyr::filter(date == max(date))
#'

"italy_total"


#' The 2019 Novel Coronavirus COVID-19 (2019-nCoV) Italy Outbreak Dataset by region
#'
#' @description  daily summary of the Coronavirus (COVID-19) pandemic cases in Italy
#'
#'
#' @format A data.frame object
#' @source Presidenza del Consiglio dei Ministri - Dipartimento della Protezione Civile \href{http://www.protezionecivile.it/}{website}
#' @keywords datasets coronavirus COVID19 Italy
#' @details The dataset contains the daily summary of the Coronavirus pandemic cases in Italy
#' @examples
#'
#' data(italy_total)
#'
#' require(dplyr)
#'
#' # Get the most recent day summary
#' italy_total %>%
#'   dplyr::filter(date == max(date))
#'

"italy_total"

