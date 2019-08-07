resource "aws_ecr_repository" "monolithstarter" {
    name = "monolithstarter"

    tags = {
        name        = "MonolithStarter ECR repository"
        product     = "monolithstarter"
        owner       = "patnewell"
        team        = "silver-team"
        lifecycle   = "terraform"
        repo_name   = "validityhq/MonolithStarter"
    }
}
