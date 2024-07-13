# Create a ApprovalRuleTemplate
resource "aws_codecommit_approval_rule_template" "example" {
  name        = "ApprovalRuleTemplate"
  description = "This is an example approval rule template"

  content = jsonencode({
    Version               = "2018-11-08"
    DestinationReferences = ["refs/heads/staging", "refs/heads/production"]
    Statements = [{
      Type                    = "Approvers"
      NumberOfApprovalsNeeded = 1
      ApprovalPoolMembers     = [data.aws_iam_user.ajay.arn] # attach the approver user's arn here
    }]
  })
}

# Retrieve the ARN for "ameen" using the data source

data "aws_iam_user" "ajay" {
  user_name = "ajay@loyalitsolutions.com"
}
