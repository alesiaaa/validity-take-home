terraform {
    backend "s3" {
        bucket = "validity-terraform-state-dev"
        key    = "stage/monolithstarter/terraform.tfstate"
        region = "us-east-1"
    }
}
