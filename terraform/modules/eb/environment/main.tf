data "aws_elastic_beanstalk_application" "monolithstarter" {
  name = var.application_name
}

resource "aws_elastic_beanstalk_environment" "monolithstarter" {
    name                = var.environment_name
    application         = data.aws_elastic_beanstalk_application.monolithstarter.name
    solution_stack_name = var.solution_stack_name

    tags = {
        name        = "MonolithStarter Elastic Beanstalk environment for ${var.environment_name}"
        environment = var.environment_name
        product     = "monolithstarter"
        owner       = "patnewell"
        team        = "silver-team"
        lifecycle   = "terraform"
        repo_name   = "validityhq/MonolithStarter"
    }

    // ASG Configuration

    setting {
        namespace = "aws:autoscaling:asg"
        name      = "MaxSize"
        value     = var.asg.max_size
    }

    setting {
        namespace = "aws:autoscaling:asg"
        name      = "MinSize"
        value     = var.asg.min_size
    }

    // Launch Configuration

    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name      = "EC2KeyName"
        value     = var.launch_configuration.ec2_key_name
    }

    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name      = "IamInstanceProfile"
        value     = aws_iam_instance_profile.monolithstarter_ec2_instance.name
    }

    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name      = "ImageId"
        value     = var.launch_configuration.ec2_ami
    }

    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name      = "InstanceType"
        value     = var.launch_configuration.ec2_instance_type
    }

    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name      = "MonitoringInterval"
        value     = "5 minute"
    }

    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name      = "SSHSourceRestriction"
        value     = "tcp,22,22,0.0.0.0/0"
    }

    // Auto Scaling Trigger

    setting {
        namespace = "aws:autoscaling:trigger"
        name      = "BreachDuration"
        value     = "5"
    }

    setting {
        namespace = "aws:autoscaling:trigger"
        name      = "EvaluationPeriods"
        value     = "1"
    }

    setting {
        namespace = "aws:autoscaling:trigger"
        name      = "EvaluationPeriods"
        value     = "1"
    }

    setting {
        namespace = "aws:autoscaling:trigger"
        name      = "LowerBreachScaleIncrement"
        value     = "-1"
    }

    setting {
        namespace = "aws:autoscaling:trigger"
        name      = "LowerThreshold"
        value     = "2000000"
    }

    setting {
        namespace = "aws:autoscaling:trigger"
        name      = "MeasureName"
        value     = "NetworkOut"
    }

    setting {
        namespace = "aws:autoscaling:trigger"
        name      = "Period"
        value     = "5"
    }

    setting {
        namespace = "aws:autoscaling:trigger"
        name      = "Statistic"
        value     = "Average"
    }

    setting {
        namespace = "aws:autoscaling:trigger"
        name      = "Unit"
        value     = "Bytes"
    }

    setting {
        namespace = "aws:autoscaling:trigger"
        name      = "UpperBreachScaleIncrement"
        value     = "1"
    }

    setting {
        namespace = "aws:autoscaling:trigger"
        name      = "UpperThreshold"
        value     = "6000000"
    }

    // Rolling Update Policy

    setting {
        namespace = "aws:autoscaling:updatepolicy:rollingupdate"
        name      = "RollingUpdateEnabled"
        value     = "true"
    }

    setting {
        namespace = "aws:autoscaling:updatepolicy:rollingupdate"
        name      = "RollingUpdateType"
        value     = "Health"
    }

    setting {
        namespace = "aws:autoscaling:updatepolicy:rollingupdate"
        name      = "MinInstancesInService"
        value     = var.rolling_update.min_instances
    }

    setting {
        namespace = "aws:autoscaling:updatepolicy:rollingupdate"
        name      = "MaxBatchSize"
        value     = var.rolling_update.max_batch_size
    }

    setting {
        namespace = "aws:autoscaling:updatepolicy:rollingupdate"
        name      = "Timeout"
        value     = "PT30M"
    }

    // VPC Settings

    setting {
        namespace = "aws:ec2:vpc"
        name      = "AssociatePublicIpAddress"
        value     = "false"
    }

    setting {
        namespace = "aws:ec2:vpc"
        name      = "ELBScheme"
        value     = "public"
    }

    setting {
        namespace = "aws:ec2:vpc"
        name      = "ELBSubnets"
        value     = var.vpc.elb_subnets
    }

    setting {
        namespace = "aws:ec2:vpc"
        name      = "Subnets"
        value     = var.vpc.ec2_subnets
    }

    setting {
        namespace = "aws:ec2:vpc"
        name      = "VPCId"
        value     = var.vpc.vpc_id
    }

    // Environment Variables

    dynamic "setting" {
        for_each = var.environment_variables
        content {
            namespace = "aws:elasticbeanstalk:application:environment"
            name      = setting.key
            value     = setting.value
        }
    }

    // CloudWatch Logs

    setting {
        namespace = "aws:elasticbeanstalk:cloudwatch:logs"
        name      = "DeleteOnTerminate"
        value     = "false"
    }

    setting {
        namespace = "aws:elasticbeanstalk:cloudwatch:logs"
        name      = "RetentionInDays"
        value     = "7"
    }

    setting {
        namespace = "aws:elasticbeanstalk:cloudwatch:logs"
        name      = "StreamLogs"
        value     = "false"
    }

    setting {
        namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
        name      = "DeleteOnTerminate"
        value     = "false"
    }

    setting {
        namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
        name      = "HealthStreamingEnabled"
        value     = "false"
    }

    setting {
        namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
        name      = "RetentionInDays"
        value     = "7"
    }

    // EB Command

    setting {
        namespace = "aws:elasticbeanstalk:command"
        name      = "BatchSize"
        value     = var.deployment.batch_size_value
    }

    setting {
        namespace = "aws:elasticbeanstalk:command"
        name      = "BatchSizeType"
        value     = var.deployment.batch_size_type
    }

    setting {
        namespace = "aws:elasticbeanstalk:command"
        name      = "DeploymentPolicy"
        value     = var.deployment.deployment_policy
    }

    setting {
        namespace = "aws:elasticbeanstalk:command"
        name      = "IgnoreHealthCheck"
        value     = "false"
    }

    setting {
        namespace = "aws:elasticbeanstalk:command"
        name      = "Timeout"
        value     = var.deployment.timeout_seconds
    }

    // EB Control

    setting {
        namespace = "aws:elasticbeanstalk:control"
        name      = "DefaultSSHPort"
        value     = "22"
    }

    setting {
        namespace = "aws:elasticbeanstalk:control"
        name      = "LaunchTimeout"
        value     = "0"
    }

    setting {
        namespace = "aws:elasticbeanstalk:control"
        name      = "LaunchType"
        value     = "Migration"
    }

    setting {
        namespace = "aws:elasticbeanstalk:control"
        name      = "RollbackLaunchOnFailure"
        value     = "false"
    }

    // EB Environment

    setting {
        namespace = "aws:elasticbeanstalk:environment"
        name      = "EnvironmentType"
        value     = "LoadBalanced"
    }

    setting {
        namespace = "aws:elasticbeanstalk:environment"
        name      = "LoadBalancerType"
        value     = "application"
    }

    setting {
        namespace = "aws:elasticbeanstalk:environment:process:default"
        name      = "DeregistrationDelay"
        value     = "20"
    }

    setting {
        namespace = "aws:elasticbeanstalk:environment:process:default"
        name      = "HealthCheckInterval"
        value     = var.environment.health_check_interval
    }

    setting {
        namespace = "aws:elasticbeanstalk:environment:process:default"
        name      = "HealthCheckPath"
        value     = var.environment.health_check_path
    }

    setting {
        namespace = "aws:elasticbeanstalk:environment:process:default"
        name      = "HealthCheckTimeout"
        value     = var.environment.health_check_timeout
    }

    setting {
        namespace = "aws:elasticbeanstalk:environment:process:default"
        name      = "HealthyThresholdCount"
        value     = var.environment.healthy_threshold_count
    }

    setting {
        namespace = "aws:elasticbeanstalk:environment:process:default"
        name      = "Port"
        value     = "80"
    }

    setting {
        namespace = "aws:elasticbeanstalk:environment:process:default"
        name      = "Protocol"
        value     = "HTTP"
    }

    setting {
        namespace = "aws:elasticbeanstalk:environment:process:default"
        name      = "StickinessEnabled"
        value     = "false"
    }

    setting {
        namespace = "aws:elasticbeanstalk:environment:process:default"
        name      = "UnhealthyThresholdCount"
        value     = var.environment.unhealthy_threshold_count
    }

    // EB Proxy

    setting {
        namespace = "aws:elasticbeanstalk:environment:proxy"
        name      = "ProxyServer"
        value     = "nginx"
    }

    // Health Reporting

    setting {
        namespace = "aws:elasticbeanstalk:healthreporting:system"
        name      = "HealthCheckSuccessThreshold"
        value     = "Ok"
    }

    setting {
        namespace = "aws:elasticbeanstalk:healthreporting:system"
        name      = "SystemType"
        value     = "enhanced"
    }

    // Other

    setting {
        namespace = "aws:elasticbeanstalk:hostmanager"
        name      = "LogPublicationControl"
        value     = "false"
    }

    setting {
        namespace = "aws:elasticbeanstalk:managedactions"
        name      = "ManagedActionsEnabled"
        value     = "false"
    }

    setting {
        namespace = "aws:elasticbeanstalk:managedactions:platformupdate"
        name      = "InstanceRefreshEnabled"
        value     = "false"
    }

    setting {
        namespace = "aws:elasticbeanstalk:monitoring"
        name      = "Automatically Terminate Unhealthy Instances"
        value     = "true"
    }

    // HTTP(S) Listeners

    setting {
        namespace = "aws:elbv2:listener:443"
        name      = "DefaultProcess"
        value     = "default"
    }

    setting {
        namespace = "aws:elbv2:listener:443"
        name      = "ListenerEnabled"
        value     = "true"
    }

    setting {
        namespace = "aws:elbv2:listener:443"
        name      = "Protocol"
        value     = "HTTPS"
    }

    setting {
        namespace = "aws:elbv2:listener:443"
        name      = "SSLCertificateArns"
        value     = var.ssl_cert_arn
    }

    setting {
        namespace = "aws:elbv2:listener:443"
        name      = "SSLPolicy"
        value     = "ELBSecurityPolicy-2016-08"
    }

    setting {
        namespace = "aws:elbv2:listener:default"
        name      = "DefaultProcess"
        value     = "default"
    }

    setting {
        namespace = "aws:elbv2:listener:default"
        name      = "ListenerEnabled"
        value     = "true"
    }

    setting {
        namespace = "aws:elbv2:listener:default"
        name      = "Protocol"
        value     = "HTTP"
    }

    // Load Balancer

    setting {
        namespace = "aws:elbv2:loadbalancer"
        name      = "AccessLogsS3Enabled"
        value     = "false"
    }
}
