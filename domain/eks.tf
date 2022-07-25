module "eks_cluster" {
  source                  = "../modules/EKS"
  ami                     = "ami-02d1e544b84bf7502"
  app_name                = "${var.app_name}"
  environment             = "${var.environment}"
  region                  = "${var.region}"
  owner                   = "${var.owner}"
  eks_node_iam_policy_arn = var.eks_node_iam_policy_arn
  eks_cluster_iam_policy_arn = var.eks_cluster_iam_policy_arn
  accountID               = var.accountID
  eks_cluster_sg_id       = module.networking.eks_cluster_sg_id
  eks_node_sg_id          = module.networking.eks_node_sg_id
  private_subnet      = ["${module.networking.private_subnets_id}"]
  vpc_id                  = module.networking.vpc_id
  key_name                = "${var.key_name}"
  node_instance_type      = "${var.environment == "prod" ? "t3.large" : "t3.medium"}"
  kube_version            = "1.21"
  platform_version        = "eks.1"
  cni_version             = "v1.9.1-eksbuild.1"
  proxy_version           = "v1.21.2-eksbuild.2"
  coredns_version         = "v1.8.4-eksbuild.1"
  asg_max_size            = "${var.environment == "prod" ? "2" : "1" }"
  asg_min_size            = "${var.environment == "prod" ? "2" : "1" }"
  asg_desired_size        = "${var.environment == "prod" ? "2" : "1" }"
  volume_size             = "20"
  user_data               = "${base64encode(data.template_file.eks.rendered)}"
}
