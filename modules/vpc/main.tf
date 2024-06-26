resource "aws_vpc" "vpc" {
  cidr_block                       = var.VPC_CIDR
  instance_tenancy                 = "default"
  enable_dns_hostnames             = true
  enable_dns_support               = true
  assign_generated_ipv6_cidr_block = false

  tags = {
    Name = "${var.PROJECT_NAME}-vpc"
  }
}

locals {
  private_subnet_cidrs = cidrsubnets(var.VPC_CIDR, var.PRIVATE_SUBNETS_COUNT)
  public_subnet_cidrs  = cidrsubnets(var.VPC_CIDR, var.PUBLIC_SUBNETS_COUNT)

}

resource "aws_subnet" "private_subnet" {
  for_each   = { for i, cidr in local.private_subnet_cidrs : i => cidr }
  vpc_id     = aws_vpc.vpc.id
  cidr_block = each.value

  tags = {
    Name = "${var.PROJECT_NAME}-private-subnet-${each.value}"
  }
}

# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.vpc.id

#   tags = {
#     "name" = "${var.PROJECT_NAME}-igw"
#   }
# }

# resource "aws_route_table" "public_rt" {
#   vpc_id = aws_vpc.vpc.id
#   route = [
#     {
#       cidr_block = "0.0.0.0/0"
#       gateway_id = aws_internet_gateway.igw.id
#     }
#   ]


#   tags = {
#     Name = "${var.PROJECT_NAME}-public-rt"
#   }
# }

resource "aws_subnet" "public_subnet" {
  for_each                = { for i, cidr in local.public_subnet_cidrs : i => cidr }
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.PROJECT_NAME}-public-subnet-${each.value}"
  }
}

# resource "aws_route_table_association" "public_association" {
#   subnet_id      = aws_subnet.public_subnet.id
#   route_table_id = aws_route_table.public_rt.id
# }

