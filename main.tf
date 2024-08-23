provider "aws" {
  region  = var.aws_region
#   access_key = var.aws_access_key_id
#   secret_key = var.aws_secret_access_key
  version = "2.60"
  profile = var.profile

}

module "vpc" {
   source = "./modules/vpc"
   cidr_block = var.vpc_cidr
   region     = var.aws_region
}

module "subnets" {
   source     = "./modules/networking"
   networks   = var.networks
   vpc_id     = module.vpc.vpc_id
   cidr_block = var.networks
   region     = var.aws_region
   profile    = var.profile
   gw_id      = module.vpc.vpc_gw

}

module "alb" {
   source                  = "./modules/application_alb"
   vpc_id                  = module.vpc.vpc_id
   balancer_subnets        = module.subnets.subnet_id
   idle_timeout            = var.idle_timeout
   instance_type           = var.instance_type
   ami_id                  = var.ami_id
}
