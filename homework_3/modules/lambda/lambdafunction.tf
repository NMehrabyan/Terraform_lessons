data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}"  
  output_path = "${path.module}/lambda.zip"
}




# Create Lambda function
resource "aws_lambda_function" "lambda_function" {
  filename      = "${path.module}/lambda.zip"
  function_name = var.function_name
  role          = "arn:aws:iam::814976642708:role/RoleLambda"
  handler       = "main.handler"
  runtime       = "python3.8"


}

# Create API Gateway
resource "aws_api_gateway_rest_api" "api_gateway" {
  name = "lambda_api"
}

# Create API Gateway Resource
resource "aws_api_gateway_resource" "api_gateway_resource" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id   = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part   = "{proxy+}"
}

# Create API Gateway Method
resource "aws_api_gateway_method" "api_gateway_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  resource_id   = aws_api_gateway_resource.api_gateway_resource.id
  http_method   = "ANY"
  authorization = "NONE"
}

# Integration between API Gateway and Lambda
resource "aws_api_gateway_integration" "api_gateway_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api_gateway.id
  resource_id             = aws_api_gateway_resource.api_gateway_resource.id
  http_method             = aws_api_gateway_method.api_gateway_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_function.invoke_arn
}

# Deploy API Gateway
resource "aws_api_gateway_deployment" "api_gateway_deployment" {
  depends_on = [aws_api_gateway_integration.api_gateway_integration]
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  stage_name = "dev"
}
