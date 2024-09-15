resource "aws_s3_bucket" "cloud_resume_challenge" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "cloud_resume_challenge" {
  bucket = aws_s3_bucket.cloud_resume_challenge.id
  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "cloud_resume_challenge" {
  bucket = aws_s3_bucket.cloud_resume_challenge.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = "*",
        Action = "s3:GetObject",
        Resource = "${aws_s3_bucket.cloud_resume_challenge.arn}/*",
      },
    ],
  })
}

resource "aws_s3_object" "website" {
  bucket = aws_s3_bucket.cloud_resume_challenge.id
  key = "index.html"
  source = "website/index.html"
  content_type = "text/html"
  source_hash = filemd5("website/index.html")
}

resource "aws_s3_object" "website_style" {
  bucket = aws_s3_bucket.cloud_resume_challenge.id
  key = "resume.css"
  source = "website/resume.css"
  content_type = "text/css"
  source_hash = filemd5("website/resume.css")
}

resource "aws_s3_object" "website_js" {
  bucket = aws_s3_bucket.cloud_resume_challenge.id
  key = "counter.js"
  source = "website/counter.js"
  content_type = "text/javascript"
  source_hash = filemd5("website/counter.js")
}

resource "aws_s3_object" "website_404" {
  bucket = aws_s3_bucket.cloud_resume_challenge.id
  key = "404.html"
  source = "website/404.html"
  content_type = "text/html"
  source_hash = filemd5("website/404.html")
}

resource "aws_s3_bucket_website_configuration" "cloud_resume_challenge" {
  bucket = aws_s3_bucket.cloud_resume_challenge.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}
