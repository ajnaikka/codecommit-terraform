# Output the Devgroup name
output "devgroup_name" {
  value = aws_iam_group.dev_group.name
}

# Output the Approval Rule Template name
output "approval_rule_template_name" {
  value = aws_codecommit_approval_rule_template.example.name
}

# output lambda execution role arn 
output "lambda_role" {
  value = aws_iam_role.lambda_execution_role.arn
}

# Output access keys and secret keys for dev users
output "dev_access_keys" {
  value = [aws_iam_access_key.dev_user_access_keys[*].id]
  sensitive = true
}

output "dev_secret_keys" {
  value = [aws_iam_access_key.dev_user_access_keys[*].secret]
  sensitive = true
}

# Output access keys and secret keys for FC users
output "FC_access_keys" {
  value = [aws_iam_access_key.FC_user_access_keys[*].id]
  sensitive = true
}

output "FC_secret_keys" {
  value = [aws_iam_access_key.FC_user_access_keys[*].secret]
  sensitive = true
}