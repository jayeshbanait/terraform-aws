terraform {
  backend "s3" {
   encrypt = true
   bucket  = "${var.environment}-${var.app_name}-env-s3"
   key = "Statefile/terraform.tfstate"
   region  = "us-east-1"
  }
}