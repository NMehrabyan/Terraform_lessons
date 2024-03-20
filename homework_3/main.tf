module "lambda_api" {
  source         = "./modules/lambda"
  region = var.root_region
  function_name = var.root_function_name
  
}



