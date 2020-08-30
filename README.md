# terraform_example

Example of terraform code for creating AWS users, groups and role.

There are two variables for creating users and groups, iam_users and iam_gorups. You can assign multiple groups to user.

This code will create user, create groups, create role based on group name and attach policy to users.
User can assume roles that are defined in groups.

<pre><code> EXAMPLE
variable "iam_users" {
  default =  {
    alex        = { groups = ["developers"] },
    brian       = { groups = ["developers","ops"] },
    }
}

variable "iam_groups" {
  default = [
    "developers",
    "ops"
  ]
}
</code></pre>

This code is tested on AWS.

Explanation:
Users will be created with the "aws_iam_user" module from the "iam_users" dictionary. This will create normal user in the AWS, since this is dictionary we can add additional keys if needed (like tags, etc.).
Groups will be created with the "aws_iam_group" module from the "iam_groups" dictionary. 
One reason this is separate list it that I wanted to control excatly which gorups to create. 
I can create groups from the "iam_users.groups" but if the group name is missplelled it will just create new groups which I don't like.
Roles are creates using "aws_iam_role" module and I have assigned default policy to the role. Roles have the same name as the groups.
Users are assigned to groups using "aws_iam_user_group_membership" module.
In order for user to assume role it needs to have correct policy so "aws_iam_user_policy" module will attach policy to users to allow them to assume roles (user will be able to assume only role that are specified in iam_users.groups).

For example user1 that have group1 assignes will be able to assume role group1 but won't be able to assume other roles if they exist for other users.

This module should work even if user don't have any groups assigned to them
