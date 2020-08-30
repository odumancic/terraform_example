output "created_groups" {
  value = aws_iam_group.create_group[*].name
  description = "Created groups: "
}

output "created_users" {
  value = values(aws_iam_user.create_users)[*]["name"]
  description = "Created users: "
}

output "user_policy" {
  value = values(aws_iam_user_policy.attach_policy_to_users)[*]["id"]
  description = "Attached user policy: "
}

output "user_to_group_membership" {
  value = values(aws_iam_user_group_membership.user_membership)[*]
}
