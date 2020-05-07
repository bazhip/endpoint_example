module "elastic_beanstalk_application" {
  source      = "git::https://github.com/cloudposse/terraform-aws-elastic-beanstalk-application.git?ref=tags/0.3.0"
  namespace  = "endpoint"
  stage      = "test"
  name       = "app"
  description = "Test elastic_beanstalk_application"
}

module "elastic_beanstalk_environment" {
  source                             = "git::https://github.com/cloudposse/terraform-aws-elastic-beanstalk-environment.git?ref=master"
  namespace                          = "endpoint"
  stage                              = "test"
  name                               = "env"
  description                        = "Test elastic_beanstalk_environment"
  region                             = "us-east-2"
  availability_zone_selector         = "Any 2"
  dns_zone_id                        = "Z07719552AERLXLM0PUSK"
  elastic_beanstalk_application_name = module.elastic_beanstalk_application.elastic_beanstalk_application_name

  instance_type           = "t3.micro"
  autoscale_min           = 1
  autoscale_max           = 1
  updating_min_in_service = 0
  updating_max_batch      = 1

  loadbalancer_type       = "application"
  vpc_id                  = module.vpc.vpc_id
  loadbalancer_subnets    = module.subnets.public_subnet_ids
  application_subnets     = module.subnets.private_subnet_ids
  allowed_security_groups = [module.vpc.vpc_default_security_group_id]

  // https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html
  // https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html#platforms-supported.docker
  solution_stack_name = "64bit Amazon Linux 2 v3.0.1 running Docker"
}