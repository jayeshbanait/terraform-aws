  locals {
  common_tags = {
    application       = ""
    appshortname      = "${var.app_name}"
    environment       = "${var.environment}"
    owner             = "${var.owner}"
    region            = "${var.region}"
    deployment_method = "auto"
  }
  }