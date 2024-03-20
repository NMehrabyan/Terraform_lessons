variable "root_region" {
  description = "AWS region"
  default     = "us-east-2"
}

variable "root_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "lambda_function"
}