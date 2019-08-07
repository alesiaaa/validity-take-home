resource "aws_iam_instance_profile" "monolithstarter_ec2_instance" {
    name = "${var.environment_name}-${var.region}-elasticbeanstalk-ec2-instance-role"
    role = aws_iam_role.monolithstarter_ec2_instance.name
}

resource "aws_iam_role" "monolithstarter_ec2_instance" {
    name        = "${var.environment_name}-${var.region}-eb-ec2-instance-role"
    description = "IAM Role for monolithstarter Elastic Beanstalk EC2 instances in ${var.environment_name} ${var.region}"
    tags        = local.common_tags

    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eb_web_tier" {
    policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
    role       = aws_iam_role.monolithstarter_ec2_instance.name
}

resource "aws_iam_role_policy_attachment" "eb_multicontainer_docker" {
    policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
    role       = aws_iam_role.monolithstarter_ec2_instance.name
}

resource "aws_iam_role_policy_attachment" "eb_workier_tier" {
    policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"
    role       = aws_iam_role.monolithstarter_ec2_instance.name
}

resource "aws_iam_role_policy_attachment" "ecr_read_only" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    role       = aws_iam_role.monolithstarter_ec2_instance.name
}
