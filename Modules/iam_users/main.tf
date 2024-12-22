provider "aws" {
    region = "ap-south-1"
}

locals {
    iam_user_prefix = "my_iam_user"
}

resource "aws_iam_user" "my_iam_user" {
    name = "${local.iam_user_prefix}_${var.environment}"
}
