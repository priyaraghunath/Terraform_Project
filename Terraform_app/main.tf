# Provider Block
provider "aws" {
  region = var.aws_region
}

# VPC Module
module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
}

# Security Group Module
module "security_group" {
  source  = "./modules/security_group"
  vpc_id  = module.vpc.vpc_id
}

# EC2 Module
module "ec2" {
  source             = "./modules/EC2"
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  subnet_ids         = module.vpc.subnet_ids
  security_group_id  = module.security_group.security_group_id
}

# Elastic Load Balancer (ELB) Module
module "elb" {
  source             = "./modules/elb"
  subnet_ids         = module.vpc.subnet_ids
  security_group_id  = module.security_group.security_group_id
  instance_ids       = module.ec2.instance_ids
  vpc_id             = module.vpc.vpc_id
}


