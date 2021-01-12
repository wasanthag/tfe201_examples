provider "aws" {
  region = "us-east-1"
}

data "aws_subnet_ids" "all" {
  vpc_id = var.vpc_id
  tags = {
    Name = "ATC-Routable"
  }
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  name        = "mci-3tier-app"
  description = "Security group for example usage with EC2 instance"
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "rdp-tcp", "all-icmp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 5000
      to_port     = 5000
      protocol    = "tcp"
      description = "flask-service port"
      cidr_blocks = "0.0.0.0/0"
    }]
  egress_rules        = ["all-all"]
}

module "ec2-instance" {
  source  = "tfe.wwtmci.com/finance/ec2-instance/aws"
  version = "~> 2.0"

  instance_count = 1

  name     = "web"
  key_name = var.ec2_key
  ami                         = var.ami_id
  instance_type               = var.machine_type
  subnet_id                   = tolist(data.aws_subnet_ids.all.ids)[0]
  vpc_security_group_ids      = [module.security_group.this_security_group_id]
  associate_public_ip_address = false

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 40
    },
  ]

  tags = {
    "Env"      = "MCI-AWS-PROD"
    "Location" = "AWS-US-EAST-1"
  }
}

