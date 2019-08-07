locals {
    workspace_error = "This terraform uses workspaces. Please run `terraform workspace select <workspace>` where <workspace> is stage-us-east-1."

    // Mappings

    environment_map = {
        "stage-us-east-1" = "stage"
    }

    region_map = {
        "stage-us-east-1" = "us-east-1"
    }

    eb_asg_map = {
        "stage-us-east-1" = {
            max_size = 8
            min_size = 2
        }
    }

    eb_deployment_map = {
        "stage-us-east-1" = {
            deployment_policy = "RollingWithAdditionalBatch"
            batch_size_type   = "Percentage"
            batch_size_value  = 100
            timeout_seconds   = 600
        }
    }

    eb_rolling_update_map = {
        "stage-us-east-1" = {
            min_instances  = 2
            max_batch_size = 2
        }
    }

    eb_launch_configuration_map = {
        "stage-us-east-1" = {
            ec2_key_name      = "aws-ssh-eb"
            iam_ec2_role      = "aws-elasticbeanstalk-ec2-role"
            ec2_ami           = "ami-07ae58c530821dc13"
            ec2_instance_type = "t2.medium"
        }
    }

    eb_vpc_map = {
        "stage-us-east-1" = {
            vpc_id      = "vpc-062c4d65f728d09f8"
            ec2_subnets = "subnet-00893b16a0570f026,subnet-0f2cb084f5b5c7bcf"
            elb_subnets = "subnet-09882273e2678fb1d,subnet-0e87a16c237e82316"
        }
    }

    eb_environment_variables_map = {
        "stage-us-east-1" = {
            JAVA_TOOL_OPTIONS    = "-Dspring.profiles.active=stage,aws,swagger -Dnewrelic.environment=staging"
            SPRING_PROFILES      = "stage,aws,swagger"
            NEWRELIC_ENVIRONMENT = "staging"
        }
    }

    eb_environment_map = {
        "stage-us-east-1" = {
            health_check_interval     = 15
            health_check_path         = "/"
            health_check_timeout      = 5
            healthy_threshold_count   = 3
            unhealthy_threshold_count = 5
        }
    }

    eb_ssl_cert_arn_map = {
        "stage-us-east-1" = "arn:aws:acm:us-east-1:744761879425:certificate/69c51c79-da0e-4166-b202-ffe0a8b6f69a"
    }

    environment = lookup(local.environment_map, terraform.workspace, local.workspace_error)
    region = lookup(local.region_map, terraform.workspace, local.workspace_error)
    eb_asg = local.eb_asg_map[terraform.workspace]
    eb_deployment = local.eb_deployment_map[terraform.workspace]
    eb_rolling_update = local.eb_rolling_update_map[terraform.workspace]
    eb_launch_configuration = local.eb_launch_configuration_map[terraform.workspace]
    eb_vpc = local.eb_vpc_map[terraform.workspace]
    eb_environment_variables = local.eb_environment_variables_map[terraform.workspace]
    eb_environment = local.eb_environment_map[terraform.workspace]
    eb_ssl_cert_arn = local.eb_ssl_cert_arn_map[terraform.workspace]
}
