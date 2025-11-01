resource "aws_api_gateway_rest_api" "this" {
  name        = local.api_name
  description = "API Gateway for ${local.project} Lambdas"

  tags = local.tags
}

data "aws_api_gateway_resource" "root" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  path        = "/"
}

resource "aws_api_gateway_resource" "resources" {
  for_each    = local.resources
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = data.aws_api_gateway_resource.root.id
  path_part   = each.value.path_part
}


resource "aws_cognito_user_pool" "tour_users" {
  name = "tour-booking-userpool"
}

resource "aws_cognito_user_pool_client" "frontend_client" {
  name           = "tour-booking-frontend"
  user_pool_id   = aws_cognito_user_pool.tour_users.id
  generate_secret = false
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows = ["code"]
  allowed_oauth_scopes = ["email", "openid", "profile"]
  callback_urls = ["https://yourfrontend.com/callback"]
}

resource "aws_api_gateway_authorizer" "cognito" {
  name            = "cognito-authorizer"
  rest_api_id     = aws_api_gateway_rest_api.this.id
  type            = "COGNITO_USER_POOLS"
  provider_arns   = [aws_cognito_user_pool.tour_users.arn]
  identity_source = "method.request.header.Authorization"
}

resource "aws_api_gateway_method" "methods" {
  for_each = local.resources

  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.resources[each.key].id
  http_method   = each.value.http_method

  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito.id
}

resource "aws_api_gateway_integration" "integrations" {
  for_each = local.resources

  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.resources[each.key].id
  http_method = aws_api_gateway_method.methods[each.key].http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_functions[each.value.lambda_key].invoke_arn
}

resource "aws_lambda_permission" "api_invoke_permissions" {
  for_each = local.resources

  statement_id  = "AllowAPIGatewayInvoke-${each.key}"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_functions[each.value.lambda_key].function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*/*"
}

resource "aws_api_gateway_deployment" "this" {
  depends_on = [aws_api_gateway_integration.integrations]

  rest_api_id = aws_api_gateway_rest_api.this.id
  stage_name  = local.stage_name

  triggers = {
    redeployment = sha1(jsonencode(local.resources))
  }

  tags = local.tags
}

