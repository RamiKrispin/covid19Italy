test_that(desc = "Test the dates", {
  expect_equal(base::class(italy_total$date) == "Date", TRUE)
  expect_equal(base::class(italy_region$date) == "Date", TRUE)
  expect_equal(base::class(italy_province$date) == "Date", TRUE)
  expect_equal(base::min(italy_region$date) == as.Date("2020-02-24"), TRUE)
})
