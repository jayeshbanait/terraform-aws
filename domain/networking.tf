module "networking" {
  source = "../modules/networking"

  region               = "${var.region}"
  app_name             = var.app_name
  environment          = "${var.environment}"
  vpc_cidr_base        = "${var.vpc_cidr_base}"
  public_subnets_cidr  = "${var.public_subnets_cidr}"
  private_subnets_cidr = "${var.private_subnets_cidr}"
}