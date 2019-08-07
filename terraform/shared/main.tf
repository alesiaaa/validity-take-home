module "ecr" {
    source           = "../modules/ecr"
}

module "eb_app" {
    source = "../modules/eb/application"
}
