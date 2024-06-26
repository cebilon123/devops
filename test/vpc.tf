module "vpc" {
  source       = "../modules/vpc"
  PROJECT_NAME = "test"
  #   it means that the first 16 bits are const
  VPC_CIDR              = "10.0.0.0/16"
  PRIVATE_SUBNETS_COUNT = 2
  PUBLIC_SUBNETS_COUNT  = 1
}
