provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "my_s3_bucket" {
    bucket = "my-s3-bucket-sagar-16-jul-23"
}

resource "aws_iam_user" "my_iam_users" {
  name  = "test_iam"
}

# update the IAM user name

/* resource "aws_iam_user" "my_iam_users" {
  name  = "test_iam_updated"
}
*/