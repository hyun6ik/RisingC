module "rds" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "hyun6ik"

  # All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
  engine               = "mysql"
  engine_version       = "8.0.28"
  family               = "mysql8.0" # DB parameter group
  major_engine_version = "8.0"      # DB option group
  instance_class       = "db.t3.micro"

  allocated_storage     = 20
  max_allocated_storage = 100

  db_name  = "rising"
  username = "admin"

  port     = 3306

  create_db_instance = true
  create_monitoring_role = false
  create_db_subnet_group = true
  create_random_password = false
  publicly_accessible = true

  multi_az               = true
  subnet_ids             = data.terraform_remote_state.vpc.outputs.public_subnet_ids
  vpc_security_group_ids = [module.security_group.security_group_id]
  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    },
    {
      name = "character_set_results"
      value = "utf8mb4"
    },
    {
      name = "character_set_filesystem"
      value = "utf8mb4"
    },
    {
      name = "character_set_database"
      value = "utf8mb4"
    },
    {
      name = "character_set_connection"
      value = "utf8mb4"
    },
    {
      name  = "time_zone"
      value = "asia/seoul"
    },
    {
      name = "collation_server"
      value = "utf8mb4_general_ci"
    },
    {
      name = "collation_connection"
      value = "utf8mb4_general_ci"
    }
  ]

}


module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "db security"
  description = "Complete MySQL example security group"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access from within VPC"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

}