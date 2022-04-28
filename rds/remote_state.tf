data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = var.backend_s3
    key = var.vpc_key
    region = var.region
  }
}

data "terraform_remote_state" "ec2" {
  backend = "s3"
  config = {
    bucket = var.ec2_backend_s3
    key = var.ec2_vpc_key
    region = var.region
  }
}