 #creating first instance

resource "aws_instance" "miniproject1" {
  ami             = ami-00874d747dde814fa
  instance_type   = "t2.micro"
  key_name        = "mini"
  security_groups = [aws_security_group.miniproject-sg-rule.id]
  subnet_id       = aws_subnet.miniproject-public-sub1.id
  availability_zone = "us-east-1"

  tags = {
    Name   = "miniproject-1"
    source = "terraform"
  }
}

# creating second instance

 resource "aws_instance" "miniproject2" {
  ami             = ami-00874d747dde814fa
  instance_type   = "t2.micro"
  key_name        = "mini"
  security_groups = [aws_security_group.miniproject-sg-rule.id]
  subnet_id       = aws_subnet.miniproject-public-sub2.id
  availability_zone = "us-east-1"

  tags = {
    Name   = "miniproject-2"
    source = "terraform"
  }
}

# creating third instance

resource "aws_instance" "miniproject3" {
  ami             = ami-00874d747dde814fa
  instance_type   = "t2.micro"
  key_name        = "mini"
  security_groups = [aws_security_group.miniproject-sg-rule.id]
  subnet_id       = aws_subnet.miniproject-public-sub1.id
  availability_zone = "us-east-1"

  tags = {
    Name   = "miniproject-3"
    source = "terraform"
  }
}

# Create a file to store instances IP addresses

resource "local_file" "Ip_address" {
  filename = "/vagrant/terraform/inventory"
  content  = <<EOT
${aws_instance.miniproject1.public_ip}
${aws_instance.miniproject2.public_ip}
${aws_instance.miniproject3.public_ip}
  EOT
}

