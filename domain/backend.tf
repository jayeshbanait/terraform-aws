terraform {
  backend "s3" {
   encrypt = true
   bucket  = "test-helloworld-env-s3"
   key = "Statefile/terraform.tfstate"
   region  = "us-east-1"
  }
}
