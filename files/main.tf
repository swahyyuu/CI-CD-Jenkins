data "aws_caller_identity" "current" {}

module "aws_terra_vpc" {
  source = "./modules/aws_vpc"
}

module "aws_terra_instance" {
  source = "./modules/aws_instance"
  depends_on = [
    module.aws_terra_vpc
  ]

  vpc_id      = module.aws_terra_vpc.vpc_id
  subnet_id_1 = module.aws_terra_vpc.subnet_id_1
  subnet_id_2 = module.aws_terra_vpc.subnet_id_2
  subnet_id_3 = module.aws_terra_vpc.subnet_id_3
  account_id  = data.aws_caller_identity.current.account_id
  sg_ec2      = module.aws_terra_lb_sg.sg_ec2
  elb_id      = module.aws_terra_lb_sg.elb_id
}

module "aws_terra_lb_sg" {
  source = "./modules/aws_lb_sg"
  depends_on = [
    module.aws_terra_vpc
  ]

  vpc_id      = module.aws_terra_vpc.vpc_id
  subnet_id_1 = module.aws_terra_vpc.subnet_id_1
  subnet_id_2 = module.aws_terra_vpc.subnet_id_2
  subnet_id_3 = module.aws_terra_vpc.subnet_id_3
}
