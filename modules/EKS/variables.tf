variable "app_name" {}

variable "environment" {}

variable "owner" {}
variable "eks_cluster_sg_id" {}
variable "eks_node_sg_id" {}
variable "private_subnet" {}
variable "key_name" {}

variable "vpc_id" {}

variable "accountID" {}
variable "volume_size" {
  default = 100
}

variable "kube_version" {
    default = "1.21"
}

variable "platform_version" {
    default = "eks.1"
}

variable "cni_version" {
    default = "v1.8.0-eksbuild.1"
}

variable "proxy_version" {
    default = "v1.20.4-eksbuild.2"
}

variable "coredns_version" {
    default = "v1.8.5-eksbuild.1"
}

variable "region" {
    default = "us-east-1"
}

variable "asg_desired_size" {
    default = "1"
}

variable "asg_min_size" {
    default = "1"
}

variable "asg_max_size" {
    default = "1"
}

variable "ami" {
    default = ""
}

variable "node_instance_type" {
    default = "t3.medium"
}


variable "user_data" {}

variable "eks_cluster_iam_policy_arn" {
  description = "IAM Policy to be attached to role"
  type = list
}

variable "eks_node_iam_policy_arn" {
  description = "IAM Policy to be attached to role"
  type = list
}
