module "ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = local.ec2_name

  ami = local.ami_id
  key_name = local.key_name
//  instance_type = local.instance_type
  availability_zone = element(local.azs, 1)
  subnet_id = element(local.public_subnet_ids, 1)
  vpc_security_group_ids = [module.ssh.security_group_id, module.http.security_group_id, module.https.security_group_id, module.mysql.security_group_id, local.default_sg_id]
  iam_instance_profile = module.iam.iam_instance_profile_name
  associate_public_ip_address = true

  user_data  = data.template_file.userdata.rendered
  tags = local.tags
}

module "ssh" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name = local.ssh_sg_name
  description = local.ssh_sg_description
  vpc_id = local.vpc_id

  ingress_cidr_blocks = local.ssh_ingress_cidr_blocks
  ingress_rules = local.ssh_ingress_rules
  egress_rules = local.ssh_egress_rules

  tags = local.tags
}

module "http" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = local.http_sg_name
  description = local.http_sg_description
  vpc_id      = local.vpc_id

  ingress_cidr_blocks = local.http_ingress_cidr_blocks
  ingress_rules       = local.http_ingress_rules
  egress_rules        = local.http_egress_rules

  tags = local.tags
}

module "https" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = local.https_sg_name
  description = local.https_sg_description
  vpc_id      = local.vpc_id

  ingress_cidr_blocks = local.https_ingress_cidr_blocks
  ingress_rules       = local.https_ingress_rules
  egress_rules        = local.https_egress_rules

  tags = local.tags
}

module "mysql" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = local.mysql_sg_name
  description = local.mysql_sg_description
  vpc_id      = local.vpc_id

  ingress_cidr_blocks = local.mysql_ingress_cidr_blocks
  ingress_rules       = local.mysql_ingress_rules
  egress_rules        = local.mysql_egress_rules

  tags = local.tags
}

module "iam" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 4.3"

  create_role = true
  create_instance_profile = true
  role_name = local.role_name
  role_requires_mfa = false

  trusted_role_services = local.trusted_role_services
  custom_role_policy_arns = local.custom_role_policy_arns
}