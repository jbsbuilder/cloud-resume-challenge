resource "aws_s3_bucket" "cloud_resume_challenge" {
  bucket = var.bucket_name

}


resource "aws_s3_bucket_acl" "cloud_resume_challenge" {
  bucket = aws_s3_bucket.cloud_resume_challenge.id
  acl = var.acl
}

resource "aws_s3_bucket_website_configuration" "cloud_resume_challenge" {
  bucket = aws_s3_bucket.cloud_resume_challenge.id

  index_document {
    suffix = "index.html"
  }

  # error_document {
  #   404.html
  # }
}

resource "aws_s3_bucket_policy" "cloud_resume_challenge" {
  bucket = aws_s3_bucket.cloud_resume_challenge.id
  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
          "Sid": "PublicReadGetObject",
          "Effect": "Allow",
          "Principal": "*",
          "Action": [
              "s3:GetObject"
          ],
          "Resource": [
              "arn:aws:s3:::${var.bucket_name}/*"
            ]
        }
    ]
  }
EOF

 depends_on = [
    aws_s3_bucket.cloud_resume_challenge,
    aws_s3_bucket_acl.cloud_resume_challenge,
    aws_s3_bucket_website_configuration.cloud_resume_challenge
  ]
}

