module "Global-Vars" {
  source          = "../modules/Global-Vars"
  environment     = "${var.environment}"
  region          = "${var.region}"
}