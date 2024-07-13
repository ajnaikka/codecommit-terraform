# Adding lambda invoke permissions

resource "aws_lambda_permission" "allow_from_lambda" {
	statement_id = "AllowExecutionFromLambda"
	action = "lambda:InvokeFunction"
	function_name = aws_lambda_function.example_lambda.function_name
	principal = "codecommit.amazonaws.com"
}
