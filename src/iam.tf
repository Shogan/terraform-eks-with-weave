resource "aws_iam_policy" "workers_allow_modify_ec2_attribute_policy" {
  name        = "eks-${var.environment}-workers-modify-attribute"
  path        = "/"
  description = "Allows EC2 instances to modify EC2 attributes"
  policy      = "${data.aws_iam_policy_document.workers_allow_modify_ec2_attribute.json}"
}

data "aws_iam_policy_document" "workers_allow_modify_ec2_attribute" {
  statement {
    sid = "Ec2ModifyAttribute"
    effect = "Allow"
    actions = [
      "ec2:ModifyInstanceAttribute"
    ]
    resources = ["*"]
  }
}