# Creating a lambda function

resource "aws_lambda_function" "example_lambda" {
  function_name = var.function_name
  handler = "lambda_function.lambda_handler" # Replace with your Lambda function's handler

  runtime = "python3.11" # Replace with your desired runtime

  role = data.terraform_remote_state.iam_menachery.outputs.lambda_role # created while creating iam role

  # Specify the S3 bucket and object (your deployment package) where your code is stored.
  source_code_hash = "lYux1LHG+Ha5Wtpd+ChVtC/zeXcraQ9V9r5srmDueJI=" # Replace with the actual S3 object hash if needed

  # Provide the S3 bucket and object key for your deployment package.
  s3_bucket = var.s3_bucket
  s3_key    = var.s3_key # path to ur deployment package.zip

  # Optionally, set environment variables for your Lambda function:
  environment {
    variables = {
      username = var.username # jenkins username
      password = var.password   # jenkins password or api token
      host = var.host
      job_name = var.job_name
    }
  }
}