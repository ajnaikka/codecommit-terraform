

# Define the custom inline policy for restricting changes to the master branch
data "aws_iam_policy_document" "custom_inline_policy" {
  version = "2012-10-17"
  statement {
    actions   = ["codecommit:GitPush",
                "codecommit:DeleteBranch",
                "codecommit:PutFile",
                "codecommit:MergeBranchesByFastForward",
                "codecommit:MergeBranchesBySquash",
                "codecommit:MergeBranchesByThreeWay",
                "codecommit:MergePullRequestByFastForward",
                "codecommit:MergePullRequestBySquash",
                "codecommit:MergePullRequestByThreeWay"             
                 ]
    resources = [aws_codecommit_repository.create_repo.arn]
    effect    = "Deny"

    condition {
      test     = "StringEqualsIfExists"
      variable = "codecommit:References"
      values   = ["refs/heads/production", "refs/heads/staging"]
    }
    condition {
      test     = "Null"
      variable = "codecommit:References"
      values = [false]
  } 
}
}

# Attach the custom inline policy to the Dev Group
resource "aws_iam_policy" "custom_inline_policy" {
  name        = var.custom_inline_policy_name
  description = "Custom inline policy to restrict push to master branch"
  policy      = data.aws_iam_policy_document.custom_inline_policy.json
}

resource "aws_iam_policy_attachment" "custom_inline_policy_attachment" {
  name       = "CustomInlinePolicyAttachment"
  policy_arn = aws_iam_policy.custom_inline_policy.arn
  groups     = tolist([data.terraform_remote_state.iam_menachery.outputs.devgroup_name])
}