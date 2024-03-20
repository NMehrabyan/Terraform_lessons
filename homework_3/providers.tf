terraform {
  backend "s3" {
    bucket = "wwweee"
    key    = "TFstate/state"
    region = "us-east-2"
    dynamodb_table = "Mytable"
    insecure = true
  }
   required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
}
   }
}



# Configure the AWS Provider
provider "aws" {
  region   = "us-east-2"
  insecure = true
}