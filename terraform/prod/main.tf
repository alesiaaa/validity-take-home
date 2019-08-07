module "eb_env" {
    source                = "../modules/eb/environment"
    application_name      = "monolithstarter"
    environment_name      = "monolithstarter-${local.environment}"
    region                = local.region
    vpc                   = local.eb_vpc
    asg                   = local.eb_asg
    deployment            = local.eb_deployment
    rolling_update        = local.eb_rolling_update
    launch_configuration  = local.eb_launch_configuration
    environment_variables = local.eb_environment_variables
    environment           = local.eb_environment
    ssl_cert_arn          = local.eb_ssl_cert_arn
}
