provider "aws" {
  region = "us-east-1"
  access_key = "123"
  secret_key = "xyz"
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
resource "aws_s3_bucket" "localstack-test-bucket" {
  bucket = "localstack-test-bucket"
}
//resource "aws_sqs_queue" "localstack-test-sqs" {
//  name                      = "localstack-test-sqs"
//  tags = {
//    Environment = "dev"
//  }
//}

//resource "aws_api_gateway_rest_api" "localstack-rest-api" {
//  name = "localstack-rest-api"
//}

//resource "aws_api_gateway_resource" "localstack-rest-api-resource" {
//  parent_id   = aws_api_gateway_rest_api.localstack-rest-api.root_resource_id
//  path_part   = "test"
//  rest_api_id = aws_api_gateway_rest_api.localstack-rest-api.id
//}

resource "aws_lambda_function" "test_lambda" {
  filename = "deployemnt.zip"
  function_name = "local-test"
  role = aws_iam_role.localstack-role.arn
  handler = "my-lambda"
  source_code_hash = filebase64sha256("deployemnt.zip")
  runtime = "go1.x"
}

//resource "aws_sns_topic" "localstack-sns-topic" {
//  name = "localstack-sns-topic"
//}

//resource "aws_secretsmanager_secret" "localstack-secret" {
//  name                    = "localstack-secret"
//  recovery_window_in_days = 0
//}

data "aws_iam_policy_document" "localstack_policy" {
  statement {
    actions = [
      "*"]
    effect = "Allow"
  }
}

resource "aws_iam_role" "localstack-role" {
  name = "localstack-role"
  assume_role_policy = data.aws_iam_policy_document.localstack_policy.json
}