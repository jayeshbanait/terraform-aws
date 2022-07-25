locals {

    common_tags = {
    application       = "${var.app_name}"
    environment       = "${var.environment}"
    owner             = "${var.owner}"
    region            = "${var.region}"
    deployment_method = "auto"
  }

    public_allow_list = ["0.0.0.0/0"]

    kube_service_ipv4 = "172.16.20.0/22"