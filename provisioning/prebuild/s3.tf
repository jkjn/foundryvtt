resource "aws_s3_bucket" "configuration" {
  bucket = "${var.default_prefix}-foundry-config"

  tags = {
    "application" = "foundry"
    "environment" = var.environment
  }
}

resource "aws_s3_bucket_acl" "configuration" {
  bucket = aws_s3_bucket.configuration.id
  acl    = "private"
}

resource "aws_s3_bucket_ownership_controls" "configuration" {
  bucket = aws_s3_bucket.configuration.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_versioning" "configuration" {
  bucket = aws_s3_bucket.configuration.id
  
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "configuration" {
  bucket = aws_s3_bucket.configuration.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "configuration" {
  bucket = aws_s3_bucket.configuration.id

  rule {
    id = "configuration"

    noncurrent_version_expiration {
      noncurrent_days = 60
    }

    status = "Enabled"
  }

  depends_on = [aws_s3_bucket_versioning.configuration]
}