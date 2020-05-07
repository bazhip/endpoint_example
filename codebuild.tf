module "build" {
    source              = "git::https://github.com/cloudposse/terraform-aws-cicd.git?ref=master"
    namespace           = "endpoint"
    stage               = "test"
    name                = "app"

    # Enable the pipeline creation
    enabled             = true

    # Elastic Beanstalk
    elastic_beanstalk_application_name                 = "endpoint-test-app"
    elastic_beanstalk_environment_name                 = "endpoint-test-env"

    # Application repository on GitHub
    github_oauth_token  = "(Optional) <GitHub Oauth Token with permissions to access private repositories>"
    repo_owner          = "bazhip"
    repo_name           = "endpoint_example"
    branch              = "master"

    # http://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref.html
    # http://docs.aws.amazon.com/codebuild/latest/userguide/build-spec-ref.html
    build_image         = "aws/codebuild/standard:2.0"
    build_compute_type  = "BUILD_GENERAL1_SMALL"

    # These attributes are optional, used as ENV variables when building Docker images and pushing them to ECR
    # For more info:
    # http://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html
    # https://www.terraform.io/docs/providers/aws/r/codebuild_project.html
    privileged_mode     = true
    region              = "us-east-2"
    aws_account_id      = "626890281217"
    image_repo_name     = "endpoint"
    image_tag           = "latest"
}