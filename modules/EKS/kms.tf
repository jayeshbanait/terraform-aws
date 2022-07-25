resource "aws_kms_key" "ekscluster" {
    description = "KMS key for EKS Cluster"
    customer_master_key_spec = "SYMMETRIC_DEFAULT"
    is_enabled = true
    enable_key_rotation = false
    tags = local.common_tags  

    policy = jsonencode({
        "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "kms:*",
            "Resource": "*"
        }]
        Version = "2012-10-17"
    })
}

resource "aws_kms_alias" "ekscluster" {
  name          = "alias/${var.environment}-${var.app_name}-eks"
  target_key_id = aws_kms_key.ekscluster.key_id
}
