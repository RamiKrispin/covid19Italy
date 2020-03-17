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
#' head(italy_total)
#'

"italy_total"


#' The 2019 Novel Coronavirus COVID-19 (2019-nCoV) Italy Regions Outbreak Dataset
#'
#' @description  daily summary of the Coronavirus (COVID-19) pandemic cases in Italy's regions
#'
#'
#' @format A data.frame object
#' @source Presidenza del Consiglio dei Ministri - Dipartimento della Protezione Civile \href{http://www.protezionecivile.it/}{website}
#' @keywords datasets coronavirus COVID19 Italy
#' @details The dataset contains the daily summary of the Coronavirus pandemic cases in Italy's regions. The data includes the following fields:
#'
#' - date - date of notification (Date class)
#'
#' - region_code - region code
#'
#' - region_name - region names
#'
#' - lat - latitude point
#'
#' - long - Longitude point
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
#' @examples
#'
#' data(italy_region)
#'
#' head(italy_region)
#'

"italy_region"


#' The 2019 Novel Coronavirus COVID-19 (2019-nCoV) Italy Provinces Outbreak Dataset
#'
#' @description  daily summary of the Coronavirus (COVID-19) pandemic cases in Italy's provinces
#'
#'
#' @format A data.frame object
#' @source Presidenza del Consiglio dei Ministri - Dipartimento della Protezione Civile \href{http://www.protezionecivile.it/}{website}
#' @keywords datasets coronavirus COVID19 Italy
#' @details The dataset contains the daily summary of the Coronavirus pandemic cases in Italy's regions. The data includes the following fields:
#'
#' - date - date of notification (Date class)
#'
#' - region_code - region code
#'
#' - region_name - region names
#'
#' - province_code - province code
#'
#' - province_name - province names
#'
#' - lat - latitude point
#'
#' - long - Longitude point
#'
#' - total_positive_cases - total positive cases
#'
#' - total_tests - number of tests performed
#' @examples
#'
#' data(italy_province)
#'
#' head(italy_province)
#'

"italy_province"



