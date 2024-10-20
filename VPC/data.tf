# data source to filter the main RT which is created automaticaly with the vpc

data "aws_route_table" "main" {
  vpc_id = aws_vpc.sagar_vpc.id

  filter {
    name   = "association.main"
    values = [true]
  }
}

# data source of az linux 2023
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
