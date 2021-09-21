provider "aws" {
  region = "eu-west-2"
  access_key = "test"
  secret_key = "test"
  skip_credentials_validation = true
  skip_requesting_account_id = true
  skip_metadata_api_check = true
  s3_force_path_style = true
  endpoints {
    s3 = "http://localhost:4566"
    sqs = "http://localhost:4566"
    apigateway = "http://localhost:4566"
    lambda = "http://localhost:4566"
    sns = "http://localhost:4566"
    secretsmanager = "http://localhost:4566"
    iam = "http://localhost:4566"
  }
}
#-------------------------------- resources-------------------

resource "aws_lambda_function" "lambda" {
  function_name = "lambda1"
  filename      = "artefacts/lambda.zip"
  handler       = "main"
  role          = "fake_role"
  runtime       = "go1.x"
  timeout       = 15
  memory_size   = 128
}