# Terraform Configuration

This directory contains the Terraform configuration for a subset of AWS infrastructure required by the MonolithStarter backend. 
The variables and backend configuration are organized in a directory structure by environment.

The current environments are as follows:

- `stage/` directory: Pre-production resources provisioned in the `validity-dev` account.
- `prod/` directory: Production resources provisioned in the `validity-dev` account (this will eventually move to a separate account).

The Terraform backend is managed by the `remote-state.tf` configuration file in the respective environment directories.
There is currently a single S3 bucket for stage and production resources.

## Prerequisites

The following are required to run Terraform:

- bash
- [Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html) with appropriate credentials to provision resources

NOTE: This currently requires your AWS CLI to be authenticated with the appropriate AWS Account.

If you currently use [Aquaduck](https://github.com/ReturnPath/infrastructure/wiki/Aquaduck), you can use the following
command to authenticate with the appropriate AWS account: `$(aquaduck aws -p validity-dev)`

Otherwise, you can install and configure [aws-mfa-script](https://github.com/asagage/aws-mfa-script) to authenticate as
follows: `mfa <MFA code> validity-dev`

## Deploying

You will need to select a WORKSPACE before the terraform plan or apply commands can run successfully. The Workflow is as
follows:

For shared resources between `stage` and `prod` (e.g. the ECR repository and EB application):

```
$ cd shared
$ terraform init
$ terraform plan
$ terraform apply
```

For stage:

```
$ cd stage
$ terraform init
$ terraform workspace select stage-us-east-1
$ terraform plan
$ terraform apply
```

For prod:

```
$ cd prod
$ terraform init
$ terraform workspace select prod-us-east-1
$ terraform plan
$ terraform apply
```
