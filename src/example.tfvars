region = "eu-west-2"
environment = "dev"
map_users = [ { userarn = "arn:aws:iam::123456789123:user/your.iam.username", username = "yourusername", groups = ["system:masters"] } ]
bootstrap_extra_args = "--use-max-pods false"