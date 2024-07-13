# Create a FC_Group
resource "aws_iam_group" "FC_group" {
  name = "FC_Group" # Replace with your desired group name
}

# create FC users
resource "aws_iam_user" "FC_users" {
  count = length(var.FC_user_names)  
  name  = var.FC_user_names[count.index]  
}

# Attaching those FC-iam users to FcGroup
resource "aws_iam_group_membership" "FC_group_membership" {
  group = aws_iam_group.FC_group.name
  name = "FC-user-group"
  users = aws_iam_user.FC_users[*].name
}

# Exporting those FC-iam users credentials 
resource "aws_iam_access_key" "FC_user_access_keys" {
  count = length(var.FC_user_names)
  user  = aws_iam_user.FC_users[count.index].name
}

