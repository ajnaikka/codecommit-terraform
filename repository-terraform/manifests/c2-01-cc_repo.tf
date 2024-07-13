# Create a CodeCommit repository
resource "aws_codecommit_repository" "create_repo" {
  repository_name = var.repository_name
}

# set cc to trigger lambda
resource "aws_codecommit_trigger" "test" {
  repository_name = aws_codecommit_repository.create_repo.repository_name

  trigger {
    name            = "jenkins"
    events          = ["updateReference"]
    branches        = ["production","staging",]
    destination_arn = aws_lambda_function.example_lambda.arn
  }
}