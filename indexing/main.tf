provider "aws" {
  region = "us-east-1"
}
resource "aws_iam_user" "my_iam_users" {
  count = 3
  name  = "iam_user_${count.index}"
}