variable "environment" {
  default = test
  }

variable "owner" {
  default = 
   }

variable "key_name"{
   default = infra
  }


variable "accountID" {
   default = "390808011393"
    }

variable "vpc_cidr_base" {
    default = "10.8.0.0/16"
  description = "The CIDR block of the vpc"
}
variable "public_subnets_cidr" {
  default = ["10.8.1.0/24", "10.8.2.0/24"]
  type        = list
  description = "The CIDR block for the public subnet"
}

variable "private_subnets_cidr" {
  default = ["10.8.3.0/24", "10.8.4.0/24"]
  type        = list
  description = "The CIDR block for the private subnet"
}

variable "region" {
   default = "us-east-1"
  description = "The region to launch the bastion host"
}

variable "aws_linux_web_ami"{

}
variable "public_subnet" {
  default = ["10.8.1.0/24", "10.8.2.0/24"]
  
}
variable "private_subnet" {
  default = ["10.8.3.0/24", "10.8.4.0/24"]
  
}
variable "app_name" {
  default = "helloworld"
  
}
variable "instance_type" {
  default = "t3.medium"
  
}
variable "eks_cluster_iam_policy_arn" {
   default = ["arn:aws:iam::aws:policy/AmazonEKSClusterPolicy", 
"arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly", 
"arn:aws:iam::aws:policy/AmazonEC2FullAccess", 
"arn:aws:iam::aws:policy/AmazonEKSServicePolicy", 
"arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy", 
"arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy", 
"arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"]
  type = list
}
variable "eks_node_iam_policy_arn" {
  description = "IAM Policy to be attached to role"
  default = [
"arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
"arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
"arn:aws:iam::aws:policy/AmazonEC2FullAccess",
"arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
"arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
"arn:aws:iam::aws:policy/AmazonEC2FullAccess"]
  type = list
}
