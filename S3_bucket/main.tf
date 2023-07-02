provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "my_s3_bucket" {
    bucket = "my-s3-bucket-sagar-2-jul-23"
}