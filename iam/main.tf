
provider "aws" {
  profile = "default"
  region  = var.aws_region
}

data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

resource "aws_iam_group" "create_group" {
  count = length(var.iam_groups)
  name = var.iam_groups[count.index]
}

resource "aws_iam_user" "create_users" {
  for_each = var.iam_users
  name = each.key
}

resource "aws_iam_user_policy" "attach_policy_to_users" {
  depends_on = [ aws_iam_user.create_users ]
  for_each = var.iam_users
  name = "sts"
  user = each.key

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sts:AssumeRole"
      ],
      "Effect": "Allow",
      "Resource": [ "arn:aws:iam::${ data.aws_caller_identity.current.account_id }:role/${join("\",\"arn:aws:iam::${ data.aws_caller_identity.current.account_id }:role/", each.value.groups)}" ]
     }
  ]
}
EOF
}

resource "aws_iam_user_group_membership" "user_membership" {
  depends_on = [ aws_iam_user.create_users, aws_iam_group.create_group]
  for_each = var.iam_users
  user = each.key
  groups = each.value.groups
}


resource "aws_iam_role" "create_default_role" {
  count = length(var.iam_groups)
  name = var.iam_groups[count.index]
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${ data.aws_caller_identity.current.account_id }:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {}
    }
  ]
}
EOF
  tags = {
    tag-key = var.iam_groups[count.index]
  }
}
