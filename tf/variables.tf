variable "lambda_function_name" {
  type        = string
  default     = "TourSearchLambda"
}

variable "lambda_s3_bucket" {
  type        = string
  default     = "aws-dev-orchivis-usecase1-code"
}

variable "lambda_s3_key" {
  type        = string
  default     = "lambda/toursearchlambda.zip"
}

variable "lambda_runtime" {
  type        = string
  default     = "python3.12"
}

variable "lambda_handler" {
  type        = string
  default     = "lambda_function.lambda_handler"
}

variable "lambda_timeout" {
  type        = number
  default     = 15
}

variable "lambda_memory_size" {
  type        = number
  default     = 256
}

variable "website_s3_bucket" {
  type        = string
  default     = "orchivis-tour-booking-site-pages"
}
