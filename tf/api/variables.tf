variable "lambda_functions" {
  description = "Map of Lambda functions with keys matching local.resources.lambda_key"
  type = map(object({
    function_name = string
    invoke_arn    = string
  }))
}

variable "region" {
  description = "AWS region where the API Gateway will be created"
  type        = string
}

variable "stage_name" {
  description = "API deployment stage name"
  type        = string
  default     = "dev"
}
