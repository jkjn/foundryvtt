resource "aws_s3_bucket" "foundry_data" {
  bucket = "${var.default_prefix}-foundry-data"

  tags = {
    "application" = "foundry"
    "environment" = var.environment
  }
}

resource "aws_s3_bucket_acl" "foundry_data" {
  bucket = aws_s3_bucket.foundry_data.id
  acl    = "public-read-write"
}

resource "aws_s3_bucket_policy" "foundry_data" {
  bucket = aws_s3_bucket.foundry_data.id
  policy = templatefile("${path.module}/policies/s3.json", {
    s3_bucket_arn = aws_s3_bucket.foundry_data.arn
  })
}

resource "aws_s3_bucket_ownership_controls" "foundry_data" {
  bucket = aws_s3_bucket.foundry_data.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_versioning" "foundry_data" {
  bucket = aws_s3_bucket.foundry_data.id
  
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "foundry_data" {
  bucket = aws_s3_bucket.foundry_data.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "foundry_data" {
  bucket = aws_s3_bucket.foundry_data.id

  rule {
    id = "data"

    noncurrent_version_expiration {
      noncurrent_days = 60
    }

    status = "Enabled"
  }

  depends_on = [aws_s3_bucket_versioning.foundry_data]
}

resource "aws_s3_bucket_cors_configuration" "foundry_data" {
  bucket = aws_s3_bucket.foundry_data.id

  cors_rule {
    allowed_methods = ["GET", "POST", "HEAD"]
    allowed_origins = ["*"]
    allowed_headers = ["*"]
    expose_headers  = []
    max_age_seconds = 3000
  }
}