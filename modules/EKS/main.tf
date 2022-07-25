module "Global-Vars" {
  source      = "../Global-Vars"
  environment = "${var.environment}"
  region      = "${var.region}"
}

resource "aws_cloudwatch_log_group" "ekscluster" {
    name = "/aws/eks/${var.environment}-${var.app_name}-eks/cluster"
    retention_in_days = 30
}

resource "aws_eks_cluster" "ekscluster" {
    name = "${var.environment}-${var.app_name}-eks-cluster"
    role_arn = "${aws_iam_role.eks-cluster-role.arn}"

    vpc_config {
        endpoint_private_access = true
        endpoint_public_access = false
        public_access_cidrs = local.public_allow_list
        security_group_ids = [var.eks_cluster_sg_id]
        subnet_ids = flatten([var.private_subnet])
    }

    enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
    
    encryption_config {
        provider  {
            key_arn = aws_kms_key.ekscluster.arn
        }
        resources = ["secrets"]
    }

    tags = local.common_tags

    version = var.kube_version

    depends_on = [
      aws_cloudwatch_log_group.ekscluster,
      aws_iam_role.eks-cluster-role
    ]
}

/*
resource "aws_eks_addon" "ekscluster_cni" {
    cluster_name = aws_eks_cluster.ekscluster.name
    addon_name = "vpc-cni"
    addon_version = var.cni_version
    resolve_conflicts = "OVERWRITE"
}

resource "aws_eks_addon" "ekscluster_proxy" {
    cluster_name = aws_eks_cluster.ekscluster.name
    addon_name = "kube-proxy"
    addon_version = var.proxy_version
    resolve_conflicts = "OVERWRITE"
}

resource "aws_eks_addon" "ekscluster_codedns" {
    cluster_name = aws_eks_cluster.ekscluster.name
    addon_name = "coredns"
    addon_version = var.coredns_version
    resolve_conflicts = "OVERWRITE"
}
*/

data "aws_iam_policy_document" "eks-cluster-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com", "ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks-cluster-role" {
  name               = "${var.environment}-${var.app_name}-eks_cluster_role"
  path               = "/"
  assume_role_policy = "${data.aws_iam_policy_document.eks-cluster-role-policy.json}"
}


resource "aws_iam_role_policy_attachment" "eks-cluster-role-policy-attach" {
  role       = "${aws_iam_role.eks-cluster-role.name}"
  count      = "${length(var.eks_cluster_iam_policy_arn)}"
  policy_arn = "${var.eks_cluster_iam_policy_arn[count.index]}"
}

