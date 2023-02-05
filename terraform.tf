provider "aws" {
  region = var.aws_region
}

# Create VPC
 
resource "aws_vpc" "miniproject_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "miniproject_vpc"
  }
}

#Internet Gateway

resource "aws_internet_gateway" "miniproject_internet_gateway" {
  vpc_id = aws_vpc.miniproject_vpc.id
  tags = {
     Name = "miniproject_internet_gateway"
  }
}

# Create Public Route Table

resource "aws_route_table" "miniproject-route-table-public" {
  vpc_id = aws_vpc.miniproject_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.miniproject_internet_gateway.id
  }

  tags = {
    Name = "miniproject-route-table-public"
  }
}

# Create First Public Subnet

resource "aws_subnet" "miniproject-public-sub1" {
  vpc_id                  = aws_vpc.miniproject_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "miniproject-public-sub1"
  }
}

# Create Second Public Subnet

resource "aws_subnet" "miniproject-public-sub2" {
  vpc_id                  = aws_vpc.miniproject_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags = {
    Name = "miniproject-public-sub2"
  }
}

# Create Network Acl

resource "aws_network_acl" "miniproject-network_acl" {
  vpc_id     = aws_vpc.miniproject_vpc.id
  subnet_ids = [aws_subnet.miniproject-public-sub1.id, aws_subnet.miniproject-public-sub2.id]

  ingress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}

# Security group for Load Balancer

resource "aws_security_group" "miniproject-load_balancer_sg" {
  name        = "miniproject-load-balancer-sg"
  description = "Security group for project load balancer"
  vpc_id      = aws_vpc.miniproject_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security group to allow port 22, 80 and 443

resource "aws_security_group" "miniproject-sg-rule" {
  name        = "allow_ssh_http_https"
  description = "Allow SSH, HTTP and HTTPS inbound traffic for private instances"
  vpc_id      = aws_vpc.miniproject_vpc.id

  dynamic "ingress" {
    for_each = var.inbound_ports
    content {
      from_port = ingress.value
      to_port   = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      security_groups = [aws_security_group.miniproject-load_balancer_sg.id]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
   
  }

  tags = {
    Name = "miniproject-sg-rule"
  }
}

#





