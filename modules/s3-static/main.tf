resource "aws_s3_bucket" "cloud-resume-challenge" {
  bucket = var.bucket_name

}


resource "aws_s3_bucket_acl" "cloud-resume-challenge" {
  bucket = aws_s3_bucket.cloud-resume-challenge.id
  acl = var.acl
}

resource "aws_s3_bucket_website_configuration" "cloud-resume-challenge" {
  bucket = aws_s3_bucket.cloud-resume-challenge.id

  index_document {
    suffix = "index.html"
  }

  # error_document {
  #   404.html
  # }
}

resource "aws_s3_bucket_policy" "cloud-resume-challenge" {
  bucket = aws_s3_bucket.cloud-resume-challenge.id
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
}
