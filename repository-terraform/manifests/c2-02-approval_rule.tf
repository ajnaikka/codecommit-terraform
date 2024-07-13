
# ApprovalRuleTemplate association with repo
resource "aws_codecommit_approval_rule_template_association" "example" {
  approval_rule_template_name = data.terraform_remote_state.iam_menachery.outputs.approval_rule_template_name
  repository_name             = aws_codecommit_repository.create_repo.repository_name
}



