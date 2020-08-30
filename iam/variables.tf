variable "aws_region" {
  default = "eu-west-1"
}

variable "iam_users" {
  default =  { 
    eugene 	= { groups = ["developers"] },
    milo 	= { groups = ["developers"] },
    abigail 	= { groups = ["developers"] },
    adian  	= { groups = ["developers","ops"] },
    santiago 	= { groups = ["ops"] },
    felix    	= { groups = ["ops"] },
    morgan   	= { groups = ["ops"] },
  }
}

variable "iam_groups" {
  default = [
    "developers",
    "ops"
  ]
}

