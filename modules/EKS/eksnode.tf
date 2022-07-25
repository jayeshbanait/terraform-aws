resource "aws_eks_node_group" "eksnode" {
    cluster_name = aws_eks_cluster.ekscluster.name
    node_group_name = "${var.environment}-${var.app_name}-eks-node"
    node_role_arn = "${aws_iam_role.eks-node-role.arn}"
    subnet_ids = flatten([var.private_subnet])
    tags = local.common_tags

    lifecycle {
      create_before_destroy = true
    }

    depends_on = [
      aws_iam_role.eks-node-role,
    ]
}

data "aws_kms_alias" "ebs" {
  name = "alias/aws/ebs"
}

data "aws_iam_policy_document" "eks-node-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks-nodegroup.amazonaws.com", "eks.amazonaws.com", "ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks-node-role" {
  name               = "${var.environment}-${var.app_name}-eks_node_role"
  path               = "/"
  assume_role_policy = "${data.aws_iam_policy_document.eks-node-role-policy.json}"
}

resource "aws_iam_role_policy_attachment" "eks-node-role-policy-attach" {
  role       = "${aws_iam_role.eks-node-role.name}"
  count      = "${length(var.eks_node_iam_policy_arn)}"
  policy_arn = "${var.eks_node_iam_policy_arn[count.index]}"
}