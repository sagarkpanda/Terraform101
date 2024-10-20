# Provider configuration
provider "aws" {
  region = "ap-south-1"
}

# VPC
resource "aws_vpc" "sagar_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "sagar-vpc"
  }
}

# Internet Gateway for Public Subnet
resource "aws_internet_gateway" "sagar_igw" {
  vpc_id = aws_vpc.sagar_vpc.id
  tags = {
    Name = "sagar-igw"
  }
}

# Public Subnet
resource "aws_subnet" "sagar_public_subnet" {
  vpc_id            = aws_vpc.sagar_vpc.id
  cidr_block        = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1a"
  tags = {
    Name = "sagar-public-subnet"
  }
}

# Private Subnet
resource "aws_subnet" "sagar_private_subnet" {
  vpc_id            = aws_vpc.sagar_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "sagar-private-subnet"
  }
}

# public Route Table for igw
resource "aws_route_table" "sagar_public_rt" {
  vpc_id = aws_vpc.sagar_vpc.id
  tags = {
    Name = "sagar-public-rt"
  }
}

# Tag the main RT for identification, check data.tf for the filter
resource "null_resource" "tag_main_rt" {
  provisioner "local-exec" {
    command = "aws ec2 create-tags --resources ${data.aws_route_table.main.id} --tags Key=Name,Value='sagar_vpc_pvt_rt' --region ap-south-1"
  }

  # This ensures the command runs only when the main route table is created
  depends_on = [aws_vpc.sagar_vpc]
}


# Route for Public Subnet to access Internet via Public IGW
resource "aws_route" "sagar_public_internet_access" {
  route_table_id         = aws_route_table.sagar_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.sagar_igw.id
}

# Associate Public Subnet with the new Public Route Table
resource "aws_route_table_association" "sagar_public_subnet_assoc" {
  subnet_id      = aws_subnet.sagar_public_subnet.id
  route_table_id = aws_route_table.sagar_public_rt.id
}

# Modify Default Security Group (Renaming using Tags and Adding Rules)
resource "aws_default_security_group" "common_sg" {
  vpc_id = aws_vpc.sagar_vpc.id

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow inbound ICMP traffic (Ping) from any IP address"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH from anywhere (you can restrict this)"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = " Allow HTTP from anywhere"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = " Allow HTTP from anywhere"
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "For xyz app"
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "common_sg"  # Tagging as "common_sg"
  }
}

# EC2 Instance in Public Subnet
resource "aws_instance" "sagar_public_instance" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.sagar_public_subnet.id
  vpc_security_group_ids = [aws_default_security_group.common_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "sagar-public-ec2"
  }
}

# EC2 Instance in Private Subnet
resource "aws_instance" "sagar_private_instance" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.sagar_private_subnet.id
  vpc_security_group_ids = [aws_default_security_group.common_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "sagar-private-ec2"
  }
}

