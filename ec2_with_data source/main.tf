provider "aws" {
  region = "ap-south-1"
}

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "vm_sg" {
  name = "vm_server_sg"
  #   vpc_id = "vpc-090dfe974036c99c4"
  vpc_id = aws_default_vpc.default.id

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

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my_sg"
  }
}

resource "aws_instance" "test_machine" {
  # ami = "ami-013e83f579886baeb"
  ami                    = data.aws_ami.amazon_linux_2023.id
  key_name               = "test"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.vm_sg.id]
  # subnet_id              = "subnet-018e9f41175289d9c"
  subnet_id = data.aws_subnets.default_subnets.ids[2]

  tags = {
    Name = "My Test VM"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.ssh_key)
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",
      "sudo service httpd start",
      "echo Welcome to OpenTofu - Virtual Server is at ${self.public_dns} | sudo tee /var/www/html/index.html"
    ]
  }

}