variable "function_name" {
  type = string
}

variable "s3_bucket" {
  type = string
}

variable "s3_key" {
  type = string
}

variable "runtime" {
  type = string
}

variable "handler" {
  type = string
}

variable "timeout" {
  type = number
}

variable "memory_size" {
  type = number
}
