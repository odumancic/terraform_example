# terraform_example

Example of terraform code for creating AWS users, groups and role.

There are two variables for creating users and groups, iam_users and iam_gorups. You can assign multiple groups to user.

This code will create user, create groups, create role based on group name and attach policy to users.
User can assume roles that are defined in groups.


<pre><code>
EXAMPLE
variable "iam_users" {
  default =  {
    alex        = { groups = ["developers"] },
    brian        = { groups = ["developers","ops"] },
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
