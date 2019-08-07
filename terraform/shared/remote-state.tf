terraform {
    backend "s3" {
        bucket = "validity-terraform-state-prod"
        key    = "prod/monolithstarter-shared/terraform.tfstate"
        region = "us-east-1"
    }
}
