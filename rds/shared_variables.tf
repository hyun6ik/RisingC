variable "backend_s3" {
  default = "hyun6ik-rising-camp"
}

variable "region" {
  default = "ap-northeast-2"
}

variable "vpc_key" {
  default = "s3-backend/terraform.tfstate"
}


variable "ec2_backend_s3" {
  default = "hyun6ik-rising-camp"
}


variable "ec2_vpc_key" {
  default = "ec2/terraform.tfstate"
}
