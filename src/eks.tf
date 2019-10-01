terraform {
  required_version = ">= 0.12.0"
}

provider "aws" {
  version = ">= 2.28.1"
  region  = var.region
  skip_credentials_validation = true
}

provider "local" {
  version = "~> 1.2"
}

provider "null" {
  version = "~> 2.1"
}

provider "template" {
  version = "~> 2.1"
}

data "aws_availability_zones" "available" {
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "6.0.1"
  cluster_name    = "eks-${var.environment}"
  cluster_version = "1.14"
  subnets         = module.vpc.private_subnets

  tags = {
    Environment = var.environment
  }

  vpc_id = module.vpc.vpc_id

  worker_groups = [
    {
      name                          = "abc-worker-group-1"
      instance_type                 = "t3a.small"
      pre_userdata                  = "${data.template_file.eks_linux_pre_user_data_template.rendered}"
      asg_desired_capacity          = 1
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
      bootstrap_extra_args          = var.bootstrap_extra_args
      iam_instance_profile_name     = "Shogan_EKS_General_Worker"
    },
    {
      name                          = "kiam-worker-group-1"
      instance_type                 = "t3a.small"
      pre_userdata                  = "${data.template_file.eks_linux_pre_user_data_template.rendered}"
      asg_desired_capacity          = 1
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_two.id]
      bootstrap_extra_args          = var.bootstrap_extra_args
      iam_instance_profile_name     = "Shogan-Assume-All-Roles-Kiam-Eks"
      kubelet_extra_args            = "--node-labels=kiam-server=true --register-with-taints=kiam-server=false:NoExecute"
    }
  ]

  workers_additional_policies = ["${aws_iam_policy.workers_allow_modify_ec2_attribute_policy.arn}"]
  worker_additional_security_group_ids = [aws_security_group.all_worker_mgmt.id]
  manage_worker_iam_resources = false
  map_users                   = var.map_users
}