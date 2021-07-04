test_that(desc = "Test the dates", {

  expect_equal(base::class(italy_total$date) == "Date", TRUE)
  expect_equal(base::class(italy_region$date) == "Date", TRUE)
  expect_equal(base::class(italy_province$date) == "Date", TRUE)
  expect_equal(base::min(italy_total$date) == as.Date("2020-02-24"), TRUE)
})


test_that(desc = "Test the structure", {

  expect_equal(base::ncol(italy_total) == 19, TRUE)
  expect_equal(base::ncol(italy_region) == 26, TRUE)
  expect_equal(base::ncol(italy_province) == 14, TRUE)

  expect_equal(base::nrow(italy_total) >= 380, TRUE)
  expect_equal(base::nrow(italy_region) >= 8000, TRUE)
  expect_equal(base::nrow(italy_province) >= 54000, TRUE)

})
