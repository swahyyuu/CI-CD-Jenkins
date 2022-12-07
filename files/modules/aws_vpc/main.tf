resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_vpc
  enable_dns_hostnames = true

  tags = {
    Name = "VPC Terraform"
  }
}

resource "aws_subnet" "subnet_1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.cidr_subnet_1
  availability_zone = var.az_subnet_1

  tags = {
    Name = "Subnet AZ A"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.cidr_subnet_2
  availability_zone = var.az_subnet_2

  tags = {
    Name = "Subnet AZ B"
  }
}

resource "aws_subnet" "subnet_3" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.cidr_subnet_3
  availability_zone = var.az_subnet_3

  tags = {
    Name = "Subnet AZ C"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "IGW VPC Terraform"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    "Name" = "Route Table Terraform"
  }
}

resource "aws_route_table_association" "rt1" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "rt2" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "rt3" {
  subnet_id      = aws_subnet.subnet_3.id
  route_table_id = aws_route_table.route_table.id
}
