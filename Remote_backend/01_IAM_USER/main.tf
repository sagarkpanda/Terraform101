terraform {
    backend "s3" {
        bucket = "xyz-applications-backend-state-sagar-18thsept"
        key = "xyz/backend-state/IAM/backend-state"
        region = "ap-south-1"
        dynamodb_table = "xyz_application_locks"
        encrypt = true
    }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_iam_user" "my_iam_users" {
  name  = "test_iam_18_sept_23"
}
