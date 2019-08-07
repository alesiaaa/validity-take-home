provider "aws" {
    version = "~> 2.18.0"

    region  = local.region
    profile = var.profile
}

terraform {
    required_version = ">= 0.12"
}

variable "profile" {
    default = "validity-dev"
}
