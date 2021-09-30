## Requirements

- Docker-compose (installed and available on the $PATH)
- Terraform (installed and available on the $PATH)
- AWS command line interface (optional)

## Steps to reproduce:

- Build the lambda and archive ```./build.sh```
- Start docker compose ```docker-compose up -d```
- Deploy the lambda with terraform to localstack
    - ``terraform init``
    - ``terraform plan``
    - ``terraform apply``
- Create the aws alias for local use
  ```alias awslocal="aws --endpoint-url=http://localhost:4566"```
- Create the localstack aws profile add the line to the ```~/.aws/credentials```

    - ```  
       [localstack]
       aws_access_key_id=test
       aws_secret_access_key=test
       output = json
       region = eu-west-2
       ```
  
- Check if the lambda exist with aws cli ```awslocal --profile localstack  lambda list-functions --max-items 10```

- Invoke the
  function ```awslocal lambda  invoke --profile localstack --function-name  lambda1 --cli-binary-format raw-in-base64-out --payload='{"What is your name?":"Stefan","How old are you?":26}' response.json```
- Open the ``response.json`` to view the response