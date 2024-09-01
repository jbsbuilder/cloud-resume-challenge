resource "aws_s3_bucket" "cloud-resume-challenge" {
  bucket = var.bucket_name
}

# resource "aws_s3_bucket_lifecycle_configuration" "cloud-resume-challenge" {
#     bucket = aws_s3_bucket.cloud-resume-challenge.id
#     prevent_destroy = true
# }

resource "aws_s3_bucket_versioning" "cloud-resume-challenge" {
  bucket = aws_s3_bucket.cloud-resume-challenge.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "cloud-resume-challenge" {
  bucket = aws_s3_bucket.cloud-resume-challenge.id
  acl = var.acl
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cloud-resume-challenge" {
  bucket = aws_s3_bucket.cloud-resume-challenge.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "cloud-resume-challenge" {
  bucket = aws_s3_bucket.cloud-resume-challenge.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
