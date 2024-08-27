output "s3_distribution" {
  value = {
    domain_name    = aws_cloudfront_distribution.s3_distribution.domain_name
    hosted_zone_id = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
  }
}
