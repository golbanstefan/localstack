#!/bin/bash
# Get environments from .env file
if [ -f .env ]
then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

# Create the aws alias for local use
alias awslocal="aws --endpoint-url=http://localhost:4566"

# Create S3 bucket
awslocal s3 mb s3://${S3_BUCKET}

# Build lambda deployment package
GOOS=linux go build -o ./my-lambda .
zip deployemnt.zip my-lambda; rm my-lambda

# Deploy lambda
awslocal lambda create-function \
    --region us-east-1 \
    --function-name ${LAMBDA_NAME} \
    --runtime go1.x \
    --handler my-lambda \
    --memory-size 128 \
    --zip-file fileb://deployemnt.zip \
    --role arn:aws:iam::000000000000:role/irrelevant


# Update lambda
awslocal lambda update-function-code \
    --region us-east-1 \
    --function-name ${LAMBDA_NAME} \
    --zip-file fileb://deployemnt.zip


# Invoke lambda function
awslocal lambda  invoke --function-name  ${LAMBDA_NAME} --cli-binary-format raw-in-base64-out --payload='{"What is your name?":"Stefan","How old are you?":26}' --region=us-east-1 response.json
#awslocal lambda  invoke --function-name  ${LAMBDA_NAME} --cli-binary-format raw-in-base64-out --payload='{"name":"world"}' --region=us-east-1 response.json


# Delete function
awslocal lambda delete-function --function-name ${LAMBDA_NAME}

# List Functions
awslocal lambda list-functions --max-items 10
