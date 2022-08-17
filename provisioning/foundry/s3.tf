resource "aws_s3_bucket" "foundry" {
  bucket = "${var.default_prefix}-foundry-data"

  tags = {
    "application" = "foundry"
    "environment" = var.environment
  }
}

resource "aws_s3_bucket_acl" "foundry" {
  bucket = aws_s3_bucket.foundry.id
  acl    = "public"
}

resource "aws_s3_bucket_ownership_controls" "foundry" {
  bucket = aws_s3_bucket.foundry.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_versioning" "foundry" {
  bucket = aws_s3_bucket.foundry.id
  
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "foundry" {
  bucket = aws_s3_bucket.foundry.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "foundry" {
  bucket = aws_s3_bucket.foundry.id

  rule {
    id = "data"

    noncurrent_version_expiration {
      noncurrent_days = 60
    }

    status = "Enabled"
  }

  depends_on = [aws_s3_bucket_versioning.foundry]
}