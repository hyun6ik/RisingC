terraform {
  backend "s3" {
    bucket = "hyun6ik-rising-camp"
    key = "rds/terraform.tfstate"
    region = "ap-northeast-2"
    max_retries = 3
  }
}