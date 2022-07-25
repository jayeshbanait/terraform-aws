locals {
  config_map_aws_auth = <<CONFIGMAPAWSAUTH
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${aws_iam_role.eks-node-role.arn}
      username: system:node:{{EC2PublicDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
CONFIGMAPAWSAUTH

  kubeconfig = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.ekscluster.endpoint}
    certificate-authority-data: ${aws_eks_cluster.ekscluster.certificate_authority[0].data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${var.environment}-${var.app_name}-eks-cluster"
KUBECONFIG
}

output "config_map_aws_auth" {
  value = local.config_map_aws_auth
}

output "kubeconfig" {
  value = local.kubeconfig
}



output "eks_endpoint" {
    value = aws_eks_cluster.ekscluster.endpoint
}

output "eks_cluster_sg_id" {
    value = aws_eks_cluster.ekscluster.vpc_config[0].cluster_security_group_id
}

output "eks_cluster_name" {
    value = aws_eks_cluster.ekscluster.id
}

output "eks_cluster_cert_authority" {
    value = aws_eks_cluster.ekscluster.certificate_authority[0].data
}
