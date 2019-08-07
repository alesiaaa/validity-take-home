resource "aws_elastic_beanstalk_application" "monolithstarter" {
    name = "monolithstarter"

    tags = {
        name        = "MonolithStarter Elastic Beanstalk application"
        product     = "monolithstarter"
        owner       = "patnewell"
        team        = "silver-team"
        lifecycle   = "terraform"
        repo_name   = "validityhq/MonolithStarter"
    }
}
