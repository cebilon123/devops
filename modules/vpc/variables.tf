variable "VPC_CIDR" {
  description = "cidr block for the vpc network"
}

variable "PROJECT_NAME" {
  description = "project name in which vpc is used"
}

variable "PRIVATE_SUBNETS_COUNT" {
  description = "count of private subnets"
  type        = number
}

variable "PUBLIC_SUBNETS_COUNT" {
  description = "count of public subnets"
  type        = number
}
