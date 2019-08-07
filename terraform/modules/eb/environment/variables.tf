variable "region" {
    description = "The AWS region (e.g. us-east-1)"
    type        = "string"
}

variable "application_name" {
    description = "The Elastic Beanstalk application to which this service should be deployed"
    type        = "string"
}

variable "environment_name" {
    description = "The Elastic Beanstalk environment name"
    type        = "string"
}

variable "solution_stack_name" {
    description = "The Elastic Beanstalk solution stack name"
    type        = "string"
    default     = "64bit Amazon Linux 2018.03 v2.12.14 running Docker 18.06.1-ce"
}


variable "asg" {
    type = object({
        max_size = number
        min_size = number
    })
}

variable "deployment" {
    type = object({
        deployment_policy = string
        batch_size_type   = string
        batch_size_value  = number
        timeout_seconds   = number
    })
}

variable "rolling_update" {
    type = object({
        min_instances  = number
        max_batch_size = number
    })
}

variable "launch_configuration" {
    type = object({
        ec2_key_name      = string
        iam_ec2_role      = string
        ec2_ami           = string
        ec2_instance_type = string
    })
}

variable "vpc" {
    type = object({
        vpc_id      = string
        ec2_subnets = string
        elb_subnets = string
    })
}

variable "environment_variables" {
    type = map(string)
}

variable "environment" {
    type = object({
        health_check_interval     = number
        health_check_path         = string
        health_check_timeout      = number
        healthy_threshold_count   = number
        unhealthy_threshold_count = number
    })
}

variable "ssl_cert_arn" {
    type = "string"
}

locals {
    common_tags = {
        Team        = "silver"
        Product     = "monolithstarter"
        Owner       = "patnewell"
    }
}
