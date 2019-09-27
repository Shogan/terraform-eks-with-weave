variable "region" {
  default = "eu-west-2"
  type = "string"
}

variable "environment" {
  default = "example"
  type = "string"
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      userarn  = "arn:aws:iam::66666666666:user/user1"
      username = "user1"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::66666666666:user/user2"
      username = "user2"
      groups   = ["system:masters"]
    },
  ]
}

variable "bootstrap_extra_args" {
  description = "Extra arguments passed to the bootstrap.sh script from the EKS AMI."
  type = "string"
}