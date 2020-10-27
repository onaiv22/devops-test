provider "aws" {
  region  = var.region
  version = "2.60"
  profile = var.profile

}

module "vpc" {
   source = "./modules/networking"
   cidr_block = var.vpc_cidr
   region     = var.region
}
