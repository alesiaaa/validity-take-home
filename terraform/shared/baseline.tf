provider "aws" {
    version = "~> 2.18.0"

    region  = var.region
    profile = var.profile
}

terraform {
    required_version = ">= 0.12"
}

variable "region" {
    default = "us-east-1"
}

variable "profile" {
    default = "validity-dev"
}
