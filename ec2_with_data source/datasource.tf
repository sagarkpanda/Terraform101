data "aws_subnets" "default_subnets" {
  filter {
    name   = "vpc-id"
    values = [aws_default_vpc.default.id]
  }
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }

 filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_ami_ids" "aws_linux_2023_latest_ids" {
  owners = ["amazon"]
}
