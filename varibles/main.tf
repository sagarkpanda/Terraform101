variable "iam_user_prefix" {
  default = "labputer_user"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_iam_user" "my_iam_users" {
  count = 2
  name  = "${var.iam_user_prefix}_${count.index}"
}