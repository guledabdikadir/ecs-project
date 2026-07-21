module "vpc" {
  source = "./modules/vpc"
}

module "ecr" {
  source = "./modules/ecr"
}

module "acm" {
  source = "./modules/acm"
}

module "alb" {
  source          = "./modules/alb"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.public_subnet_ids
  certificate_arn = module.acm.certificate_arn
  hosted_zone_id  = var.hosted_zone_id
  domain_name     = var.domain_name
}

module "ecs" {
  source           = "./modules/ecs"
  subnet_ids       = module.vpc.public_subnet_ids
  vpc_id           = module.vpc.vpc_id
  alb_sg_id        = module.alb.alb_sg_id
  ecr_image_url    = module.ecr.repository_url
  target_group_arn = module.alb.target_group_arn
}
