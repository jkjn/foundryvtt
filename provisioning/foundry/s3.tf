resource "aws_s3_bucket" "foundry_data" {
  bucket = "${var.default_prefix}-foundry-data"
}