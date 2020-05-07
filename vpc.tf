module "vpc" {
  source     = "git::https://github.com/cloudposse/terraform-aws-vpc.git?ref=tags/0.8.0"
  namespace  = "endpoint"
  stage      = "test"
  name       = "vpc"
  cidr_block = "172.16.0.0/16"
}

module "subnets" {
  source                  = "git::https://github.com/cloudposse/terraform-aws-dynamic-subnets.git?ref=tags/0.16.0"
  availability_zones      = ["us-east-2a","us-east-2b"]
  namespace               = "endpoint"
  stage                   = "test"
  name                    = "subnet"
  vpc_id                  = module.vpc.vpc_id
  igw_id                  = module.vpc.igw_id
  cidr_block              = module.vpc.vpc_cidr_block
  map_public_ip_on_launch = true
}