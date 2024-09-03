output "cloudfront_id" {
  value = aws_cloudfront_distribution.cloud_resume_challenge.domain_name
}

output "cloudfront_zone" {
  value = aws_cloudfront_distribution.cloud_resume_challenge.hosted_zone_id
}
