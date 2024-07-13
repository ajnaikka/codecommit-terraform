# Create a DevGroup
resource "aws_iam_group" "dev_group" {
  name = "DevGroup" # Replace with your desired group name
}

# create dev users
resource "aws_iam_user" "dev_users" {
  count = length(var.dev_user_names)
  name  = var.dev_user_names[count.index]
}

# Attaching those dev-iam users to DevGroup
resource "aws_iam_group_membership" "dev_group_membership" {
  group = aws_iam_group.dev_group.name
  name = "dev-user-group"
  users = aws_iam_user.dev_users[*].name
}

# Exporting those dev-iam users credentials 
resource "aws_iam_access_key" "dev_user_access_keys" {
  count = length(var.dev_user_names)
  user  = aws_iam_user.dev_users[count.index].name
}

# custom inline policy for developer access
data "aws_iam_policy_document" "custom_inline_policy" {
  version = "2012-10-17"
  statement {
    actions   = [
      "codecommit:CreateBranch",
				"codecommit:TagResource",
				"codecommit:GetTree",
				"codecommit:ListPullRequests",
				"codecommit:GetBlob",
				"codecommit:GetReferences",
				"codecommit:CreateCommit",
				"codecommit:ListRepositories",
				"codecommit:GetPullRequestApprovalStates",
				"codecommit:DescribeMergeConflicts",
				"codecommit:ListTagsForResource",
				"codecommit:BatchDescribeMergeConflicts",
				"codecommit:GetCommentsForComparedCommit",
				"codecommit:ListFileCommitHistory",
				"codecommit:GetCommentReactions",
				"codecommit:GetCommit",
				"codecommit:GetComment",
				"codecommit:GetCommitHistory",
				"codecommit:GetCommitsFromMergeBase",
				"codecommit:GetApprovalRuleTemplate",
				"codecommit:BatchGetCommits",
				"codecommit:DescribePullRequestEvents",
				"codecommit:CreatePullRequest",
				"codecommit:GetPullRequest",
				"codecommit:ListBranches",
				"codecommit:GetPullRequestOverrideState",
				"codecommit:GetRepositoryTriggers",
				"codecommit:GitPull",
				"codecommit:BatchGetRepositories",
				"codecommit:GetCommentsForPullRequest",
				"codecommit:UntagResource",
				"codecommit:GetObjectIdentifier",
				"codecommit:CancelUploadArchive",
				"codecommit:GetFolder",
				"codecommit:BatchGetPullRequests",
				"codecommit:GetFile",
				"codecommit:GetUploadArchiveStatus",
				"codecommit:EvaluatePullRequestApprovalRules",
				"codecommit:GetDifferences",
				"codecommit:GetRepository",
				"codecommit:GetBranch",
				"codecommit:GetMergeConflicts",
				"codecommit:GetMergeCommit",
				"codecommit:DeleteFile",
				"codecommit:GitPush",
				"codecommit:GetMergeOptions"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
}

# Attach the custom inline policy of devloper's access to the Dev Group
resource "aws_iam_policy" "custom_inline_policy" {
  name        = "Devloper-access"
  description = "Custom inline policy for developer access"
  policy      = data.aws_iam_policy_document.custom_inline_policy.json
}

resource "aws_iam_policy_attachment" "custom_inline_policy_attachment" {
  name       = "CustomInlinePolicyAttachment"
  policy_arn = aws_iam_policy.custom_inline_policy.arn
  groups     = [aws_iam_group.dev_group.name]
}