locals {
  region = var.region

  ec2_name = format("%s-ec2", var.name)
  role_name = format("%s-role", var.name)
  ssh_sg_name = format("%s-ssh-sg", var.name)
  http_sg_name = format("%s-http-sg", var.name)
  https_sg_name = format("%s-https-sg", var.name)
  mysql_sg_name = format("%s-mysql-sg", var.name)

  tags = merge(var.tags, { Owner = var.owner, Environment = var.env})

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
  public_subnet_ids = data.terraform_remote_state.vpc.outputs.public_subnet_ids
  azs = data.terraform_remote_state.vpc.outputs.azs
  default_sg_id = data.terraform_remote_state.vpc.outputs.default_security_group_id

  ami_id = data.aws_ami.this.id
  ami_owners = var.ami_owners
  ami_filters = var.ami_filters
//  instance_type = var.instance_type
  key_name = var.key_name

  ssh_sg_description = var.ssh_sg_description
  ssh_ingress_cidr_blocks = var.ssh_ingress_cidr_blocks
  ssh_ingress_rules = var.ssh_ingress_rules
  ssh_egress_rules = var.ssh_egress_rules

  http_sg_description = var.http_sg_description
  http_ingress_cidr_blocks = var.http_ingress_cidr_blocks
  http_ingress_rules = var.http_ingress_rules
  http_egress_rules = var.http_egress_rules

  http_tcp_listeners = var.http_tcp_listeners
  http_tcp_listener_rules = var.http_tcp_listener_rules

  https_sg_description = var.https_sg_description
  https_ingress_cidr_blocks = var.https_ingress_cidr_blocks
  https_ingress_rules = var.https_ingress_rules
  https_egress_rules = var.https_egress_rules

  https_tcp_listeners = var.https_tcp_listeners
  https_tcp_listener_rules = var.https_tcp_listener_rules

  mysql_sg_description = var.mysql_sg_description
  mysql_ingress_cidr_blocks = var.mysql_ingress_cidr_blocks
  mysql_ingress_rules = var.mysql_ingress_rules
  mysql_egress_rules = var.mysql_egress_rules

  mysql_tcp_listeners = var.mysql_tcp_listeners
  mysql_tcp_listener_rules = var.mysql_tcp_listener_rules

  trusted_role_services = var.trusted_role_services
  custom_role_policy_arns = var.custom_role_policy_arns

}