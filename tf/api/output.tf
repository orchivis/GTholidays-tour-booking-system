##########################################
# Output
##########################################
output "api_invoke_url" {
  description = "Invoke URL of the deployed API Gateway"
  value       = "${aws_api_gateway_deployment.this.invoke_url}${var.stage_name}"
}
