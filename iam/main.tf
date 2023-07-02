provider "aws" {
  region = "ap-south-1"
}
resource "aws_iam_user" "my_iam_users" {
  name  = "sagar-iam"
}