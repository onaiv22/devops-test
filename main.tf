provider "aws" {
  region  = var.region
  version = "2.60"
  profile = var.profile

}

module "vpc" {
   source = "./modules/vpc"
   cidr_block = var.vpc_cidr
   region     = var.region
   //tags       = var.tags
}

module "subnets" {
   source     = "./modules/networking"
   networks   = var.networks
   vpc_id     = module.vpc.vpc_id
   cidr_block = var.networks
   region     = var.region
   profile    = var.profile
   gw_id      = module.vpc.vpc_gw

}

module "alb" {
   source                  = "./modules/application_alb"
   vpc_id                  = module.vpc.vpc_id
   balancer_subnets        = module.subnets.subnet_id
   idle_timeout            = var.idle_timeout
}
