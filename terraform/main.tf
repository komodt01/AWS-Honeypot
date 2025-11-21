provider "aws" {
  region = var.aws_region
}

# VPC
resource "aws_vpc" "honeypot_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "honeypot-vpc"
  }
}

# Subnet
resource "aws_subnet" "honeypot_subnet" {
  vpc_id            = aws_vpc.honeypot_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "honeypot-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.honeypot_vpc.id
}

# Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.honeypot_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_rt_assoc" {
  subnet_id      = aws_subnet.honeypot_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Security Group
resource "aws_security_group" "honeypot_sg" {
  name        = "honeypot-sg"
  description = "Allow SSH and web"
  vpc_id      = aws_vpc.honeypot_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# IAM Role and Policy for CloudWatch
resource "aws_iam_role" "ec2_cloudwatch_role" {
  name = "ec2-cloudwatch-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "cloudwatch_attach" {
  role       = aws_iam_role.ec2_cloudwatch_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "honeypot_profile" {
  name = "honeypot-instance-profile"
  role = aws_iam_role.ec2_cloudwatch_role.name
}

# EC2 Instance
resource "aws_instance" "honeypot" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.honeypot_subnet.id
  vpc_security_group_ids      = [aws_security_group.honeypot_sg.id]
  key_name                    = var.key_pair
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.honeypot_profile.name

  user_data = file("${path.module}/cowrie-setup.sh")

  tags = {
    Name = "honeypot-instance"
  }
}

data "aws_availability_zones" "available" {}
