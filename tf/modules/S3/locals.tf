locals {
  env     = terraform.workspace
  project = "gtholidays"

  buckets = {
    booking_code = {
      name       = "s3-${local.env}-gtholidays-booking-code"
      versioning = true
      website    = false
    }
    booking_website = {
      name       = "s3-${local.env}-gtholidays-booking-website"
      versioning = false
      website    = true
    }
    toursearch_code = {
      name       = "s3-${local.env}-gtholidays-tour-search"
      versioning = true
      website    = false
    }
  }
}
