# resource "aws_s3_bucket" "cloud_resume_challenge" {
#   bucket = var.bucket_name
# }

# resource "aws_s3_bucket_acl" "cloud_resume_challenge" {
#   bucket = aws_s3_bucket.cloud_resume_challenge.id
#   acl = var.acl

# locals {
#   s3_origin_id = "website"
#   }
# }
resource "aws_cloudfront_distribution" "cloud_resume_challenge" {
  origin {
    domain_name = var.domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.cloud_resume_challenge.id
    origin_id = var.s3_static_bucket_id
  }
    enabled             = true
    is_ipv6_enabled     = true
    comment             = "website"
    default_root_object = "index.html"
  
  aliases = ["cloudresumechallenge.cloudsmithlabs.com"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.s3_static_bucket_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    }

  viewer_certificate {
    acm_certificate_arn = var.acm_certificate_arn
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }
  }

}


resource "aws_cloudfront_origin_access_control" "cloud_resume_challenge" {
  name = "website"
  origin_access_control_origin_type = "s3"
  signing_behavior = "always"
  signing_protocol = "sigv4"
}
