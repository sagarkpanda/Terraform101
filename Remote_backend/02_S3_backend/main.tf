provider "aws" {
  region = "ap-south-1"
}


resource "aws_s3_bucket" "office_backend_state" {
    bucket = "xyz-applications-backend-state-sagar-18thsept"

    lifecycle {
        prevent_destroy = true # make it false to be able to destory S3 bucket
    }

}

resource "aws_s3_bucket_versioning" "S3_with_versioning" {
  bucket = aws_s3_bucket.office_backend_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "Bucket_encryption" {
  bucket = aws_s3_bucket.office_backend_state.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

//Locking - Dynamo DB

resource "aws_dynamodb_table" "office_backend_lock" {
    name = "xyz_application_locks"
    billing_mode = "PAY_PER_REQUEST"

    hash_key = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }

}
