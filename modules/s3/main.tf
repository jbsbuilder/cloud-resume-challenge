resource "aws_s3_bucket" "static" {
  bucket        = var.bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_policy" "static_policy" {
  bucket = aws_s3_bucket.static.id
  policy = templatefile("template/s3-bucket-policy.json", { bucket = var.bucket_name })
}

resource "aws_s3_bucket_acl" "static_acl" {
  bucket = aws_s3_bucket.static.id
  acl    = "public-read"
}

resource "aws_s3_bucket_cors_configuration" "static_cors" {
  bucket = aws_s3_bucket.static.id

  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["*"]
    max_age_seconds = 10
  }
}

resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = aws_s3_bucket.static.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}

output "website_endpoint" {
  value = aws_s3_bucket.static.bucket_regional_domain_name
}

resource "aws_s3_bucket" "root_static" {
  bucket        = "root-${var.bucket_name}"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "root_static_policy" {
  bucket = aws_s3_bucket.root_static.id
  policy = templatefile("template/s3-bucket-policy.json", { bucket = "root-${var.bucket_name}" })
}

resource "aws_s3_bucket_acl" "root_static_acl" {
  bucket = aws_s3_bucket.root_static.id
  acl    = "public-read"
}

resource "aws_s3_bucket_cors_configuration" "root_static_cors" {
  bucket = aws_s3_bucket.root_static.id

  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["*"]
    max_age_seconds = 10
  }
}

resource "aws_s3_bucket_website_configuration" "root_static_website" {
  bucket = aws_s3_bucket.root_static.id

  redirect_all_requests_to {
    host_name = aws_s3_bucket.static.bucket_regional_domain_name
  }
}

output "website_endpoint_root" {
  value = aws_s3_bucket.root_static.bucket_regional_domain_name
}

