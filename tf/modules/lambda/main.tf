resource "aws_lambda_function" "this" {
  for_each      =local.lambdas
  function_name =each.value.function_name
  s3_bucket     =each.value.s3_bucket
  s3_key        =each.value.s3_key
  runtime       =each.value.runtime
  handler       =each.value.handler
  timeout       =each.value.timeout
  memory_size   =each.value.memory_size
  role          = aws_iam_role.lambda_exec[each.key].arn

    tags = {
    Environment = terraform.workspace
    Project     = "gtholidays"
    ManagedBy   = "Terraform"
  }
}

# IAM Role for Lambda
resource "aws_iam_role" "lambda_exec" {
  for_each = local.lambdas
  name = "${each.value.function_name}-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })

  tags = {
  Environment = terraform.workspace
  Project     = "gtholidays"
  ManagedBy   = "Terraform"
  }
}

# IAM Policy Attachment
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
